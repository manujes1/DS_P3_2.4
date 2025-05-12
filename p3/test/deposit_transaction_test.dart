import 'package:flutter_test/flutter_test.dart';
import 'package:p3/class/transaction.dart';
import 'package:p3/class/account.dart';
import 'package:p3/class/deposit_transaction.dart';

void main() {
  late Account account; 
  setUp((){
    account = Account(number: "SE2109321903");
    account.deposit(15);
  });

  test("No se puede depositar una cantidad negativa", (){
    Transaction deposit = DepositTransaction("ES1232432", -1);
    expect(()=> deposit.apply(account), throwsA(isA<StateError>()));
  });

  test("Se aumenta el saldo correctamente", (){
    Transaction deposit = DepositTransaction("ES1232432", 100); 
    expect(deposit.apply(account), true);
    expect(account.balance, 115);
  });
}