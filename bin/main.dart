import 'package:http/http.dart';
import 'dart:convert';
import 'package:dart_assincronismo/api_key.dart';
import 'dart:async';

//Criando uma Stream 
//Sempre mandando informações
//Os dados que vamos receber são do tipo String
StreamController<String> streamController = StreamController<String>();


void main() {
  //Ouvindo uma Stream
  StreamSubscription streamSubscription = 
    streamController.stream.listen((String info){
      print(info);
    },);
  //print('Hello, Dart!');
  requestData();
  requestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "Eduardo",
    "lastName": "Rodrigues",
    "balance": 2500.00,
  });
}

requestData() {
  String url =
      'https://gist.githubusercontent.com/Duardoh/741a46cb3b5243f6bb31289840734e2f/raw/ce2e3df291b9826aa8f3e02c5a9c400a39937bc7/accounts.json';
  Future<Response> futureResponse = get(Uri.parse(url));
  //print(futureResponse); //Saber o que esta chegando
  //pedir para o dart fazer algo quando a operação assíncrona for concluída
  //then é usado para registrar uma função de retorno de chamada que será executada quando a Future for concluída com sucesso
  futureResponse.then(
    //agenda uma função para ser executada quando a Future for concluída
    (Response response) {
      streamController.add('${DateTime.now()} | Requisisação de leitura (usando Then)');
    //quando chama ele lança no canal essa informação para todos que estão inscritos (listen na main)

      //o que vem de resultado da requisição assincrona é uma Resposta
      // print(response);
      // print(response.body);
      //List<dynamic> listAccounts = json.decode(response.body);

      //Condição para que ele pegue o primeiro elemento que encontrar usando o método de lista firstWhere
      // Map<String, dynamic> mapCarla = listAccounts.firstWhere(
      //   (element) => element['name'] == 'Carla',
      // );
      //print(mapCarla['balance']); //exemplo
    },
  );

  //print('Ultima coisa a aconntecer na função requestData');
}

//Todo retorno de uma função async tem que ser um Future
Future<List<dynamic>> requestDataAsync() async {
  //Colocando o ASYNC na função para mostrar que ela tem operações assíncronas
  String url =
      'https://gist.githubusercontent.com/Duardoh/741a46cb3b5243f6bb31289840734e2f/raw/ce2e3df291b9826aa8f3e02c5a9c400a39937bc7/accounts.json';
  Response response = await get(
    Uri.parse(url),
  ); //await = vou demorar aqui até receber a resposta, vou esperar. Só faz sentido quando estamos usando o Future
  // print(json.decode(response.body)[0]);
  // print('De fato a última coisa a aconntecer na função');
  streamController.add('${DateTime.now()} | Requisisação de leitura (metodo Async/Await)');
  return json.decode(response.body);
}

sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  //print(content);

  String url = 'https://api.github.com/gists/741a46cb3b5243f6bb31289840734e2f';

  Response response = await post(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $githubApiKey"},
    body: json.encode({
      "description": "accounts.json",
      "public": true,
      "files": {
        "accounts.json": {"content": content},
      },
    }),
  );

  //print(response.statusCode); //código 200 quer dizer que deu tudo certo (200 a 299)
  //https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Reference/Status/403

  //pegar o primeiro caractere do código e converter para string
  if (response.statusCode.toString()[0] == "2"){
    streamController.add('${DateTime.now()} | Requisisação de adição bem sucedida (${mapAccount['name']})');
  } else {
    streamController.add('${DateTime.now()} | Requisisação falhou (${mapAccount['name']})');
  }
}
/*
Para instalar o paconte de http
dart pub add http

vai adcionar a dependencia no arquivo pubspec.yaml

switch (response.statusCode) {
    case 200:
      // A requisição foi bem-sucedida, processa os dados
      print('Dados recebidos: ${response.body}');
      break;
    case 201:
      // Recurso criado com sucesso
      print('Recurso criado com sucesso.');
      break;
    case 204:
      // Nenhum conteúdo retornado
      print('Operação concluída, mas sem dados para exibir.');
      break;
    case 400:
      // Requisição inválida
      print('Erro na requisição: ${response.reasonPhrase}');
      break;
    case 401:
      // Não autorizado
      print('Acesso não autorizado. Verifique suas credenciais.');
      break;
    case 403:
      // Recurso não encontrado
      print('Servidor entendeu o pedido, mas se recusa a autorizá-lo.');
      break;
    case 404:
      // Recurso não encontrado
      print('Recurso não encontrado.');
      break;
    case 500:
      // Erro interno no servidor
      print('Erro no servidor. Tente novamente mais tarde.');
      break;
    default:
      // Outros códigos de erro
      print('Erro desconhecido: ${response.statusCode}');
  }
*/
