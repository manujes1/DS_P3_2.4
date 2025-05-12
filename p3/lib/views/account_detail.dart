import 'package:flutter/material.dart';
import 'package:p3/class/account.dart';
import 'package:p3/class/bank_service.dart';
import 'package:p3/components/boton_transacciones.dart';
import 'package:p3/components/boton_transferencia.dart';

class AccountDetail extends StatefulWidget {
  final Account account;
  final BankService bankService; 
  const AccountDetail({super.key, required this.account, required this.bankService});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(        
      appBar: AppBar(
        title: Text('Detalles de Cuenta ${widget.account.number}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Número de cuenta: ${widget.account.number}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Saldo: \$${widget.account.balance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            BotonTransacciones(
              account: widget.account,
              title: "Depositar",
              descripcion: "Introduzca la cantidad a depositar",
              onAction: (amount) {
                widget.account.deposit(amount);
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            BotonTransacciones(
              account: widget.account,
              title: "Retirar",
              descripcion: "Introduzca la cantidad a retirar",
              onAction: (amount) {
                widget.account.withdraw(amount);
                setState(() {});
              },
            ),
            const SizedBox(height: 10,),
              BotonTransferencia(
                bankService: widget.bankService,
                srcNumber: widget.account.number,
              ),
          ],
        ),
      ),
    );
  }
}
