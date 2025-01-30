import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:apidash_core/apidash_core.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/io.dart';

class WebSocketClient {
  late WebSocketChannel _channel;
  StreamSubscription? _subscription;
  Duration? pingInterval;
 

  WebSocketClient();

  
  Future<(String?,DateTime?)> connect(String url,List<NameValueModel>? headers,List<NameValueModel>? params) async {
    print("inside client connect");
    try {
      
      String urlWithParams = getValidRequestUri(url,params,defaultUriScheme:SupportedUriSchemes.wss).$1.toString();
      if(!kIsWeb){
        final WebSocket ioWebSocket = await WebSocket.connect(
          urlWithParams,
          headers: headers != null ? rowsToMap(headers)! : null);
        _channel = IOWebSocketChannel(ioWebSocket);
        
        ioWebSocket.pingInterval = pingInterval;
         
      }else{
        _channel = WebSocketChannel.connect(Uri.parse(urlWithParams));
      }
      await _channel.ready;
      print('Connected to WebSocket server: ${url}');
      return (kMsgConnected,DateTime.now());
      } catch (e) {
      print('Failed to connect to WebSocket server: $e');
      return (e.toString(),DateTime.now());
    }
  }

  
  Future<(String?,DateTime?,String?)> sendText(String message)async {
    try{
      _channel.sink.add(message);
      // websocketRequestModel.frames.add(WebSocketFrameModel(
      //   id: '1',
      //   message: websocketRequestModel.message!,
      //   timeStamp: DateTime.now(),
      // ));
      log('Sent text message: $message}');
      return (message,DateTime.now(),null);

    }catch(e){
      return (null,DateTime.now(),e.toString());

    }
    
  }

   Future<(String?,DateTime?,String?)> sendBinary(String message)async {
    try{
      Uint8List binary = Uint8List.fromList(utf8.encode(message));

      _channel.sink.add(binary);
      // websocketRequestModel.frames.add(WebSocketFrameModel(
      //   id: '1',
      //   message: websocketRequestModel.message!,
      //   timeStamp: DateTime.now(),
      // ));
      log('Sent text message: $message}');
      return (message,DateTime.now(),null);

    }catch(e){
      return (null,DateTime.now(),e.toString());

    }
    
  }
  
  Future<void> listen(Future<void> Function(dynamic message) onMessage,
      {Future<void> Function(dynamic error)? onError, Future<void> Function()? onDone,bool? cancelOnError}) async{
    _subscription = _channel.stream.listen(
      (message) {
        onMessage(message);
      },
      onError: (error) {
        if (onError != null) onError(error);
      },
      onDone: () {
        if (onDone != null) onDone();
      },
      cancelOnError: cancelOnError ?? true,
    );
  }

  
  Future<void> disconnect({int closeCode = status.normalClosure, String? reason})async {
    _subscription?.cancel();
    _channel.sink.close(closeCode, reason);
    log('Disconnected from WebSocket server');
  }
}

