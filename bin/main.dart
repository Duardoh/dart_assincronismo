import 'package:http/http.dart';

void main(){
  print('Hello, Dart!');
  requestData();
}

requestData(){
  String url = 'https://gist.githubusercontent.com/Duardoh/741a46cb3b5243f6bb31289840734e2f/raw/ce2e3df291b9826aa8f3e02c5a9c400a39937bc7/accounts.json';
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  //pedir para o dart fazer algo quando a operação assíncrona for concluída
  //then é usado para registrar uma função de retorno de chamada que será executada quando a Future for concluída com sucesso
  futureResponse.then((Response response) { //o que vem de resultado da requisição assincrona é uma Resposta
    print(response);
    print(response.body);
  },);
}

/*
Para instalar o paconte de http
dart pub add http

vai adcionar a dependencia no arquivo pubspec.yaml
*/