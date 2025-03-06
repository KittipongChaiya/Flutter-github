import 'package:flutter/foundation.dart';
import 'package:myproject/models/transaction.dart';

class TransactionProvider with ChangeNotifier{
  //ข้อมูล
  List<Transaction> transactions = [
    
  ];

  //ดึงข้อมูล
  List<Transaction> getTransaction(){
    return transactions;
  }

  void addTransaction(Transaction statement){
    transactions.insert(0, (statement));
    notifyListeners();
  }
}