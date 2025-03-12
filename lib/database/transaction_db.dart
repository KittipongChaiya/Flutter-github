import 'dart:io';
import 'package:myproject/models/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String dbName; //เก็บชื่อฐานข้อมูล

  //ถ้ายังไม่มีฐานข้อมูลให้สร้างฐานข้อมูล
  //ถ้ามีฐานข้อมูลให้เปิดฐานข้อมูล
  TransactionDB({required this.dbName});

  //dbName = transaction.db
  Future<Database> openDatabase() async {
    //หาตําแหน่งของฐานข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    //สร้างฐานข้อมูล
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async{

    //ฐานข้อมูล => store
    //transaction => expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    //json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;//1,2,3,4
  }

  //ดึงข้อมูล
  Future<List<Transactions>> loadAllData() async{
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));//false เรียงจากมากไปน้อย, true เรียงจากน้อยไปมาก
    List<Transactions> transactionList = [];
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record['title'].toString(),
          amount: double.parse(record['amount'].toString()),
          date: DateTime.parse(record['date'].toString())
      ));
    }

    //print(snapshot);
    return transactionList;
  }
}