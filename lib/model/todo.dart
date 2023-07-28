class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: '6 AM Workout', isDone: true ),
      ToDo(id: '02', todoText: 'Post Workout Meal', isDone: true ),
      ToDo(id: '03', todoText: 'Work on Project for 3 hours', ),
      ToDo(id: '04', todoText: 'Check GitHub', ),
      ToDo(id: '05', todoText: 'Cold Coffee Break', ),
      ToDo(id: '06', todoText: 'Evening Walk', ),
    ];
  }
}