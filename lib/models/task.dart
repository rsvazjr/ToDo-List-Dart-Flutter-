import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  String description;
  bool isDone;
  int priority;

  List<int> _priorities = <int>[1, 2, 3, 4, 5];

  Task({
    this.id,
    this.title,
    this.description,
    this.isDone = false,
    this.priority
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"] == 1,
        priority: json["priority"]
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone ? 1 : 0,
      "priority": priority
    };

    if (id != null) map["id"] = id;

    return map;
  }

    List<int> getPriorities(){
      return _priorities;
    }

    Color getPriorityColor(){
      
      switch(priority){

        case 1:
          return Colors.green[300];
        break;

        case 2:
          return Colors.blue[400];
        break;

        case 3:
          return Colors.yellow[400];
        break;

        case 4:
          return Colors.orange[400];
        break;

        case 5:
          return Colors.red[400];
        break;

        default: return Colors.white;
      }
    }
}
