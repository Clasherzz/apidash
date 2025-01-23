import 'dart:developer';

import 'package:apidash_core/models/websocket_request_model.dart';
import 'package:apidash_core/services/clientWrapper.dart' as http;
import 'package:apidash_core/services/websocket_service.dart';
import 'package:http/http.dart' as http;

abstract class clientWrapper {
  void close() {}
  Future<void> sendText(WebSocketRequestModel websocketRequestModel )async{
    throw UnimplementedError('sendText is not implemented for this client type.');
  }
}

class HttpClientWrapper extends clientWrapper {
  final http.Client client;
  HttpClientWrapper(this.client);
   @override
  void close() {
    log("cancelling under rest");
    client.close(); 
  }
}

class WebSocketClientWrapper extends clientWrapper {
  final WebSocketClient client;
  WebSocketClientWrapper(this.client);
  @override
  void close() {
    log("cancelling under websocket");
    client.disconnect(); 
  }
  Future<void> sendText(WebSocketRequestModel websocketRequestModel) async{
    client.sendText(websocketRequestModel);
  }
  
}
