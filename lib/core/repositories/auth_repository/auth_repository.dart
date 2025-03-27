import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import '../../core.dart';

abstract class AuthRepository {
  Future<User> getUser();

  Future<UserItems> getUserItems({required String userId});
  Future<MariaTipsList> getMariaTips();

  Future<CustomersList> getAllCustomers();

  Future changedPassword({String newPassword, String token});
  Future<void> forgotPassword(String email);

  Future<String> login(LoginRequest loginRequest);
  Future<CreateNewUserResponse> createUser(CreateNewUser newUser);

  Future<void> createPackage({
    required String userId,
    required CreateItem item,
  });

  Future<void> createPackageMultiItem({
    required String userId,
    required List<CreateItem> items,
  });

  Future<UserPackageList> getUserPackage({
    UserParameters section = UserParameters.created,
  });

  Future<int> getTotalItens();

  Future<CustomersPackage> getPackage({required String packageId});

  Future<UpdatePackage> updatePackage({
    required String packageId,
    required UpdatePackage update,
  });

  Future<void> createHint({
    String? hintId,
    required CreateHints createHints,
  });

  Future<void> deleteHint({
    required String tipsId,
  });

  Future<MariaInformation> getMariaInformation({
    MariaInformationParams params = MariaInformationParams.whoIsMaria,
  });

  Future<List<Faq>> getAllFaq();

  Future<void> updateLearnMore({
    required CreateLearnMore updateLearnMore,
    required MariaInformationParams options,
  });

  Future<void> deleteFaq({required String faqId});

  Future<void> createFaq({
    String? faqId,
    required CreateNewFaq createFaq,
  });

  Future<double> getBilling({
    required ReportInterval interval,
  });

  Future<int> getTotalCustomers({
    required ReportInterval interval,
  });

  Future<ReportStatusList> getReportStatus({
    required ReportInterval interval,
  });

  Future<ReportBoxs> getAllReport({
    required ReportInterval interval,
  });

  Future<Uint8List> downloadProofOfPayment({
    required String urlFile,
    required DownloadFileProgress progress,
  });

  Future<double> getQuotation();

  Future<void> createNewDollarQuotation(double money);
}

