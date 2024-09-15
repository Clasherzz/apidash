// import 'dart:io';
// import 'dart:convert';
// import 'package:jinja/jinja.dart' as jj;
// import 'package:apidash/consts.dart';
// import 'package:apidash/utils/utils.dart'
//     show getNewUuid, getValidRequestUri, stripUriParams;
// import 'package:apidash/models/models.dart';

// class RustHyperCodeGen {
//   final String kTemplateStart = """
// use hyper::{Body, Client, Request, Uri};
// use hyper::client::HttpConnector;
// use hyper_tls::HttpsConnector;
// use std::convert::TryInto;
// {% if hasJsonBody %}use serde_json::json;{% endif %}
// use tokio;

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let https = HttpsConnector::new();
//     let client = Client::builder().build::<_, hyper::Body>(https);
//     let url = "{{url}}".parse::<Uri>().unwrap();

// """;

//   String kTemplateMethod = """
//     let req = Request::builder() 
//         .method("{{method}}")
//         .uri(url)

//     """;

//   String kTemplateHeaders = """
//         {% for key, val in headers %}
//         .header("{{key}}", "{{val}}"){% if not loop.last %}{% endif %}
//         {% endfor %}
//   """;

//   String kTemplateBody = """
//       .body(Body::from(r#"{{body}}"#))?;


// """;

//   String kTemplateJsonBody = """
//       .body(Body::from(json!({{body}}).to_string()))?;

// """;
//   String kTemplateEmptyBody = r"""
//       .body(Body::empty())?;

// """;

  
//   String kTemplateFormData = """
//     let form_data = vec![
//     {%- for field in fields_list %}
//         ("{{ field.name }}", "{{ field.value }}"){% if not loop.last %}, {% endif %}
//     {%- endfor %}
//     ];
//     let body = serde_urlencoded::to_string(&form_data)?;
//     let req = req.body(Body::from(body))?;

// """;

//   final String kTemplateRequestEnd = """
//   let res = client.request(req).await?;
//     let body_bytes = hyper::body::to_bytes(res).await?;
//     let body = String::from_utf8(body_bytes.to_vec())?;

//     println!("Response Status: {}", res.status());
//     println!("Response: {:?}", body);

//     Ok(())
// }

// """;

//   String? getCode(HttpRequestModel requestModel) {
//     try {
//       String uuid = getNewUuid();
//       String result = "";
//       bool hasBody = false;
//       bool hasJsonBody = false;

//       String url = requestModel.url;

//       var rec = getValidRequestUri(
//         url,
//         requestModel.enabledParams,
//       );
    
//       Uri? uri = rec.$1;
//       //print(rec);
//       if (uri != null) {
//         result += jj.Template(kTemplateStart).render({
//           // "url": stripUriParams(uri),
//           "url":uri,
//           'hasJsonBody': requestModel.bodyContentType == ContentType.json,
//           'method': requestModel.method.name.toUpperCase(),
//         });

//         // Add method
//         result += jj.Template(kTemplateMethod).render({
//           "method": requestModel.method.name.toUpperCase(),
//         });






//         var headersList = requestModel.enabledHeaders;
//         if (headersList != null) {
//           var headers = requestModel.enabledHeadersMap;
//           if (headers.isNotEmpty) {
//             result += jj.Template(kTemplateHeaders).render({"headers": headers});
//           }
//         }

//         // Handle body (JSON or raw)
//         var requestBody = requestModel.body;
//         print(requestBody);
//         if(requestBody==""){
//           print("empty string entered");
//           result += kTemplateEmptyBody;
//         }else if(requestBody==null){
//               print("null entered");
//               result += kTemplateEmptyBody;
//         }else if (kMethodsWithBody.contains(requestModel.method) && requestBody != null) {
//           var contentLength = utf8.encode(requestBody).length;
//           if (contentLength > 0) {
//              if (requestModel.bodyContentType == ContentType.json) {
//               hasJsonBody = true;
//               result += jj.Template(kTemplateJsonBody).render({"body": requestBody});
//             } else {
//               hasBody = true;
//               result += jj.Template(kTemplateBody).render({"body": requestBody});
//             }
//           }
//         }else{
//           print("get");
//               result += kTemplateEmptyBody;
//         }
//         // if (requestBody != null) {
//         //   var contentLength = utf8.encode(requestBody).length;
//         //   if (contentLength > 0) {
//         //      if (requestModel.bodyContentType == ContentType.json) {
//         //       hasJsonBody = true;
//         //       result += jj.Template(kTemplateJsonBody).render({"body": requestBody});
//         //     } else {
//         //       hasBody = true;
//         //       result += jj.Template(kTemplateBody).render({"body": requestBody});
//         //     }
//         //   }
//         // }

