import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_with_cubit/cubit/states.dart';
import 'package:sqflite_with_cubit/views/archive_screen.dart';
import 'package:sqflite_with_cubit/views/task_view.dart';

import '../views/done_view.dart';

List changeBody = [
  const ViewTaskScreen(),
  const DoneView(),
  const Archiveview()
];

class Cubita extends Cubit<States> {
  Cubita() : super(InitState());
  int mycubitIndex = 0;
  static Cubita get(context) => BlocProvider.of(context);

  List changeTitle = ['New_Task', 'Done', 'Archive'];

  Database? database;
  List<Map>? listOfDB;
  List<Map>? listOfDBDone;
  List<Map>? listOfDBArchive;
  //#############
  changeIndexBottomNav(int index) {
    mycubitIndex = index;
    emit(ChangeBottomNavState());
  }

  //#########
  //creatdatabase
  Future creatDatabase() async {
    database = await openDatabase('todo.dp', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      print('database created');
      await db
          .execute(
              'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, content TEXT, date Text,status Text)')
          .then((value) {
        print('tabel created');
        emit(CreatDataBaseState());
      }).catchError((error) {
        print('error is $error');
      });
    }, onOpen: (Database dp) {
      print('database opend');
      getRecordsFromDb(database);
    });
  }

  //############
  //Insert some records in a transaction
  Future insertRecordIntoDB(
      {required title, required content, required date}) async {
    return database?.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Task (title, content, date,status) VALUES("$title","$content", "$date","new")');
    }).then((value) {
      print('inserted done');
      emit(InsertIntoDataBaseState());
      // getDatabasesPath();
    }).catchError((error) {
      print('error from insert is $error');
    });
  }

  // Get the records
  getRecordsFromDb(database) async {
    listOfDB = [];
    listOfDBDone = [];
    listOfDBArchive = [];
    database.rawQuery('SELECT * FROM Task').then((value) {
      value.forEach((element) {
        if (element['status'] == "new") {
          listOfDB!.add(element);
          emit(GetDataBaseState());
        } else if (element['status'] == 'done') {
          listOfDBDone!.add(element);
          emit(GetDataBaseState());
        } else {
          listOfDBArchive!.add(element);
          emit(GetDataBaseState());
        }
      });

      emit(GetDataBaseState());
    }).catchError((error) {});

    print('getRecordsFromDb');
    print(listOfDB);
    print(listOfDBDone);
    print(listOfDBArchive);
  }

  // Delete a record
  Future deleteFromDb({required id}) async {
    return await database!
        .rawDelete('DELETE FROM Task WHERE id = ?', [id]).then((value) {
      print('raw deleted success');
      emit(DeleteDataBaseState());
      getRecordsFromDb(database);
    }).catchError((error) {
      // print('error');
    });
  }

  // Update some record
  updateTask({required status, required int id}) async {
    return await database!.rawUpdate('UPDATE Task SET status ? WHERE id = ?',
        ['$status', '$id']).then((value) {
      emit(UpDateState());
      getDatabasesPath();
    }).catchError((error) {
      print(error);
    });
    // print('updated: $count');
  }
}
