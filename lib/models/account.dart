class Account {
  String id;
  String name;
  String lastName;
  double balance;

  //Construtor | Required = obrigatório
  Account({required this.id, required this.name, required this.lastName, required this.balance});

  //Método para converter um Map em um objeto Account
  //Dataclass

  //Possibilidar de criar um construtor a partir de outro
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      balance: map['balance'],
    );
  }

  //Usa a mesma chave do Map para converter o objeto em Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'balance': balance,
    };
  }
}