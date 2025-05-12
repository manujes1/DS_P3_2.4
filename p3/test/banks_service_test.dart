import 'package:flutter_test/flutter_test.dart';
import 'package:p3/class/account.dart';
import 'package:p3/class/bank_service.dart';
import 'package:p3/class/transaction.dart';

void main() {
  late BankService bankService;
  late double amount; 

  setUp((){
    bankService = BankService();
    amount = 20;
  });

  test("lista vacia", (){
    expect(bankService.length, 0);
  });

  test("Se intenta aumentar el saldo de una cuenta que no existe", (){
    expect(bankService.deposit("ES123132131", amount), null);
  });

  test("Aumento del saldo de una cuenta", (){
    Account? account = bankService.createAccount();
    expect(account.balance, 0);
    account = bankService.deposit(account.number, amount);
    expect(account!.balance, amount);

  });

  test("Retirada de dinero con saldo insuficiente", (){
    Account account = bankService.createAccount();
    expect(()=>bankService.withdraw(account.number, amount), throwsA(isA<StateError>()));
  });

  test("Retirada de dinero de forma exitosa", (){
    Account account = bankService.createAccount();
    double deposit = 100;
    bankService.deposit(account.number, deposit);
    bankService.withdraw(account.number, amount);
    expect(account.balance, deposit - amount);
  });

  test("No existe las dos cuentas", (){
    expect(bankService.transfer("ES1234", "ES5678", amount), null);
  });

  test("No existe la cuenta fuente", (){
    Account account = bankService.createAccount();
    expect(bankService.transfer("ES1234", account.number, amount), null);
  });

  test("No existe la cuenta destino", (){
    Account account = bankService.createAccount();
    expect(bankService.transfer(account.number, "ES1234", amount), null);
  });

  test("Saldo insuficiente", (){
    Account srcAccount = bankService.createAccount();
    Account destAccount = bankService.createAccount();
    expect(()=>bankService.transfer(srcAccount.number, destAccount.number, amount), throwsA(isA<StateError>()));
  });

  test("transaccion realizada de forma exitosa", (){
    Account srcAccount = bankService.createAccount();
    Account destAccount = bankService.createAccount();
    double deposit = 100;
    bankService.deposit(srcAccount.number, deposit);
    expect(bankService.transfer(srcAccount.number, destAccount.number, amount), destAccount);
    expect(srcAccount.balance, deposit - amount);
    expect(destAccount.balance, amount);
  });
  test("Los identificadores de las transacciones son diferentes", (){
    Account srcAccount = bankService.createAccount();
    double deposit = 100;
    bankService.deposit(srcAccount.number, deposit);
    bankService.withdraw(srcAccount.number, amount);
    List<Transaction> transactions = bankService.getTransactions(srcAccount.number)!;
    expect(transactions.length, 2);
    expect(transactions[0].textId, isNot(equals(transactions[1].textId)));
  });
  
}