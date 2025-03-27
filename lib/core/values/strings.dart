// Defines all strings from the project

abstract class Strings {
  static const appName = 'Maria Me envia';

  //validators errors
  static const errorEmailInvalid = 'E-mail inválido';
  static const errorLinkInvalid = 'Link inválido';
  static const errorTipTitleInvalid = 'Título muito curto';
  static const errorEmailEmpty = 'Insira seu e-mail';
  static const errorPasswordEmpty = 'Insira sua senha';
  static const errorPasswordTooShort = 'Senha muito curta';
  static const errorConfirmPassword = 'As senhas não podem ser diferentes';
  static const errorWrongPassword = 'Senha incorreta.';
  static const errorEmptyField = 'Campo obrigatório';
  static const errorUserNotFound = 'Usuário não encontrado';
  static const errorMoneyInvalid = 'Insira um valor maior que zero';

  static const orderHeaderTabs = [
    'itens recebidos',
    'caixas solicitadas',
    'pagamento pendente',
    'caixas enviadas',
  ];

  // Inputs Label Text
  static const cpfInputLabelText = 'CPF:';
  static const zipCodeInputLabelText = 'CEP';
  static const phoneInputLabelText = 'Telefone:';
  static const ok = 'ok';

  //Requested boxes
  static const addTrackinkCode = 'Adicionar código de rastreio';
  static const trackYourBox = 'Acompanhe suas caixas';
  static const insertCode = 'Inserir código';
  static const addTrackingCode = 'Adicionar Código de Rastreio';
  static const trackingCodeModalButtonHint = 'Código de Rastreio';
  static const avaliableItemText =
      'Monte sua caixa com os itens disponíveis abaixo';
  static const selectAllItem = 'Sel. Todos';
  static const noSent = 'Nenhuma caixa solicitada';
  static const noSentBox = 'Nenhuma caixa solicitada para envio';
  static const noPaymentBox = 'Nenhuma caixa pendente para pagamento';
  static const noStockBox = 'Nenhuma caixa criada';
  static const noRequestBox = 'Nenhuma caixa foi solicitada';
  static const noPaymentPedengBox = 'Não há pagamentos pendente';
  static const noSendBox = 'Nenhuma caixa foi enviada';
  static const awaitPackageLastLocation = 'Aguardando localização';
  static const noOrderItemText =
      'Faça suas compras em suas lojas de preferência de qualquer lugar do mundo e envie para o nosso endereço';
  static String selectedAllItems(int count) => count == 0
      ? 'Nada selecionado'
      : '$count ${count > 1 ? 'itens' : 'item'}  na caixa';

  //Auth Errors
  static const errorRequiredUserAdmin =
      'Necessário ser Admin para criar um item';
  static const errorUserCreationFailed = 'Email ou senha inválidas';
  static const errorEmailNotVerified =
      'Confirme seu email para continua, te enviamos um email de confirmação';
  static const errorAlreadyRegisteredUser =
      'Já existe um usuário cadastrado com essas credenciais';
  static const errorAdminSecurityCodeInvalid = 'Código de segurança inválido';
  static const errorEmailNotExists =
      'Não existe usuário cadastrado com esse email';
  static const errorUnknownInApi =
      'Ocorreu um erro inesperado, por favor tente novamente';
  static const errorUnauthorizedPackage = 'Não autorizado';
  static const errorNotFoundPackage = 'Pacote não encontrado';
  static const errorNotCreateItem = 'Não é possível criar item sem uma foto.';

  // Home
  static const helloAdm = 'Olá Adm!';
  static const welcomeShippingManager = 'Bem-vindo ao gerenciador de envios';
  static const initialDate = 'Do dia';
  static const finalDate = 'Até';
  static const payments = 'Pagamentos';
  static const revenues = 'Faturamento';
  static const received = 'Recebido';
  static const receivable = 'A receber';
  static const reportStatus = [
    'Solicitadas',
    'Aguardando pagamento',
    'Aguardando envio',
    'Finalizadas',
  ];

  // Nav Bar
  static const navBarScreenNames = [
    'Home',
    'Caixas',
    'Clientes',
    'Dicas',
    'Geral',
    'Sair',
  ];
  static const customTabBarNames = [
    'Solicitação',
    'Pagamento',
    'Envio',
  ];

