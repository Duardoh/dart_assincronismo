import 'package:http/http.dart';
import 'dart:convert';
import 'package:dart_assincronismo/api_key.dart';
import 'dart:async';

class AccountService {
  //Criando uma Stream 
  //Sempre mandando informações
  //Os dados que vamos receber são do tipo String
  StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url = 'https://api.github.com/gists/741a46cb3b5243f6bb31289840734e2f';

  //Todo retorno de uma função async tem que ser um Future
  Future<List<dynamic>> getAll() async {
  //Colocando o ASYNC na função para mostrar que ela tem operações assíncronas
 
  Response response = await get(
    Uri.parse(url),
  ); //await = vou demorar aqui até receber a resposta, vou esperar. Só faz sentido quando estamos usando o Future
  // print(json.decode(response.body)[0]);
  // print('De fato a última coisa a aconntecer na função');
  _streamController.add('${DateTime.now()} | Requisisação de leitura (metodo Async/Await)');
  return json.decode(response.body);
  }

  addAccount(Map<String, dynamic> mapAccount) async {
    List<dynamic> listAccounts = await getAll();
    listAccounts.add(mapAccount);
    String content = json.encode(listAccounts);
    //print(content);

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
      _streamController.add('${DateTime.now()} | Requisisação de adição bem sucedida (${mapAccount['name']})');
    } else {
      _streamController.add('${DateTime.now()} | Requisisação falhou (${mapAccount['name']})');
    }
  }
}