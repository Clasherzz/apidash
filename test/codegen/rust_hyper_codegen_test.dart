import 'package:apidash/codegen/codegen.dart';
import 'package:apidash/consts.dart';
import 'package:test/test.dart';
import '../models/request_models.dart';


void main() {
  print(requestModelPost3);
  final codeGen = Codegen();

//   group('GET Request', () {
//     test('GET1', () {
//       const expectedCode = r"""
// use hyper::{Body, Client, Request, Uri};
// use hyper::client::HttpConnector;
// use hyper_tls::HttpsConnector;
// use std::convert::TryInto;
// use serde_json::json;
// use tokio;

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let https = HttpsConnector::new();
//     let client = Client::builder().build::<_, hyper::Body>(https);
//     let url = "https://api.apidash.dev".parse::<Uri>().unwrap();
//     let req = Request::builder()
//         .method("GET")
//         .uri(url)
        
//         let res = client.request(req).await?;
//     let body_bytes = hyper::body::to_bytes(res).await?;
//     let body = String::from_utf8(body_bytes.to_vec())?;

//     println!("Response Status: {}", res.status());
//     println!("Response: {:?}", body);

//     Ok(())
// }

// """;
//       expect(
//           codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet1, "https"),
//           expectedCode);
//     });

//     test('GET2', () {
//       const expectedCode = r"""
// use hyper::{Body, Client, Request, Uri};
// use hyper::client::HttpConnector;
// use hyper_tls::HttpsConnector;
// use std::convert::TryInto;
// use serde_json::json;
// use tokio;

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let https = HttpsConnector::new();
//     let client = Client::builder().build::<_, hyper::Body>(https);
//     let url = "https://api.apidash.dev/country/data?code=US".parse::<Uri>().unwrap();
//     let req = Request::builder()
//         .method("GET")
//         .uri(url)
        
//         let res = client.request(req).await?;
//     let body_bytes = hyper::body::to_bytes(res).await?;
//     let body = String::from_utf8(body_bytes.to_vec())?;

//     println!("Response Status: {}", res.status());
//     println!("Response: {:?}", body);

//     Ok(())
// }

// """;
//       expect(
//           codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet2, "https"),
//           expectedCode);
//     });



//     test('GET3', () {
//       const expectedCode = r"""
// use hyper::{Body, Client, Request, Uri};
// use hyper::client::HttpConnector;
// use hyper_tls::HttpsConnector;
// use std::convert::TryInto;
// use serde_json::json;
// use tokio;

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let https = HttpsConnector::new();
//     let client = Client::builder().build::<_, hyper::Body>(https);
//     let url = "https://api.apidash.dev/country/data?code=IND".parse::<Uri>().unwrap();
//     let req = Request::builder()
//         .method("GET")
//         .uri(url)
        
//         let res = client.request(req).await?;
//     let body_bytes = hyper::body::to_bytes(res).await?;
//     let body = String::from_utf8(body_bytes.to_vec())?;

//     println!("Response Status: {}", res.status());
//     println!("Response: {:?}", body);

//     Ok(())
// }

// """;
//       expect(
//           codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet3, "https"),
//           expectedCode);
//     });


//      test('GET4', () {
//       const expectedCode = r"""
// use hyper::{Body, Client, Request, Uri};
// use hyper::client::HttpConnector;
// use hyper_tls::HttpsConnector;
// use std::convert::TryInto;
// use serde_json::json;
// use tokio;

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let https = HttpsConnector::new();
//     let client = Client::builder().build::<_, hyper::Body>(https);
//     let url = "https://api.apidash.dev/humanize/social?num=8700000&digits=3&system=SS&add_space=true&trailing_zeros=true".parse::<Uri>().unwrap();
//     let req = Request::builder()
//         .method("GET")
//         .uri(url)
        
//         let res = client.request(req).await?;
//     let body_bytes = hyper::body::to_bytes(res).await?;
//     let body = String::from_utf8(body_bytes.to_vec())?;

//     println!("Response Status: {}", res.status());
//     println!("Response: {:?}", body);

//     Ok(())
// }

// """;
//       expect(
//           codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet4, "https"),
//           expectedCode);
//     });

 group('POST Request', () {
    test('POST1', () {
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;

use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://api.apidash.dev/case/lower".parse::<Uri>().unwrap();    
    let req = Request::builder()
              .method("POST")
              .uri(url)        
              .header("Content-Type", "text/plain")
                
              .body(Body::from(r#"{
"text": "I LOVE Flutter"
}"#))?;
    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelPost1, "https"),expectedCode
      );


    });


    test('POST2', () {
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://api.apidash.dev/case/lower".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("POST")
              .uri(url)        
              .header("Content-Type", "application/json")
                
              .body(Body::from(json!({
"text": "I LOVE Flutter",
"flag": null,
"male": true,
"female": false,
"no": 1.2,
"arr": ["null", "true", "false", null]
}).to_string()))?;
    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelPost2, "https"),expectedCode
      );


    });


