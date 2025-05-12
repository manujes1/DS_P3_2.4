import 'package:flutter/material.dart';
import 'package:p3/class/account.dart';
import 'package:p3/class/bank_service.dart';

class BotonTransferencia extends StatelessWidget {
  final BankService bankService;
  final String srcNumber; 

  const BotonTransferencia({
    super.key,
    required this.bankService,
    required this.srcNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Hacer transacción'),
      onPressed: () async {
        final numeroController = TextEditingController();
        final cantidadController = TextEditingController();

        final resultado = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Transferencia'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: numeroController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Número de cuenta destino',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: cantidadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad a transferir',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    final dest = numeroController.text.trim();
                    final amount = double.tryParse(cantidadController.text);

                    if (dest.isEmpty || amount == null || amount <= 0) {
                      Navigator.of(context).pop(false);
                      return;
                    }

                    final Account? account = bankService.transfer(srcNumber, dest, amount);

                    if (account != null) {
                      Navigator.of(context).pop(true);
                    } else {
                      Navigator.of(context).pop(false);
                    }
                  },
                ),
              ],
            );
          },
        );

        if (resultado == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transferencia realizada con éxito.'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transferencia fallida.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
