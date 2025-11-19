import 'package:http/http.dart';
import 'dart:convert';

void main(){
  print('Hello, Dart!');
  // requestData();
  // requestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "Eduardo",
    "lastName": "Rodrigues",
    "balance": 2500.00,
  });
}

requestData(){
  String url = 'https://gist.githubusercontent.com/Duardoh/741a46cb3b5243f6bb31289840734e2f/raw/ce2e3df291b9826aa8f3e02c5a9c400a39937bc7/accounts.json';
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  //pedir para o dart fazer algo quando a operação assíncrona for concluída
  //then é usado para registrar uma função de retorno de chamada que será executada quando a Future for concluída com sucesso
  futureResponse.then( //agenda uma função para ser executada quando a Future for concluída
    (Response response) { //o que vem de resultado da requisição assincrona é uma Resposta
      print(response);
      print(response.body);
      List<dynamic> listAccounts = json.decode(response.body);

      //Condição para que ele pegue o primeiro elemento que encontrar usando o método de lista firstWhere
      Map<String, dynamic> mapCarla = listAccounts.firstWhere(
        (element) => element['name'] == 'Carla',
      );
      print(mapCarla['balance']);
    },
  );

  print('Ultima coisa a aconntecer na função requestData');
}

//Todo retorno de uma função async tem que ser um Future
Future<List<dynamic>>requestDataAsync() async { //Colocando o ASYNC na função para mostrar que ela tem operações assíncronas
  String url = 'https://gist.githubusercontent.com/Duardoh/741a46cb3b5243f6bb31289840734e2f/raw/ce2e3df291b9826aa8f3e02c5a9c400a39937bc7/accounts.json';
  Response response = await get(Uri.parse(url)); //await = vou demorar aqui até receber a resposta, vou esperar. Só faz sentido quando estamos usando o Future
  // print(json.decode(response.body)[0]);
  // print('De fato a última coisa a aconntecer na função');
  return json.decode(response.body);

}

sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  print(content);

}

/*
Para instalar o paconte de http
dart pub add http

vai adcionar a dependencia no arquivo pubspec.yaml
*/