import 'dart:math';

import 'package:p3/class/account.dart';
import 'package:p3/class/deposit_transaction.dart';
import 'package:p3/class/transaction.dart';
import 'package:p3/class/transfer_transaction.dart';
import 'package:p3/class/withdrawal_transaction.dart';

class BankService {
  final Map<String, Account> _accounts = {};
  final Map<Account, List<Transaction>> _transactionsAccounts = {};
  static final BankService _instance = BankService._internal();

  BankService._internal();

  factory BankService(){
    return _instance;
  }

  Account createAccount(){
    String number;
    do{
      number = generateHash(); 
    }while(_accounts.containsKey(number));

    final Account account = Account(number: number); 
    _accounts[number] = account;
    _transactionsAccounts[account] = [];

    return account;
  }

  Account? deposit(String number, double amount){
    if(!_accounts.containsKey(number)){
      return null; 
    }else{
      final Account account = _accounts[number]!;
      List<Transaction> transactions = _transactionsAccounts[account]!;
      bool idExists;
      String id;  
      do{
        id = generateHash();
        idExists = transactions.any((t) => t.id == id);
      }while(idExists);
      
      final Transaction deposit = DepositTransaction(id, amount); 
      if(deposit.apply(account)){
        transactions.add(deposit);
        return account;
      }
      return null;
    }
  }
  void removeAccount(String number){
    _accounts.remove(number);
  }
  Account? withdraw(String number, double amount){
    if(!_accounts.containsKey(number)){
      return null; 
    }else{
      final Account account = _accounts[number]!;
      List<Transaction> transactions = _transactionsAccounts[account]!;
      String id;
      bool idExists;
      do{
        id = generateHash();
        idExists = transactions.any((t) => t.id == id);
      }while(idExists);
      
      Transaction withdraw = WithdrawalTransaction(id, amount);
      if(withdraw.apply(account)){
        transactions.add(withdraw);
        return account;
      }
      return null; 
    }
  }

Account? transfer(String srcNumber, String destNumber, double amount) {
  // 1. Validaciones básicas
  if (amount <= 0) return null;
  if (srcNumber == destNumber) return null; 

  if (!_accounts.containsKey(srcNumber) || !_accounts.containsKey(destNumber)) {
    return null;
  }

  final Account srcAccount = _accounts[srcNumber]!;
  final Account destAccount = _accounts[destNumber]!;
  final List<Transaction> srcTransactions = _transactionsAccounts[srcAccount]!;
  final List<Transaction> destTransactions = _transactionsAccounts[destAccount]!;

  String id;
  bool idExists;
  do {
    id = generateHash();
    idExists = srcTransactions.any((t) => t.id == id) || 
               destTransactions.any((t) => t.id == id);
  } while (idExists);

  final Transaction transfer = TransferTransaction(id, amount, destAccount);
  
  if (transfer.apply(srcAccount)) {
    srcTransactions.add(transfer);
    destTransactions.add(transfer);

    return destAccount;
  }
  
  return null;
}
  int get length => _accounts.length;

  Map<String, Account>? getAccounts() => _accounts;

  Account? getAccount(String number) => _accounts[number];

  List<Transaction>? getTransactions(String number) => _transactionsAccounts[_accounts[number]];

  String generateHash(){
    const longitud = 10; 
    const caracteresPermitidos = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(longitud,
        (_) => caracteresPermitidos.codeUnitAt(random.nextInt(caracteresPermitidos.length))
      )
    );
  }
}
