import 'package:flutter_test/flutter_test.dart';
import 'package:p3/class/account.dart';
import 'package:p3/class/transaction.dart';
import 'package:p3/class/withdrawal_transaction.dart'; 

void main() {
  late Account account; 
  setUp((){
    account = Account(number: "ES1234");
    account.deposit(100);
  });

  test("No se puede retirar una cantidad negativa", (){
    Transaction withdraw = WithdrawalTransaction("ES87632189", -1);
    expect(withdraw.apply(account), false);
    expect(account.balance, 100);
  });

  test("No se puede retirar una cantidad mayor al balance total", (){
    Transaction withdraw = WithdrawalTransaction("ES87632189", 200);
    expect (() => withdraw.apply(account), throwsA(isA<StateError>())); 
  });

  test("Se realiza la retirada correctamente", () {
    Transaction withdraw = WithdrawalTransaction("ES87632189", 40);
    expect(withdraw.apply(account), true);
    expect(account.balance, 60);
  });
}