  //forgotPassword
  static const retrieveYourPasswordText = 'Recupere sua senha';
  static const retrieveYourPasswordEmailTitleText = 'E-mail enviado!';
  static const retrieveYourPasswordContentText =
      'Confira seu e-mail para acessar o link de recuperação de senha';
  static const forgotPasswordButtonTitleConfirm = 'Confirmar';

  //button Strings
  static const loadingButtonText = 'Carregando...';
  static const loginButtonTitle = 'Login';
  static const registerButtonTitle = 'Cadastre-se';
  static const forgotPasswordButtonTitle = 'Esqueci minha senha';
  static const forgotPasswordButtonTitleSend = 'Enviar';
  static const searchButton = 'Ir';

  //Requested boxes
  static const requestedBoxTitle = 'Caixas';
  static const tableId = 'ID';
  static const boxId = 'ID da Caixa';
  static const tableCustomer = 'Clientes';
  static const tableItens = 'Itens na caixa';
  static const requestedBoxSubtitle =
      'Acompanhe aqui as suas caixas solicitadas, aguardando aprovação e enviadas';
  static const fee = 'Taxa';
  static const status = 'Status';

  // Sent Boxes
  static const trackingCode = 'Código';
  static const tracking = 'Rastreio';

  //maria Tips
  static const mariaTipsHeaderTitle = 'Dicas';
  static const createNewTip = 'Criar dica';
  static const editCurrentTip = 'Editar dica';
  static const mariaTipsHeaderSubtitle =
      'Acompanhe aqui as suas dicas postadas par todos os usuários';
  static const photoFileUploadTitleTips =
      'Insira aqui uma foto para a capa da dica';
  static const confirm = 'Confirmar';
  static const removeTips = 'Remover dica';
  static const errorUpdateTips = 'Alterar pelos um campo';
  static const errorEditTipsMessage = 'Edite pelso menos um campo';

  static const Map<int, List<String>> mariaTipsState = {
    0: [
      'Dica criada com sucesso!',
      'A dica já está disponível no seu aplicativo Maria Me Envia'
    ],
    1: [
      'Dica editada com sucesso!',
      'A edição já está disponível no seu aplicativo Maria Me Envia'
    ],
    2: [
      'Dica removida com sucesso!',
      'A dica já foi removida do seu aplicativo Maria Me Envia'
    ],
  };
  //tab bar

  static const feedbackButtonBoxListEmpty =
      'Acompanhe aqui os itens selecionados';
  static const feedbackButtonCreatePackage =
      'Clique aqui para concluir a criação da caixa';
  static const tabBarTexts = [
    'Home',
    'Maria me envia',
    'Saiba Mais',
  ];

  //input Strings
  static const nameInputLabelText = 'Nome Completo';
  static const emailInputLabelText = 'E-mail';
  static const titleInputLabelText = 'Título';
  static const linkInputLabelText = 'Link';
  static const descriptionInputLabelText = 'Descrição';
  static const helperInputLabelText = 'Opcional';
  static const passwordInputLabelText = 'Senha';
  static const codeInputLabelText = 'Código de segurança';
  static const passwordConfirmationInputLabelText = 'Confirmar senha';
  static const forgotPasswordInputHelperText = 'Insira seu e-mail de Cadastro';
  static const insertFee = 'Inserir taxa';
  static const finishInsertFee = 'Concluir';
  static const insertFeeAndShipping = 'Taxa do serviço e frete';
  static const addFee = 'Adicionar Taxa';

  // Registration
  static const registrationCompleted = 'Cadastro concluído';
  static const timeToBoxOrders = 'Hora de encaixotar pedidos!';

  static const resgitrationHeaderTitle = 'Cadastro';
  static const nextProgress = 'Próximo';
  static const finishRegistration = 'Concluir';
  static const cancel = 'Cancelar';
  static const errorRegistrationFailure =
      'Por favor, altere os dados e tente novamente.';

