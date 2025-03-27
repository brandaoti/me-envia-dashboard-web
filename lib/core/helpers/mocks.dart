import 'package:maria_me_envia_mobile_admin_web/core/core.dart';

abstract class Mocks {
  static const User user = User(
    id: '63d05a7-e845-4992',
    type: UserType.user,
    cpf: '48666015403',
    phoneNumber: '73982811395',
    email: 'hello_word@examplo.com',
    name: 'Isabella Pietra Lopes',
    address: Address(
      state: 'Bahia',
      number: '456',
      street: 'rua',
      city: 'Salvador',
      country: 'Brasil',
      zipcode: '45810000',
      neighborhood: 'Amaralina',
      complement: 'Piatã - Colina de Piatã',
    ),
  );

  static const Customers custome = Customers(
    totalItems: 56,
    name: 'Thais Alonso',
    id: '363d05a7-e845-4992-9639',
  );

  static CustomersList customesList = [
    custome,
    custome,
    custome,
    custome,
    custome,
    custome,
    custome,
    custome,
    custome,
    custome,
    custome,
  ];

  static const Declaration declaration = Declaration(
    name: 'item #1',
    category: 'Games',
    description: 'Naruto',
    quantity: 3,
    totalValue: 50.0,
    unitaryValue: 150.0,
  );

  static Box packageItem = Box(
    id: '87eaf316-51d5-4448-8121-5cbfdf28a186',
    name: 'Pacote Top',
    media:
        'http://dev-static-mariameenvia.cubos.dev/4aae0708-6e25-4da3-a598-382e904a3f2e.jpeg',
    userId: '363d05a7-e845-4992-9639-4be6df1f04d1',
    description: '',
    createdAt: DateTime(2020, 02, 20),
  );

  static PackageStatus step = PackageStatus(
    step: PackageStep.send,
    type: PackageType.success,
  );

  static Package packageInfo = Package(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    declarationList: [declaration],
    dropShipping: false,
    shippingFee: null,
    trackingCode: null,
    paymentVoucher: null,
    lastPackageUpdateLocation: null,
    id: '69ccaddd-ea5f-4f9e-801d-cd710727cb10',
    paymentStatus: PaymentStatus.notPaid,
    status: 'Aguardando Taxa',
    step: step.step,
    type: step.type,
    userId: '',
    receiverCpf: '',
    receiverName: '',
  );

  static CustomersPackage package = CustomersPackage(
    user: user,
    stepList: [step],
    packageItem: [packageItem],
    totalItems: 1,
    packageInfo: packageInfo,
  );

  static CustomersPackage packages = CustomersPackage.fromJson({
    'user': {
      'userInfo': {
        'id': '69ccaddd-ea5f-4f9e-801d-cd710727cb10',
        'name': 'João Silva',
        'email': 'matheus.hofstede+43@cubos.io',
        'cpf': '44722959463',
        'phoneNumber': '99 99999 9999'
      },
      'address': [
        {
          'city': 'Salvador',
          'state': 'BA',
          'cep': '42636000',
          'neighborhood': 'Sussuarana',
          'street': 'Avenida',
          'country': 'Brasil'
        }
      ],
      'step': [
        {'step': 'NOT_SENT', 'type': 'WARNING'}
      ],
      'items': {
        'totalItems': 1,
        'itemsOnPackage': [
          {
            'name': 'Pacote top',
            'media':
                'file:///dev-static-mariameenvia.cubos.dev/4aae0708-6e25-4da3-a598-382e904a3f2e.jpeg'
          }
        ]
      },
      'packageInfo': {
        'id': '69ccaddd-ea5f-4f9e-801d-cd710727cb10',
        'createdAt': '2021-08-24T12:24:21.957Z',
        'trackingCode': 'LB299323591HK',
        'paymentVoucher': null,
        'status': 'Aguardando Taxa',
        'shippingFee': '12',
        'declaration': [
          {
            'name': 'Item #1',
            'category': 'Games',
            'description': 'God of war 1, 2 e 3',
            'quantity': 3,
            'unitaryValue': 5000.0,
            'totalValue': 15000.0,
          }
        ],
        'userId': '69ccaddd-ea5f-4f9e-801d-cd710727cb10',
        'dropShipping': false,
        'paymentStatus': 'PAYMENT_NOT_PAID',
        'step': 'NOT_SENT',
        'type': 'WARNING',
        'lastPackageUpdateLocation': 'Brasilia/BR'
      }
    }
  });
}
