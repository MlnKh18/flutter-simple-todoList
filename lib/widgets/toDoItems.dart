import 'package:flutter/material.dart';
import 'package:flutter_todolist_app/component/colors.dart';

class toDoItems extends StatelessWidget {
  const toDoItems(
      {super.key,
      required this.todoItem,
      required this.onToDoChanged,
      required this.onDeleteItem});
  final ToDo todoItem;
  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
          onTap: () {
            onToDoChanged(todoItem);
            // Pada Saat Pengguna MengTap Element akan menjalankan tindakan dimana kan menjalankan fungsi 'onToDoChanged' dan memberikan'todoItem' sebagai argumen(nilai) ke fungsi tersebut.
          },
          shape: RoundedRectangleBorder(
              side: BorderSide(color: tdGreyColor),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          leading: Icon(
            todoItem.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdDarkBlueColor,
          ),
          tileColor: tdBgColor,
          title: Text(
            todoItem.toDoText,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: tdBlackColor,
                decoration:
                    todoItem.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 204, 45, 34),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: tdBgColor,
              ),
              onPressed: () {
                onDeleteItem(todoItem.id);
                // Ini adalah aksi yang akan dijalankan ketika tombol ditekan. Pada dasarnya, aksi ini memanggil fungsi onDeleteItem dengan argumen todoItem.id. Artinya, saat tombol ditekan, Anda akan memanggil fungsi onDeleteItem dan memberikan id dari todoItem sebagai argumen ke fungsi tersebut.
              },
            ),
          )),
    );
  }
}

class ToDo {
  String id;
  String toDoText;
  bool isDone;

  // Konstruktor untuk membuat objek ToDo dengan parameter yang wajib (required) dan nilai default untuk isDone
  ToDo({required this.id, required this.toDoText, this.isDone = false});

  // Static method untuk membuat daftar  ToDoList
  static List<ToDo> toDoList() {
    return [
      ToDo(id: '01', toDoText: 'Maulana', isDone: true),
      ToDo(
        id: '02',
        toDoText: 'Naufal',
      ),
      ToDo(id: '03', toDoText: 'Samsul', isDone: true),
      ToDo(
        id: '04',
        toDoText: 'Indra',
      ),
      ToDo(id: '05', toDoText: 'Khairuman', isDone: true),
    ];
  }
}
