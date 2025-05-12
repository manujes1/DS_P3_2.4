class Account {
  final String _number;
  double _balance;
  
  Account({required String number})
      : _number = number,
        _balance = 0;
  
  String get number => _number; 
  double get balance => _balance;

  bool deposit(double amount){
    if(amount <= 0){
        return false;
    }
    else{
    _balance += amount;
    return true;
    }
  }

  bool withdraw(double amount){
    if(amount <= 0 || _balance < amount){
        return false;
    }
    else{
      _balance -= amount;
      return true;
    }
  }
}