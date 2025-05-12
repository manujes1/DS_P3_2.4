import 'package:p3/class/transaction.dart';
import 'package:p3/class/account.dart';

class TransferTransaction extends Transaction {
  final Account destAccount;

  TransferTransaction(super.id, super.amount, this.destAccount);

  @override
  bool apply(Account srcAccount) {
    if (amount <= 0) throw StateError("No se puede realizar una trasferencia negativa o cero");

    
    bool withdrawn = srcAccount.withdraw(amount);
    if (!withdrawn) throw StateError("Fondos insuficientes para retirar");

    
    return destAccount.deposit(amount);
  }
}
