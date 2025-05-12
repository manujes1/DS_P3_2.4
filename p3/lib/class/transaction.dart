import 'package:p3/class/account.dart';

abstract class Transaction {
    final String id;
    final double amount;

    Transaction(this.id, this.amount);

    bool apply(Account account);

    String get textId => id; 
}