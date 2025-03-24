import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../consts.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import 'http_service.dart';

typedef SSEStreamController = StreamController<String>;

typedef OnSSEListen = void Function(SSEStreamController controller);
typedef OnSSEError = void Function(Object error);

Future<StreamSubscription<String>?> startSSEStream(
  String requestId,
  APIType apiType,
  HttpRequestModel requestModel, {
  required OnSSEListen onListen,
  required OnSSEError onError,
  SupportedUriSchemes defaultUriScheme = kDefaultUriScheme,
  bool noSSL = false,
}) async {
  final client = httpClientManager.createClient(requestId, noSSL: noSSL);

  (Uri?, String?) uriRec = getValidRequestUri(
    requestModel.url,
    requestModel.enabledParams,
    defaultUriScheme: defaultUriScheme,
  );

  if (uriRec.$1 == null) {
    onError(uriRec.$2 ?? 'Invalid URL');
    return null;
  }

  Uri requestUrl = uriRec.$1!;
  print(requestUrl);
  Map<String, String> headers = requestModel.enabledHeadersMap;
  headers[HttpHeaders.acceptHeader] = 'text/event-stream';
  print(headers);
  try {
    final request = http.Request('GET', requestUrl)..headers.addAll(headers);
    final response = await client.send(request);
    print(response.statusCode);
    // if (response.statusCode != 200) {
    //   throw HttpException('Failed to connect: ${response.statusCode}');
    // }

    SSEStreamController controller = SSEStreamController();
    onListen(controller);

    StreamSubscription<String> subscription =
        response.stream.transform(utf8.decoder).listen(
      (data) {
        controller.add(data);
        print(data);
      },
      onError: (error) {
        onError(error);
        controller.close();
      },
      onDone: () {
        controller.close();
      },
      cancelOnError: true,
    );

    return subscription;
  } catch (e) {
    onError(e);
    return null;
  }
}

void cancelSSEStream(String requestId, StreamSubscription<String>? subscription) {
  subscription?.cancel();
  httpClientManager.closeClient(requestId);
}
