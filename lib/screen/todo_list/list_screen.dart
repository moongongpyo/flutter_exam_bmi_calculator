import 'package:bmi_calculator/screen/gps_map/gps_map.dart';
import 'package:bmi_calculator/screen/todo_list/todo_item.dart';
import 'package:bmi_calculator/util/orientation_util.dart';
import 'package:flutter/material.dart';

import 'package:bmi_calculator/main.dart';
import 'package:flutter/services.dart';
import 'create_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  void initState() {
    super.initState();
    OrientationUtil.setPortrait(); // 세로 모드 적용
  }

  @override
  void dispose() {
    OrientationUtil.setLandscape(); // 가로 모드 적용
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 리스트'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GpsMap()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: todos.values
            .map((e) => TodoItem(
                  todo: e,
                  onTap: (todo) async {
                    todo.isDone = !todo.isDone;
                    await todo.save();

                    setState(() {});
                  },
                  onDelete: (todo) async {
                    await todo.delete();
                    setState(() {});
                  },
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            //await을 해서 화면이 돌아올때 까지 기다리게 해야 함
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          );
          setState(() {}); //돌아오면 화면 갱신
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
