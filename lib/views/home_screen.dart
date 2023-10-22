import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_with_cubit/cubit/cubit.dart';
import 'package:sqflite_with_cubit/cubit/states.dart';
import 'package:sqflite_with_cubit/widget/custom_button.dart';
import 'package:sqflite_with_cubit/widget/custom_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> myScaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  String? title;

  String? content;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubita, States>(
      listener: (context, state) {
        if (state is InsertIntoDataBaseState) {
          // Navigator.of(context).pop();
          Cubita.get(context).getRecordsFromDb(Cubita.get(context).database);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            key: myScaffoldKey,
            appBar: AppBar(
              elevation: 12.0,
              backgroundColor: Colors.cyan[200],
              title: Text(
                  '${Cubita.get(context).changeTitle[Cubita.get(context).mycubitIndex]}'),
            ),
            body: changeBody[Cubita.get(context).mycubitIndex],
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  setState(() {});
                  myScaffoldKey.currentState!
                      .showBottomSheet((context) => form());
                }),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: "Task"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archive"),
              ],
              // backgroundColor: Colors.orangeAccent,
              iconSize: 26.0,
              selectedItemColor: Colors.cyan,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                Cubita.get(context).changeIndexBottomNav(index);
              },
              currentIndex: Cubita.get(context).mycubitIndex,
              type: BottomNavigationBarType.shifting,
              elevation: 29.0,
            ),
          ),
        );
      },
    );
  }

  //################
  Widget form() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white12,
        child: Form(
          key: myFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 32,
                ),
                CustomTextField(
                    maxline: 1, myController: titleController, hint: 'title'),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                    maxline: 2,
                    myController: contentController,
                    hint: 'content'),
                const SizedBox(
                  height: 32,
                ),
                CustomButton(
                  onPressed: () async {
                    setState(() {});
                    if (myFormKey.currentState!.validate()) {
                      title = titleController.text;
                      content = contentController.text;
                      var currentDate = DateTime.now();

                      var formattedCurrentDate =
                          DateFormat.yMd().format(currentDate);
                      print(title);
                      print(content);
                      Cubita.get(context).insertRecordIntoDB(
                          title: title,
                          content: content,
                          date: formattedCurrentDate);
                      Navigator.pop(context);
                    }
                    print('inserted started');
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
