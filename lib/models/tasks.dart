class Task {
  int id = 0;
  String title = '';
  String description = '';
  DateTime doBy = DateTime.now();
  bool completed = false;

  Task(
      {this.id = 0,
      this.title = '',
      this.description = '',
      required this.doBy,
      this.completed = false});
}
