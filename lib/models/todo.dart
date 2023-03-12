class Todo {
  String? id;
  String? text;
  bool done;

  Todo({
    required this.id,
    required this.text,
    this.done = false
  });

  static List<Todo> todoList(){
    return [
      Todo(id: '001', text: 'Task 1', done: true),
      Todo(id: '002', text: 'Task 2', done: true),
      Todo(id: '003', text: 'Task 3', done: true),
      Todo(id: '004', text: 'Task 4'),
      Todo(id: '005', text: 'Task 5'),
      Todo(id: '006', text: 'Task 6')
    ];
  }
}