import 'package:flutter/foundation.dart';
import 'package:myproject/database/transaction_db.dart';
import 'package:myproject/models/transactions.dart';

class TransactionProvider with ChangeNotifier{
  //ข้อมูล
  List<Transactions> transactions = [
    
  ];

  //ดึงข้อมูล
  List<Transactions> getTransaction(){
    return transactions;
  }

  void initData() async{
    var db = TransactionDB(dbName: "transaction.db");
    //ดึงข้อมูลตอนเริ่มต้น
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async{
    //ปิดไว้ก่อนเพราะเราจะย้านไปใช้ฐานข้อมูล var db = await TransactionDB(dbName: "transaction.db").openDatabase();
    //ปิดไว้ก่อนเพราะเราจะย้านไปใช้ฐานข้อมูล print(db);

    var db = await TransactionDB(dbName: "transaction.db");
    //จากนั้นบันทึกข้อมูล
    await db.InsertData(statement);

    //แสดงข้อมูล
    transactions = await db.loadAllData();

    //transaction.insert(0, (statement));
    notifyListeners();
  }
}