import 'package:flutter_test/flutter_test.dart';
import 'package:p3/class/account.dart';
import 'package:p3/class/transaction.dart';
import 'package:p3/class/transfer_transaction.dart'; 
void main() {
  late Account srcAccount; 
  late Account destAccount;
  setUp((){
    srcAccount = Account(number: "ES123972013");
    destAccount = Account(number: "ES123972014");
    srcAccount.deposit(200);
  });
  
  test("Se lanza excepción al intentar transferir cantidad negativa", () {
    Transaction transaccion = TransferTransaction("TRA001", -50, srcAccount);
    expect(() => transaccion.apply(destAccount), throwsA(isA<StateError>()));
  });


  test("Transferencia realizada correctamente", () {
    Transaction transaccion = TransferTransaction("TRA002", 100, destAccount);
    expect(transaccion.apply(srcAccount), true);
    expect(srcAccount.balance, 100);
    expect(destAccount.balance, 100);
  });

  test("La transefencia no se ha podido realizar por falta de fondos", () {
    Transaction transaccion = TransferTransaction("TRA003", 300, destAccount);
    expect(()=>transaccion.apply(srcAccount), throwsA(isA<StateError>()));
    expect(srcAccount.balance, 200);
    expect(destAccount.balance, 0);
  });
}