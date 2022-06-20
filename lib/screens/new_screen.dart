import 'package:flutter/material.dart';
import 'package:to_much_to_do/models/tasks.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

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
        child: const NewForm(),
      ),
    );
  }
}

class NewForm extends StatefulWidget {
  const NewForm({Key? key}) : super(key: key);

  @override
  State<NewForm> createState() => _NewFormState();
}

class _NewFormState extends State<NewForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DateTime taskDate = DateTime.now();
  TimeOfDay taskTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                hintText: 'Clean Bathroom',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task needs a title...';
                }
                return null;
              },
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                hintText: 'Clean around toilet, sink, and bath tub.',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You should explain your task...';
                }
                return null;
              },
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Do By Date',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: dateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Every task needs a date...';
                }
                return null;
              },
              onTap: () {
                setState(() async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  taskDate = date!;
                  dateController.text = date.toString().substring(0, 10);
                });
              },
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Do By Time',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: timeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Every task needs a time...';
                }
                return null;
              },
              onTap: () {
                setState(() async {
                  var time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  taskTime = time!;
                  timeController.text = '${time.hour}:${time.minute}';
                });
              },
            ),
            TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var newTask = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      doBy: DateTime(taskDate.year, taskDate.hour,
                          taskDate.month, taskTime.hour, taskTime.minute),
                    );

                    Navigator.pop(context, newTask);
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ShadowsIntoLight',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    letterSpacing: 1.5,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
