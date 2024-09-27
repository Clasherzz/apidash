import 'dart:io';

import 'package:apidash/consts.dart';
import 'package:apidash/models/RAMLcollection.dart';
import 'package:apidash/models/name_value_model.dart';
import 'package:apidash/models/http_request_model.dart';
import 'package:yaml/yaml.dart';

// RAMLCollection getRAMLcollection(String ramlContent){
//   late RAMLCollection result;
//   // final file = File(filePath);
//   //   final ramlContent = await file.readAsString();

//     // Parse the RAML content using a YAML parser
//     final parsedRaml = loadYaml(ramlContent);

//     // Now use the parsedRaml to extract endpoints and create request models
//     //final parsedEndpoints = _extractEndpoints(parsedRaml);

//   for(var )


//   return result;

// }
//just to know if this would work


// void printRequestModels(List<HttpRequestModel> requestModels) {
//   for (var model in requestModels) {
//     print(model);
//   }
// }



void printRequestModels(RAMLCollection request) {
  for (var model in request.requestModels) {
    print(model);
  }
}

class RAMLService {
  Future<RAMLCollection> parseRamlFile(String? filePath) async {
    String f = filePath != null ? filePath : "";
    final file = File(f);
    final ramlContent = await file.readAsString();

    // Parse the RAML content using YAML parser
    final parsedRaml = _parseRaml(ramlContent);

    // Extract all request models for each endpoint and method
    final requestModels = _extractRequestModels(parsedRaml);

    return RAMLCollection(requestModels);
  }

  // Parse the RAML content
  dynamic _parseRaml(String ramlContent) {
    return loadYaml(ramlContent);
  }

  // Extract request models for each endpoint dynamically
  List<HttpRequestModel> _extractRequestModels(dynamic parsedRaml) {
    List<HttpRequestModel> requestModels = [];

    // Iterate through top-level keys to find endpoints
    for (var endpointPath in parsedRaml.keys) {
      var endpointDefinition = parsedRaml[endpointPath];
      print(endpointDefinition);

      // Check if this key represents an endpoint (assumed structure)
      // if (endpointDefinition is Map) {
      //   // Iterate through possible methods (get, post, put, etc.)
      //   for (var method in endpointDefinition.keys) {
      //     var methodDefinition = endpointDefinition[method];

      //     // Create HttpRequestModel for each method in the endpoint
      //     if (methodDefinition is Map) {
      //       HttpRequestModel requestModel = HttpRequestModel(
      //         method: _getMethod(method),
      //         url: endpointPath,
      //         headers: _getHeadersFromMethodDefinition(methodDefinition),
      //         params: _getParamsFromMethodDefinition(methodDefinition),
      //         bodyContentType: _getContentTypeFromMethodDefinition(methodDefinition),
      //         body: _getBodyFromMethodDefinition(methodDefinition),
      //       );
      //       requestModels.add(requestModel);
      //     }
      //   }
      // }
    }

    return requestModels;
  }
}

HTTPVerb _getMethod(String method) {
    return HTTPVerb.values.firstWhere(
      (v) => v.toString().split('.').last.toLowerCase() == method.toLowerCase(),
      orElse: () => HTTPVerb.get, // Default to GET if method is not found
    );
}

List<NameValueModel>? _getHeadersFromMethodDefinition(dynamic methodDefinition) {
    final headers = methodDefinition['headers'] as Map<String, dynamic>?;

    if (headers != null) {
      return headers.entries
          .map((entry) => NameValueModel(name: entry.key, value: entry.value.toString()))
          .toList();
    }
    return null;
}

  List<NameValueModel>? _getParamsFromMethodDefinition(dynamic methodDefinition) {
    final params = methodDefinition['queryParameters'] as Map<String, dynamic>?;

    if (params != null) {
      return params.entries
          .map((entry) => NameValueModel(name: entry.key, value: entry.value.toString()))
          .toList();
    }
    return null;
  }

    ContentType _getContentTypeFromMethodDefinition(dynamic methodDefinition) {
    final contentType = methodDefinition['body']?['contentType'] ?? 'application/json';

    if (contentType.contains('json')) {
      return ContentType.json;
    } else if (contentType.contains('multipart/form-data')) {
      return ContentType.formdata;
    } else if (contentType.contains('text')) {
      return ContentType.text;
    }
    return ContentType.json; // Default to JSON
  }

  // Extract body content from the method definition
  String? _getBodyFromMethodDefinition(dynamic methodDefinition) {
    return methodDefinition['body']?['example'] ?? ''; // Example body if provided
  }





