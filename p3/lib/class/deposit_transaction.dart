import 'package:p3/class/account.dart';
import 'package:p3/class/transaction.dart';


class DepositTransaction extends Transaction {
  DepositTransaction(super.id, super.amount);

  @override
  bool apply(Account account) {
    if (amount <= 0) throw StateError("No se puede depositar una cantidad negativa o cero");
    return account.deposit(amount);
  }
}