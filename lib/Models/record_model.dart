import 'package:hive/hive.dart';

part 'record_model.g.dart';

@HiveType(typeId: 0)
class Record extends HiveObject{

  @HiveField(0)
  String? name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  DateTime? dateTime;

  @HiveField(3)
  bool? done;

  Record({this.name, this.description, this.dateTime, this.done});

}