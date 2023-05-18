// ignore_for_file: no_leading_underscores_for_local_identifiers

import '/application/infrastructure/http/entities/http_statuscodes.dart';

class HttpMessages {
  List<Map<String, dynamic>> messages = [
    {'code': HttpStatusCode.success, 'message': 'success message'},
    {'code': HttpStatusCode.created, 'message': 'created message'},
    {'code': HttpStatusCode.noContent, 'message': 'no content message'},
    {'code': HttpStatusCode.badRequest, 'message': 'bad request message'},
    {'code': HttpStatusCode.unAuthorized, 'message': 'unauthorized message'},
    {'code': HttpStatusCode.forbidden, 'message': 'forbidden message'},
    {'code': HttpStatusCode.notFound, 'message': 'not found message'},
    {'code': HttpStatusCode.internalServerError,'message': 'internal error message'},
  ];

  getStatusMessage(HttpStatusCode code) {
    try {
      List<Map<String, dynamic>> _message = messages.where((e) => e['code'] == code).toList();

      return _message[0]['message'].toString();
    } catch (e) {
      return 'Código de retorno não encontrado.';
    }
  }
}
