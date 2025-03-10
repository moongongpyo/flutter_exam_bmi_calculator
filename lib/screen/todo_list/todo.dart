import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0) // 엔티티 객체가 여러 개 있으면 숫자를 바꾸어 줘야 함
class Todo extends HiveObject {

  @HiveField(0)
  int? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int dateTime;

  @HiveField(3)
  bool isDone;

  Todo({
    required this.title,
    required this.dateTime,
    this.isDone = false,
  });
}
