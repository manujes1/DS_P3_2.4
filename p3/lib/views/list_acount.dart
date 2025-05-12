import 'package:flutter/material.dart';
import 'package:p3/class/bank_service.dart';
import 'package:p3/class/account.dart';
import 'package:p3/views/account_detail.dart';

class ListAcount extends StatefulWidget {
  final BankService bankService; 
  const ListAcount({super.key, required this.bankService});

  @override
  State<ListAcount> createState() => _ListAcountState();
}

class _ListAcountState extends State<ListAcount> {
  void _removeAccount(String accountNumber) {
    setState(() {
      widget.bankService.removeAccount(accountNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Account>? accountsMap = widget.bankService.getAccounts();

    if (accountsMap == null || accountsMap.isEmpty) {
      return const Center(child: Text('No hay cuentas disponibles.'));
    }

    final List<Account> accounts = accountsMap.values.toList();

    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountDetail(account: account, bankService: widget.bankService),
              ),
            );
          },
          title: Text('Cuenta: ${account.number}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _removeAccount(account.number);
            },
          ),
        );
      },
    );
  }
}
