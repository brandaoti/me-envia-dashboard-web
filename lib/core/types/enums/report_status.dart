enum ReportStatusType {
  awaitingFee,
  awaitingPayment,
  paymentAccept,
  objectDelivered,
}
const _mappinReportStatus = {
  'Enviado': ReportStatusType.objectDelivered,
  'Aguardando Taxa': ReportStatusType.awaitingFee,
  'Pagamento Aprovado!': ReportStatusType.paymentAccept,
  'Aguardando o pagamento!': ReportStatusType.awaitingPayment,
  'Pagamento sujeito a confirmação!': ReportStatusType.awaitingPayment,
  'Objeto entregue ao destinatário': ReportStatusType.objectDelivered,
};

const _mappinReportMessageStatus = {
  ReportStatusType.objectDelivered: 'Enviado',
  ReportStatusType.awaitingFee: 'Aguardando Taxa',
  ReportStatusType.paymentAccept: 'Pagamento Aprovado!',
  ReportStatusType.awaitingPayment: 'Aguardando o pagamento!',
};

extension ReportStatusTypeExtension on ReportStatusType {
  String get fromReportStatusMessage {
    return _mappinReportMessageStatus[this] ?? 'Aguardando Taxa';
  }
}

extension JsonReportStatusTypeExtension on String {
  ReportStatusType get fromReportStatusType {
    return _mappinReportStatus[this] ?? ReportStatusType.objectDelivered;
  }
}
