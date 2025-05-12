import 'package:flutter/material.dart';
import 'package:p3/class/account.dart';

class BotonTransacciones extends StatelessWidget {
  final Account account;
  final String title;
  final String descripcion;
  final Function(double) onAction;

  const BotonTransacciones({
    super.key,
    required this.account,
    required this.title,
    required this.descripcion,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title),
      onPressed: () async {
        final controller = TextEditingController();

        final cantidad = await showDialog<double>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: descripcion),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    final value = double.tryParse(controller.text);
                    Navigator.of(context).pop(value);
                  },
                ),
              ],
            );
          },
        );

        if (cantidad != null && cantidad > 0) {
          onAction(cantidad);
        }
      },
    );
  }
}