  //No Connection
  static const toUpdate = 'Atualizar';
  static const tryAgain = 'Tentar Novamente';
  static const closeToApp = 'Sair do Aplicativo';
  static const errorConnectionTitle = 'Ocorreu um erro';
  static const errorConnectionSubtitle =
      'Não foi possível carregar as informações.\nVerifique sua conexão e tente novamente';

  // Customes
  static const clientTitle = 'Clientes';
  static const itemsInStock = 'Itens no estoque';
  static const itemsInBox = 'Itens na Caixa';
  static const followYourRegisteredCustomers =
      'Acompanhe aqui o estoque dos seus clientes cadastrados';
  static const informationAboutTheBox = 'Informações gerais sobre a caixa';

  //Create Items
  static const addItem = 'Adicionar item';
  static const generalInformations = 'Informações gerais';
  static const noItemsRegistrationInStock = 'Nenhum item cadastrado no estoque';
  static const photoFileUploadName = 'Foto';
  static const photoFileOpenError = 'Formato inválido';
  static const photoFileUploadTitle = 'Inserir fotos';
  static const addMoreOneFile = 'Selecione pelos menos um arquivo';
  static const errorFileMaxSize = 'Selecione um arquivo menor que 10MB';
  static const addeItems = 'Adicionar itens';
  static const addeNewItems = 'Adicionar item';
  static const deleteNewItems = 'Remover item';
  static const itemsAdded = 'Itens adicionado!';
  static const itemAddedMessage =
      'O item já está disponível no app Maria Me Envia para seu cliente';

  // Order Screen
  static const onePhotoAttached = '1 foto anexada';
  static const orderScreenTitle = 'Seus itens no nosso estoque';
  static const orderScreenSubtitle = 'Selecione o que deseja enviar';
  static const streetInputLabelText = 'Endereço';
  static const noStockItem = 'Nenhum item no estoque';
  static String boxItemName(int index) => 'Item #${index.toString()}';

  // Section User information component
  static String boxTitle(String id) => 'Caixa #$id';
  static String sectionUserEmail(String value) => 'E-mail: $value';
  static const sectionUserTypeLabel = ['Dados gerais', 'Endereço'];

  //Section Package Item
  static const packageItemText = 'Itens na caixa';
  static const sectionCustomsDeclarationTitle = 'Declaração Aduaneira';
  static const boxNoItemRegisteredTitle =
      'Nenhum ítem cadastrado na declaração aduaneira';
  static const sectionTitle = 'Insira o título desta seção';
  static const sectionSubtitle = 'Caixas > Caixa em detalhes';
  static const sectionSubtitle2 = 'Informações gerais sobre a caixa';

  static String customsDeclarationItemValue(String value, bool isTotalValue) =>
      isTotalValue ? 'Valor total: $value' : 'Valor unitário: $value';

  static String customsDeclarationItemTitle(String id, String unity) =>
      'Item #$id - $unity Unidades';
  //

  static String customsTotalDeclared(String value) =>
      'Total declarado: U\$$value';

  // Package Details
  static const String shippingFee = 'Taxa de Serviço';
  static const String shippingFeeAmount = 'Valor da taxa e frete';
  static const String addfee = 'Valor da taxa e frete';
  static const String saveChangesBtn = 'Salvar alterações';
  static const String trackingCodeTitle = 'Rastreio';
  static const String trackingCodeLabel = 'Código de rastreio';
  static const String paymentTitle = 'Pagamento';
  static const String awaitProofOfPayment = 'Aguardando comprovante';
  static const String recusePayment = 'Recusar';
  static const String approvePayment = 'Aprovar';
  static const String savePaymentFilePath = '/MariaMeEnvia';
  static const String errorInDownloadPaymentFile =
      'Error desconhecido ao baixar o comprovante, por favor tente novamente.';
  static List<String> paymentStatusMessage = [
    'Comprovante de pagamento',
    'Aguardando aprovação',
    'Comprovante aprovado',
    'Comprovante recusado',
  ];

  static const String inStock = 'No estoque';
  static const String noStatusRegistered = 'Nenhum status registrado';
  static String paymenteStatus(bool isPending) =>
      isPending ? 'Pendente' : 'Aprovar';

