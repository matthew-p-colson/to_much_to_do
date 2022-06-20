import 'package:flutter/material.dart';
import 'package:to_much_to_do/models/tasks.dart';
import 'package:to_much_to_do/screens/new_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        leading: const Icon(
          Icons.rule,
          color: Colors.white,
          size: 30.0,
        ),
        title: const Text(
          'To Much To Do',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ShadowsIntoLight',
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: const ToDoList(),
      ),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool? complete = false;
  DateTime now = DateTime.now();

  List<Task> tasks = [
    Task(
        title: 'Clean Bathroom',
        description: 'Clean toilet, sink, and bath tub.',
        doBy: DateTime.now()),
    Task(
        title: 'Clean Bedroom',
        description: 'Clean floor, closet, and make bed.',
        doBy: DateTime.now()),
    Task(
        title: 'Change Cat Litter',
        description:
            'Throw out old cat litter, change liner, and fill with new litter.',
        doBy: DateTime.now())
  ];

  List<Card> buildToDoCards() {
    List<Card> cards = [];

    for (var task in tasks) {
      if (!task.completed) {
        cards.add(buildToDoItem(task));
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewScreen()))
                .then((newTask) {
              setState(() {
                tasks.add(newTask);
                buildToDoCards();
              });
            });
          },
          child: const Text(
            'Create New Task',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ShadowsIntoLight',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: buildToDoCards(),
          ),
        ),
      ],
    );
  }

  Card buildToDoItem(Task taskIn) {
    return Card(
      color: Colors.blueGrey.shade800,
      child: ListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          value: taskIn.completed,
          onChanged: (value) {
            setState(() {
              taskIn.completed = value!;
              buildToDoCards();
            });
          },
        ),
        title: Text(
          taskIn.title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'ShadowsIntoLight',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 2.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskIn.description,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              '${taskIn.doBy.month}/${taskIn.doBy.day}/${taskIn.doBy.year} -  ${taskIn.doBy.hour}:${taskIn.doBy.minute}',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