class AuthRepositoryImpl extends RepositoryErrorHandling
    implements AuthRepository {
  final ApiClient apiClient;
  final PutFileService service;

  const AuthRepositoryImpl({
    required this.apiClient,
    required this.service,
  });

  @override
  Future changedPassword({String? newPassword, String? token}) async {
    try {
      await apiClient.instance.post(
        '/forgot_password?token=$token',
        data: {'newPassword': newPassword},
      );
    } on DioError catch (error) {
      throw super.mappingDioErrors('createUser', error);
    } catch (error) {
      throw Failure(message: Strings.errorUserCreationFailed);
    }
  }

  @override
  Future<CreateNewUserResponse> createUser(CreateNewUser newUser) async {
    try {
      final response = await apiClient.instance.post(
        '/admins',
        data: newUser.toMap(),
      );

      return CreateNewUserResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('createUser', error);
    } catch (error) {
      throw Failure(message: Strings.errorUserCreationFailed);
    }
  }

  @override
  Future<String> login(LoginRequest loginRequest) async {
    try {
      final response = await apiClient.instance.post(
        '/admins/auth',
        data: loginRequest.toMap(),
      );

      return response.data['token'];
    } on DioError catch (error) {
      throw super.mappingDioErrors('login', error);
    } catch (error) {
      throw Failure(message: Strings.errorUserCreationFailed);
    }
  }

  @override
  Future<User> getUser() async {
    try {
      final response = await apiClient.instance.get('/users/me');

      return User.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getUser', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUserCreationFailed,
      );
    }
  }

  @override
  Future<CustomersPackage> getPackage({required String packageId}) async {
    try {
      final response =
          await apiClient.instance.get('/admins/packages/$packageId');

      return CustomersPackage.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getPackageUser', error);
    } catch (error) {
      print(error);
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final data = Map.from({'email': email});
      await apiClient.instance.post('/users/request-new-password', data: data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('forgotPassword', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<CustomersList> getAllCustomers() async {
    try {
      final response = await apiClient.instance.get('/users');

      final listOfCustomes = (response.data as List);

      return listOfCustomes.map((json) => Customers.fromJson(json)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors('getUser', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUserCreationFailed,
      );
    }
  }

  @override
  Future<UserItems> getUserItems({required String userId}) async {
    try {
      final response = await apiClient.instance.get('/users/$userId');
      return UserItems.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getUser', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<void> createPackage({
    required String userId,
    required CreateItem item,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': item.name ?? '',
        'description': item.description ?? '',
      });

      final putFile = item.media as PutFileImage?;

      if (putFile != null) {
        formData.files.add(MapEntry('media', await _getMultipartFile(putFile)));
      }

      await apiClient.instance.post('/admins/items/$userId', data: formData);
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<void> createPackageMultiItem({
    required String userId,
    required List<CreateItem> items,
  }) async {
    try {
      final futures = items.map((it) {
        return Future.value(createPackage(item: it, userId: userId));
      }).toList();

      await Future.wait(futures);
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<UpdatePackage> updatePackage({
    required String packageId,
    required UpdatePackage update,
  }) async {
    try {
      final response = await apiClient.instance.put(
        '/admins/packages/$packageId',
        data: update.toMap(),
      );

      return UpdatePackage.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getPackageUser', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<UserPackageList> getUserPackage({
    UserParameters section = UserParameters.created,
  }) async {
    try {
      final response =
          await apiClient.instance.get('/admins/packages${section.fromApi}');
      final result = (response.data['users'] as List);

      return result.map((it) => UserPackage.fromJson(it)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<int> getTotalItens() async {
    try {
      final response = await apiClient.instance.get(
        '/admins/packages${UserParameters.created.fromApi}',
      );
      final result = (response.data['users'] as List);

      return result.fold<int>(0, (value, json) {
        final String? count = json['count'];
        if (count != null) {
          return int.parse(count) + value;
        }
        return value;
      });
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<MariaTipsList> getMariaTips() async {
    try {
      final response = await apiClient.instance.get('/users/hints');
      final tipList = (response.data['allHints']) as List;

      return tipList.map((json) => MariaTips.fromJson(json)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors(
        'getMariaTips',
        error,
      );
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<void> createHint({
    String? hintId,
    required CreateHints createHints,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...createHints.toApi(),
      });

      final putFile = createHints.putFile as PutFileImage?;

      if (putFile != null) {
        formData.files.add(MapEntry('media', await _getMultipartFile(putFile)));
      }

      if (hintId == null) {
        await apiClient.instance.post('/admins/hints', data: formData);
      } else {
        await apiClient.instance.put('/admins/hints/$hintId', data: formData);
      }
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  Future<MultipartFile> _getMultipartFile(PutFileImage putFile) async {
    final multipartFile = MultipartFile.fromBytes(
      putFile.bytes!,
      filename: putFile.randomFilename,
      contentType: MediaType.parse(putFile.mediaType),
    );

    return multipartFile;
  }

  @override
  Future<void> deleteHint({required String tipsId}) async {
    try {
      await apiClient.instance.delete('/admins/hints/$tipsId');
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<MariaInformation> getMariaInformation({
    MariaInformationParams params = MariaInformationParams.whoIsMaria,
  }) async {
    try {
      final response = await apiClient.instance.get(
        '/learn-more',
        queryParameters: params.toQueryParams,
      );

      return MariaInformation.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getMariaInformation', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<List<Faq>> getAllFaq() async {
    try {
      final response = await apiClient.instance.get(
        '/learn-more',
        queryParameters: MariaInformationParams.faq.toQueryParams,
      );

      return (response.data as List).map((it) => Faq.fromJson(it)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors('getAllFaq', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<void> updateLearnMore({
    required CreateLearnMore updateLearnMore,
    required MariaInformationParams options,
  }) async {
    try {
      final formData = FormData.fromMap(
        updateLearnMore.toMap(),
      );

      final putFile = updateLearnMore.media;

      if (putFile != null) {
        formData.files.add(MapEntry(
          'picture',
          await _getMultipartFile(putFile),
        ));
      }

      await apiClient.instance.put(
        '/admins/learn-more',
        data: formData,
        queryParameters: options.toQueryParams,
      );
    } on DioError catch (error) {
      throw super.mappingDioErrors('updateLearnMore', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<void> deleteFaq({required String faqId}) async {
    try {
      await apiClient.instance.delete('/admins/faq/$faqId');
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<void> createFaq({
    String? faqId,
    required CreateNewFaq createFaq,
  }) async {
    try {
      if (faqId == null) {
        await apiClient.instance.post(
          '/admins/faq',
          data: createFaq.toMap(),
        );
      } else {
        await apiClient.instance.put(
          '/admins/faq/$faqId',
          data: createFaq.toMap(),
        );
      }
    } on DioError catch (error) {
      throw super.mappingDioErrors('createFaq', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<double> getBilling({
    required ReportInterval interval,
  }) async {
    try {
      final response = await apiClient.instance.get(
        '/admins/report/billings',
        queryParameters: interval.toMap(),
      );

      final result = (response.data['report'] as List)
          .map<String>((it) => it['total'] ?? '0')
          .toList();

      return result.fold<double>(0, (value, it) => double.parse(it) + value);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getReport', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<int> getTotalCustomers({
    required ReportInterval interval,
  }) async {
    try {
      final response = await apiClient.instance.get(
        '/admins/report/users',
        queryParameters: interval.toMap(),
      );

      final data = response.data['report']['totalUsers'] as List;
      final result = data.map<String>((it) => it['count']).toList();

      return result.fold<int>(0, (value, it) => int.parse(it) + value);
    } on DioError catch (error) {
      throw super.mappingDioErrors('getReport', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<ReportStatusList> getReportStatus({
    required ReportInterval interval,
  }) async {
    try {
      final response = await apiClient.instance.get(
        '/admins/report/packages',
        queryParameters: interval.toMap(),
      );

      final data = response.data['report'] as List;
      return data.map((it) => ReportStatus.fromJson(it)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors('getReport', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<ReportBoxs> getAllReport({
    required ReportInterval interval,
  }) async {
    try {
      final result = await Future.wait([
        getBilling(interval: interval),
        getUserPackage(section: UserParameters.paid),
        getReportStatus(interval: interval),
        getTotalCustomers(interval: interval),
      ]);

      final status = result[2] as ReportStatusList;
      final customersPackages = result[1] as UserPackageList;

      return ReportBoxs(
        status: status,
        billing: result.first as double,
        totalCustomers: result.last as int,
        paymentReceived: customersPackages.paymentReceived,
        paymentToReceive: customersPackages.paymentToReceive,
      );
    } on DioError catch (error) {
      throw super.mappingDioErrors('getReport', error);
    } catch (error) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }
  }

  @override
  Future<void> createNewDollarQuotation(double money) async {
    try {
      await apiClient.instance.put(
        '/admins/quotation',
        data: Map.from({'text': money}),
      );
    } on DioError catch (error) {
      throw super.mappingDioErrors('', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<double> getQuotation() async {
    try {
      final response = await apiClient.instance.get('/quotation');

      final data = response.data['getDollarRate'];
      final dollarText = (data['text'] as String).replaceAll(',', '.');

      return double.parse(dollarText);
    } on DioError catch (error) {
      throw super.mappingDioErrors('', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<Uint8List> downloadProofOfPayment({
    required String urlFile,
    required DownloadFileProgress progress,
  }) async {
    try {
      final response = await apiClient.instance.get(
        urlFile,
        onReceiveProgress: progress,
        options: Options(responseType: ResponseType.bytes),
      );

      return Uint8List.fromList(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors('createPackage', error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }
}
