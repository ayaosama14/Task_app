import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_with_cubit/cubit/cubit.dart';
import 'package:sqflite_with_cubit/cubit/states.dart';

class Archiveview extends StatefulWidget {
  const Archiveview({super.key});

  @override
  State<Archiveview> createState() => _View2State();
}

class _View2State extends State<Archiveview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubita, States>(
      builder: (context, state) {
        return Scaffold(body: body());
      },
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) =>
              buildNoteItem(index),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 12),
          itemCount: Cubita.get(context).listOfDBArchive == null
              ? 0
              : Cubita.get(context).listOfDBArchive!.length),
    );
  }

  //##########

  buildNoteItem(int index) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 16, 236, 156),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 9, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //row1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '${Cubita.get(context).listOfDBArchive![index]['title']}',
                      style: const TextStyle(fontSize: 23, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '  '
                      '${Cubita.get(context).listOfDBArchive![index]['content']}',
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                ),
                //row2
                Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        Cubita.get(context).updateTask(
                            status: 'done',
                            id: Cubita.get(context).listOfDBArchive![index]['id']);
                      },
                      icon: const Icon(
                        Icons.check_box,
                        size: 28,
                        color: Colors.black,
                      ),
                    ),

                    //
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        Cubita.get(context).updateTask(
                            status: 'archive',
                            id: Cubita.get(context).listOfDBArchive![index]['id']);
                      },
                      icon: const Icon(
                        Icons.archive,
                        size: 28,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(
              height: 35,
            ),
            Text(
              '${Cubita.get(context).listOfDBArchive![index]['date']}',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
