

import 'package:seed/models/name_value_model.dart';

List<NameValueModel> getUniqueNameValueModels(List<NameValueModel> models) {
  final uniqueModels = <String, String>{};
  for (var model in models) {
    uniqueModels[model.name] = model.value;
  }
  return uniqueModels.entries.map((e) => NameValueModel(name: e.key,value: e.value)).toList();
}

Map<String, String>? getUrlParams(String url) {
  try{
    Uri uri = Uri.parse(url);
    return uri.queryParameters;
  }catch(e){
    return null;
  }
}




String addParamsToUrl(String url, Map<String, String> params) {
  Uri uri = Uri.parse(url);
  final newParams = Map<String, String>.from(uri.queryParameters)..addAll(params);
  final newUri = uri.replace(queryParameters: newParams);
  return newUri.toString();
}