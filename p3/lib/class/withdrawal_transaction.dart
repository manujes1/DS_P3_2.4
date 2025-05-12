import 'package:p3/class/transaction.dart';
import 'package:p3/class/account.dart';

class WithdrawalTransaction extends Transaction{
    WithdrawalTransaction(super.id, super.amount);

    @override
    bool apply(Account account){
        if(amount <= 0) return false;
        if(account.balance < amount) throw StateError("Fondos insuficientes para retirar");
        return account.withdraw(amount);
    }
}