import 'package:demoproject/constants/colors.dart';
import 'package:demoproject/model/todo.dart';
import 'package:demoproject/widgets/todo_iteam.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  final todoController = TextEditingController();
  List<ToDo> findToDo = [];

  @override
  void initState() {
    findToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tdBGColor,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(
            Icons.menu,
            size: 30,
            color: tdBlack,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/profile-picture.webp'),
            ),
          )
        ]),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text('All ToDos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                      ),
                      for (ToDo todoo in findToDo.reversed)
                        ToDoIteam(
                            todo: todoo,
                            onToDoChanged: handalToDoChange,
                            onDeleteItem: deleteToDoIteam),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.0,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.0))
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new ToDo iteam',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoIteam(todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  void searchBar(String enteredKeywords) {
    List<ToDo> result = [];
    if (enteredKeywords.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(enteredKeywords.toLowerCase()))
          .toList();
    }
    setState(() {
      findToDo = result;
    });
  }

  void addToDoIteam(String todo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    todoController.clear();
  }

  void handalToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void deleteToDoIteam(String id) {
    setState(() {
      todoList.removeWhere((iteam) => iteam.id == id);
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => searchBar(value),
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
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }
}
