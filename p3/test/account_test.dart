import 'package:flutter_test/flutter_test.dart';
import 'package:p3/class/account.dart'; 

void main(){
  late Account account;

  setUp((){
    account = Account(number: "ISB123002"); 
  });
  
  test('Balance inicial', 
    (){
      expect(account.balance, 0);
    });

  test("No se permite depositar cantidad negativa",
    (){
      expect(account.deposit(-1), false);
    }); 

  test("No se permite depositar cantidad 0 ", 
    (){
      expect(account.deposit(0), false);
    });
  
  test("Se ha depositado una cantidad positiva", 
    (){
      expect(account.balance, 0);
      expect(account.deposit(100), true); 
      expect(account.balance, 100);
    });

  test("No se permite retirar cantidad negativa",
    (){
      expect(account.withdraw(-1), false);
    }); 

  test("No se permite depositar cantidad 0 ", 
    (){
      expect(account.withdraw(0), false);
    });

  test("No se puede retirar una cantidad mayor al saldo de la cuenta", 
  (){

    expect(account.balance, 0);
    expect(account.withdraw(100), false); 

  });

  test("Se retira una cantidad positiva y menor o igual a la cantidad que esta en la cuenta", 
    (){
      account.deposit(100); 
      expect(account.withdraw(100), true); 
      expect(account.balance, 0);
    });
}