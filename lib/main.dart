import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoList());
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class ToDo{
  bool isDone = false;
  String title;

  ToDo({required this.title});
}

class _ToDoListState extends State<ToDoList> {
  final _list = <ToDo>[];
  var _todoController = TextEditingController();

  @override
  void dispose(){
    _todoController.dispose();
    super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              TextField(
                controller: _todoController,
              ),
              ElevatedButton(
                  onPressed: () {
                    _addToDo(ToDo(title: _todoController.text));
                  },
                  child: Text('추가'),
              ),
              ListView(
                children: _list.map((toDo) => _buildItem(toDo)).toList(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItem(ToDo toDo){
    return ListTile(
      onTap: () => _toggleToDo(toDo),
      title: Text(
        toDo.title,
        style: toDo.isDone? const TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic
        ) : null,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: () => _deleteToDo(toDo),
      ),
    );
  }

  void _addToDo(ToDo toDo){
    setState(() {
      _list.add(toDo);
      _todoController.text = '';
    });
  }

  void _deleteToDo(ToDo toDo){
    setState(() {
      _list.remove(toDo);
    });
  }

  void _toggleToDo(ToDo toDo){
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }
}