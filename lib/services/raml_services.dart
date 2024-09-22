import 'package:apidash/consts.dart';
import 'package:apidash/models/RAMLcollection.dart';
import 'package:apidash/models/name_value_model.dart';
import 'package:yaml/yaml.dart';

RAMLCollection getRAMLcollection(String ramlContent){
  late RAMLCollection result;
  // final file = File(filePath);
  //   final ramlContent = await file.readAsString();

    // Parse the RAML content using a YAML parser
    final parsedRaml = loadYaml(ramlContent);

    // Now use the parsedRaml to extract endpoints and create request models
    //final parsedEndpoints = _extractEndpoints(parsedRaml);

  for(var )


  return result;

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





