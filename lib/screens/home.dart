import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  // this is for SEARCHING using the search bar
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      drawer: Drawer(
          child: ListView(
            children: [

              const DrawerHeader(
                decoration: BoxDecoration(
                  color: tdBGColor,
                ),
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Hafsa Abid', style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: tdBlue,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color:tdBlue),
                title: const Text('View Profile'),
                onTap: () {   },
              ),
              ListTile(
                leading: const Icon(Icons.star, color:tdBlue ,),
                title: const Text('Star Tasks'),
                onTap: () {    },
              ),
              ListTile(
                title: DropdownButton<String>(
                  value:'All',
                  onChanged:(String? newValue) {
                    // Implement what to do when a new value is selected
                    // For example update a variable or perform some action
                  },
                  items: <String>[
                    'All',
                    'Work',
                    'Personal',
                    'Wishlist',
                    'Birthday',
                  ].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.format_paint_outlined, color: tdBlue,),
                title:  const Text('Theme'),
                onTap: () { },
              ),
              ListTile(
                leading: const Icon(Icons.note_alt_outlined, color: tdBlue,),
                title: const Text('Feedback'),
                onTap: () {   },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: tdBlue,),
                title: const Text('FAQ'),
                onTap: () {   },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: tdBlue,),
                title: const Text('Settings'),
                onTap: () {   },
              ),
            ],
          ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      //this shows the list of tasks
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // Function used to check/uncheck the task in the list
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  //function used to delete a task from the list
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  //Function used to add an item in the list
  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    //this clears the placeholder text as we start typing
    _todoController.clear();
  }

  // Function used to search tasks from the list using search bar
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    // When the search bar is empty all the tasks will be displayed on the screen
    if (enteredKeyword.isEmpty)
    {
      results = todosList;
    }
    // The tasks are filtered as we search for our desired keyword
    else
    {
      results = todosList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  // Search Box
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  //App Bar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBlue,
      elevation: 0,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.menu, color: tdBlue,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/me.png'),
          ),
        ),
      ]),
    );
  }
}