//         // Handle form data
//         if (requestModel.hasFormData) {
//           result += jj.Template(kTemplateFormData).render({
//             "fields_list": requestModel.formDataMapList,
//           });
//         }

//         // Add headers
//         // var headersList = requestModel.enabledHeaders;
//         // if (headersList != null) {
//         //   var headers = requestModel.enabledHeadersMap;
//         //   if (headers.isNotEmpty) {
//         //     result += jj.Template(kTemplateHeaders).render({"headers": headers});
//         //   }
//         // }

//         result += kTemplateRequestEnd;
//       }

//       return result;
//     } catch (e) {
//       return null;
//     }
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'package:jinja/jinja.dart' as jj;
import 'package:apidash/consts.dart';
import 'package:apidash/utils/utils.dart'
    show getNewUuid, getValidRequestUri, stripUriParams;
import 'package:apidash/models/models.dart';

class RustHyperCodeGen {
  final String kTemplateStart = """
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
{% if hasJsonBody %}use serde_json::json;{% endif %}
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "{{ url }}".parse::<Uri>().unwrap();
""";

  final String kTemplateMethod = """
    let req = Request::builder()
        .method("{{ method }}")
        .uri(url)
""";

  final String kTemplateHeaders = """
        {% for key, val in headers %}
        .header("{{ key }}", "{{ val }}"){% if not loop.last %}{% endif %}
        {% endfor %}
""";

  final String kTemplateBody = """
        
        .body(Body::from(r#"{{ body }}"#))?;\n
""";

  final String kTemplateJsonBody = """
        
        .body(Body::from(json!({{ body }}).to_string()))?;\n
""";

  final String kTemplateEmptyBody = """

        .body(Body::empty())?;\n
""";

  final String kTemplateFormData = """

    let form_data = vec![
    {%- for field in fields_list %}
        ("{{ field.name }}", "{{ field.value }}"){% if not loop.last %}, {% endif %}
    {%- endfor %}
    ];
    let body = serde_urlencoded::to_string(&form_data)?;
    let req = req.body(Body::from(body))?;
""";

  final String kTemplateRequestEnd = """
    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";

  String? getCode(HttpRequestModel requestModel) {
    try {
      String uuid = getNewUuid();
      String result = "";
      bool hasJsonBody = false;

      String url = requestModel.url;
      var rec = getValidRequestUri(url, requestModel.enabledParams);
      Uri? uri = rec.$1;

      if (uri != null) {
        result += jj.Template(kTemplateStart).render({
          "url": uri,
          'hasJsonBody': requestModel.bodyContentType == ContentType.json,
        });

        // Add method
        result += jj.Template(kTemplateMethod).render({
          "method": requestModel.method.name.toUpperCase(),
        });

        // Add headers if available
        var headers = requestModel.enabledHeadersMap;
        if (headers.isNotEmpty) {
          result += jj.Template(kTemplateHeaders).render({"headers": headers});
        }

        // Handle body (JSON or raw)
        var requestBody = requestModel.body;
        // if (requestBody == "" || requestBody == null) {
        //   result += kTemplateEmptyBody;
        // } else if (requestModel.bodyContentType == ContentType.json) {
        //   result += jj.Template(kTemplateJsonBody).render({"body": requestBody});
        // } else {
        //   result += jj.Template(kTemplateBody).render({"body": requestBody});
        // }

        
        if (requestBody == "" || requestBody == null|| requestModel.method ==HTTPVerb.get) {
          result += kTemplateEmptyBody;
        }else if (requestModel.hasFormData) {
          result += jj.Template(kTemplateFormData).render({
            "fields_list": requestModel.formDataMapList,
          });
        }else if(requestModel.hasJsonData){
          result += jj.Template(kTemplateJsonBody).render({"body": requestBody});

        }else if(requestModel.hasTextData){
          result += jj.Template(kTemplateBody).render({"body": requestBody});
        }
        // End request
        result += kTemplateRequestEnd;
      }

      return result;
    } catch (e) {
      return null;
    }
  }
}