  // Date format
  static const brazilianMonthAbreviation = {
    DateTime.january: 'jan',
    DateTime.february: 'fev',
    DateTime.april: 'abr',
    DateTime.may: 'mai',
    DateTime.june: 'jun',
    DateTime.july: 'jul',
    DateTime.august: 'ago',
    DateTime.september: 'set',
    DateTime.october: 'out',
    DateTime.november: 'nov',
    DateTime.december: 'dez',
  };

  //input Strings
  static const newPasswordInputLabelText = 'Nova senha';
  static const searchInputLabelText = 'Buscar';
  //forgotPassword
  static const newPassword = 'Nova Senha';
  static const newPasswordCreated = 'Nova senha criada!';
  static const guardNewPassword =
      'Guarde sua senha em um lugar seguro e boas compras!';

  // Dollar Quotation
  static const dollarOfDay = 'Dolár do dia';
  static const quoteLabelText = 'Cotação do dolár';
  static const addQuoteOfDay = 'Adicionar cotação\nde hoje';
  static final addQuoteOfDayModal = addQuoteOfDay.replaceAll('\n', '');

  //General information
  static String sectionEditTitle(String value) => 'Editar - $value';
  static String sectionCreateFaqTitle = 'Adicionar $faqTitle';

  static const faqTitle = 'FAQ';
  static const feesTitle = 'Taxas e volume';
  static const volumeTitle = 'Volume';
  static const serviceTitle = 'Valor do frete';
  static const whoIsMariaTitle = 'Quem sou eu';
  static const createNewFaqTitleBtn = 'Criar nova';
  static const costOfFreightTitle = 'Valor do frete';

  // Show modal message
  static const modalSectionMariaInformationTitle =
      'Informação editada com sucesso!';
  static const modalSectionMariaInformationMessage =
      'Já está disponível no app Maria Me Envia para seu cliente';
  static const modalSectionFaqTitle = 'FAQ adicionada com sucesso!';
  static const modalSectionFaqMessage = modalSectionMariaInformationMessage;
  static const modalAddedItemTitle = 'Item adicionado com sucesso!';
  static const modalAddedItemMessage =
      'O item já está disponível no app Maria Me Envia para seu cliente';

  // Empty box Illustration
  static const noCustomsDeclaration = 'Declaração pendente';
  static const noRegisteredCustomer = 'Nenhum cliente cadastrado';
  static const noTipaCreated = 'Nenhuma dica cadastrada';
  static const noBoxRequested = 'Nenhuma caixa solicitada até o momento';

  // Contact
  static const enterInContact = 'Entrar em Contato';
  static const contentTitles = ['Maria\n', 'Me Envia'];
  static const contentSubtitle =
      'Seu shopping center virtual, compre o que você quiser, de qualquer lugar do mundo e a gente te envia.';
  static const contentAddressTitle = 'Nosso endereço de envio';
  static const contentAddressSubtitles = [
    '1628 ',
    'Elizabeths Walk -',
    ' Winter Park, 32789'
  ];
  static const talkToMe = 'Precisa fala com a gente?';
  static const location = 'Localização';
  static const send = 'Enviar';
  static const phoneAddress = '+1 832-591-8581';
  static const maryHelena = 'Maria Helena';
  static const maryHelenaDescription = 'Fundadora do Maria Me Envia';
  static const copyright = '© 2021 Maria Me Envia';
  static const storeLinksApp = [
    'https://play.google.com/store/apps/details?id=br.com.mariameenvia',
    'https://apps.apple.com/us/app/maria-me-envia/id1580379108'
  ];
  static const socialMediaLinks = [
    'https://www.instagram.com/mariameenvia/?hl=en',
    'https://t.me/mariameenvia',
  ];
  static const whatsAppContact =
      'https://api.whatsapp.com/send?phone=+18325918581&text=Maria+Me+Envia';
  static const addressMary =
      'https://www.google.com.br/maps/place/1628+Elizabeths+Walk/@28.579953,-81.3354074,17z/data=!4m6!3m5!1s0x88e76555d3fc3af9:0xe70ade0df318a9a2!4b1!8m2!3d28.5799099!4d-81.3348275';

  static const sendMailServiceApiUrl =
      'https://api.emailjs.com/api/v1.0/email/send';
  static const erroSendFeedbackMail = 'Erro ao enviar messagem';
}
