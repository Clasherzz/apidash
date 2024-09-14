import 'package:apidash/codegen/codegen.dart';
import 'package:apidash/consts.dart';
import 'package:test/test.dart';
import '../models/request_models.dart';


void main() {
  final codeGen = Codegen();

  group('GET Request', () {
    test('GET1', () {
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
        .method("GET")
        .uri(url)
        
        let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}

""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet1, "https"),
          expectedCode);
    });

    test('GET2', () {
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
    let url = "https://api.apidash.dev/country/data?code=US".parse::<Uri>().unwrap();
    let req = Request::builder()
        .method("GET")
        .uri(url)
        
        let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}

""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet2, "https"),
          expectedCode);
    });



    test('GET3', () {
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
    let url = "https://api.apidash.dev/country/data?code=IND".parse::<Uri>().unwrap();
    let req = Request::builder()
        .method("GET")
        .uri(url)
        
        let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}

""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet3, "https"),
          expectedCode);
    });


     test('GET4', () {
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
    let url = "https://api.apidash.dev/humanize/social?num=8700000&digits=3&system=SS&add_space=true&trailing_zeros=true".parse::<Uri>().unwrap();
    let req = Request::builder()
        .method("GET")
        .uri(url)
        
        let res = client.request(req).await?;
    let body_bytes = hyper::body::to_bytes(res).await?;
    let body = String::from_utf8(body_bytes.to_vec())?;

    println!("Response Status: {}", res.status());
    println!("Response: {:?}", body);

    Ok(())
}

""";
      expect(
          codeGen.getCode(CodegenLanguage.rustHyper, requestModelGet4, "https"),
          expectedCode);
    });

    






  });
  }

  
  
  
  
