//lfkasbflkanlfkas
//kjfbkafa
//Tonys
import 'package:flutter/material.dart';
import 'package:simple_todo/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List<String> categories = ['Trabajo', 'Personal', 'Estudio', 'Otro'];
  String selectedCategory = 'Trabajo';
  DateTime selectedDate = DateTime.now();

  List toDoList = [
    ['Steven Criollo', true, 'Trabajo', DateTime.now().add(Duration(days: 1))],
    ['Francis Chafla', true, 'Personal', DateTime.now().add(Duration(days: 2))],
    ['Bryan Guapulema', false, 'Estudio', DateTime.now().add(Duration(days: 3))],
    ['Anthony Pombosa', false, 'Otro', DateTime.now().add(Duration(days: 4))],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false, selectedCategory, selectedDate]);
      _controller.clear();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 117, 158, 205),
      appBar: AppBar(
        title: const Text(
          'Lista de Tareas',
        ),
        backgroundColor: const Color.fromARGB(255, 13, 10, 179),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, index) {
                return TodoList(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  category: toDoList[index][2],
                  dueDate: toDoList[index][3],
                  onChanged: (value) => checkBoxChanged(index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Nueva tarea',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 157, 174, 219),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 58, 77, 183),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 46, 15, 184),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                DropdownButton<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    value: selectedCategory,     
                    dropdownColor: const Color.fromARGB(255, 157, 174, 219),               
                    items: categories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 3, 6, 216),
                          ),
                          ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                  ),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today),
                  color: Colors.white,
                  iconSize: 30,
                  padding: const EdgeInsets.only(left: 10),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [                                          
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveNewTask,
                    child: Text('Añadir'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}