//     test('POST3', () {
//       const expectedCode = r"""
// use hyper::{Body, Client, Request, Uri};
// use hyper::client::HttpConnector;
// use hyper_tls::HttpsConnector;
// use std::convert::TryInto;
// use serde_json::json;
// use tokio;

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let https = HttpsConnector::new();
//     let client = Client::builder().build::<_, hyper::Body>(https);
//     let url = "https://api.apidash.dev/case/lower".parse::<Uri>().unwrap();
//     let req = Request::builder()
//               .method("POST")
//               .uri(url)        
//               .header("User-Agent", "Test Agent")
        
//               .header("Content-Type", "application/json")
                
//               .body(Body::from(json!({
// "text": "I LOVE Flutter"
// }).to_string()))?;
//     let res = client.request(req).await?;
//     let body_bytes = hyper::body::to_bytes(res).await?;
//     let body = String::from_utf8(body_bytes.to_vec())?;

//     println!("Response Status: {}", res.status());
//     println!("Response: {:?}", body);

//     Ok(())
// }
// """;
//       expect(
//           codeGen.getCode(CodegenLanguage.rustHyper, requestModelPost3, "https"),expectedCode
//       );


//     });
 
 
 
 
 
 });

 
 
 
 group('HEAD Request', () {
    test('HEAD1', () {
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://api.apidash.dev".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("HEAD")
              .uri(url)
              .body(Body::empty())?;

    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelHead1, "https"),
          expectedCode);
    });
    test('HEAD2', () {
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://api.apidash.dev".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("HEAD")
              .uri(url)
              .body(Body::empty())?;

    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelHead2, "https"),
          expectedCode);
    });
  });
 
 
 
 
 
 
 
 
 
 group('PUT Request', () {
    test('PUT1', () {
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://reqres.in/api/users/2".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("PUT")
              .uri(url)        
              .body(Body::from(json!({
"name": "morpheus",
"job": "zion resident"
}).to_string()))?;
    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelPut1, "https"),
          expectedCode);
    });
  });
    






//   });
group('PATCH Request', () {
    test('PATCH1', () {
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://reqres.in/api/users/2".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("PATCH")
              .uri(url)        
              .body(Body::from(json!({
"name": "marfeus",
"job": "accountant"
}).to_string()))?;
    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(
          codeGen.getCode(
              CodegenLanguage.rustHyper, requestModelPatch1, "https"),
          expectedCode);
    });
  });



  group('DELETE',(){
    test('DELETE1',(){
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://reqres.in/api/users/2".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("DELETE")
              .uri(url)
              .body(Body::empty())?;

    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(codeGen.getCode(CodegenLanguage.rustHyper,requestModelDelete1,"https"),
      expectedCode);


    }
    );

    test('DELETE2',(){
      const expectedCode = r"""
use hyper::{Body, Client, Request, Uri};
use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use std::convert::TryInto;
use serde_json::json;
use tokio;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let https = HttpsConnector::new();
    let client = Client::builder().build::<_, hyper::Body>(https);
    let url = "https://reqres.in/api/users/2".parse::<Uri>().unwrap();
    let req = Request::builder()
              .method("DELETE")
              .uri(url)        
              .body(Body::from(json!({
"name": "marfeus",
"job": "accountant"
}).to_string()))?;
    let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}
""";
      expect(codeGen.getCode(CodegenLanguage.rustHyper,requestModelDelete2,"https"),
      expectedCode);


    }
    );
   });
  }

  
  
  
  
