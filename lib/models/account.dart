import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;

  //Construtor | Required = obrigatório
  Account({required this.id, required this.name, required this.lastName, required this.balance});

  //Método para converter um Map em um objeto Account
  //Dataclass é uma classe projetada para conter apenas dados, sem a complexidade de comportamentos significativos.

  //Possibilidar de criar um construtor a partir de outro
  //Transforma o Map em Objeto (Account)
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      balance: map['balance'],
    );
  }

  //Usa a mesma chave do Map para converter o objeto em Map
  //Trandsforma o Objeto (Account) em Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'balance': balance,
    };
  }

  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
  }) {
  return Account(
    id: id ?? this.id,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    balance: balance ?? this.balance,
  );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
    Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Conta $id: $name $lastName, Saldo: $balance';
  }

  @override
  bool operator ==(Object other) {
  if (identical(this, other)) return true;

    return other is Account &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ balance.hashCode;
  }
}

/*
Resumo analogia com carro
Classe Account: O projeto do carro.
Atributos: As partes do carro (rodas, motor, etc.).
Construtor: O processo de montagem do carro.
toMap: Transformar o carro em um desenho técnico.
fromMap: Usar o desenho técnico para montar o carro.
factory: A fábrica de carros, que pode usar diferentes processos para montar o carro.
*/