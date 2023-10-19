import 'package:flutter/material.dart';
import 'package:flutter_todolist_app/component/colors.dart';
import 'package:flutter_todolist_app/widgets/toDoItems.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<ToDo> _foundToDo = [];
  // Ini adalah deklarasi variabel _foundToDo, yang merupakan daftar dari list yang akan digunakan untuk menampung hasil pencarian. Pada awalnya, daftar ini kosong.
  @override
  void initState() {
    _foundToDo = toDoListItems;
    // Ini adalah metode yang dipanggil saat widget diinisialisasi. Pada dasarnya, ketika aplikasi dimulai, kita menginisialisasi _foundToDo dengan daftar tugas awal dari toDoListItems.
    super.initState();
  }

  final toDoListItems = ToDo.toDoList();
  //  digunakan untuk membuat sebuah variabel bernama toDoListItems yang akan menyimpan daftar List yang telah diinisialisasi melalui metode statis toDoList() dari kelas ToDo.
  final _todoController = TextEditingController();
  // mengatur dan mengakses teks yang dimasukkan oleh pengguna ke dalam elemen input teks. Misalnya, Anda dapat mengambil teks yang dimasukkan oleh pengguna dengan _todoController.text atau menghapus teks dengan _todoController.clear(). Hal ini memudahkan Anda dalam mengelola elemen input teks dalam aplikasi Flutter Anda.
  void _toggleToChange(ToDo todoItem) {
    setState(() {
      todoItem.isDone = !todoItem.isDone;
    });
  }

  void _deleteItemsForToDo(String idToDo) {
    setState(() {
      toDoListItems.removeWhere((item) => item.id == idToDo);
      // Ini pernyataan di dalam setState. Ini digunakan untuk menghapus item dari daftar toDoListItems berdasarkan kondisi yang diberikan.
      // Dalam hal ini, kita mencari item yang memiliki id yang sama dengan nilai yang diberikan dalam parameter idToDo. Jika ada item dengan id yang cocok, item tersebut akan dihapus dari daftar.
    });
  }

  void _addItemsForToDo(String newTodo) {
    setState(() {
      toDoListItems.add(ToDo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              toDoText: newTodo)
//   Di dalam blok setState, telah ditambahkan tugas baru ke dalam daftar toDoListItems.
// Anda membuat objek ToDo baru dengan id yang dihasilkan dari waktu saat ini (menggunakan DateTime.now().millisecondsSinceEpoch.toString()) dan teks tugas yang sesuai dengan newTodo. Kemudian, objek ini ditambahkan ke daftar toDoListItems.
          );
      _todoController.clear();
    });
  }

  //   _todoController.clear(): Setelah menambahkan tugas, Anda membersihkan elemen input teks dengan menggunakan _todoController.clear(). Ini berarti bahwa teks yang dimasukkan oleh pengguna sebelumnya akan dihapus, sehingga mereka dapat memasukkan tugas baru tanpa harus menghapus teks yang lama secara manual.
  void _searchObject(String enteredKeyWords) {
    List<ToDo> result = [];
    if (enteredKeyWords.isEmpty) {
      result = toDoListItems;
    } else {
      result = toDoListItems
          .where((itemTodo) => itemTodo.toDoText
              .toLowerCase()
              .contains(enteredKeyWords.toLowerCase()))
          .toList();
// : Ini adalah fungsi lambda (fungsi anonim) yang digunakan sebagai kriteria penyaringan. Ini akan diterapkan pada setiap elemen toDoListItems.
// itemTodo adalah elemen saat ini dalam iterasi, yang merupakan objek tugas.
// itemTodo.toDoText adalah teks dari tugas saat ini.
// .toLowerCase() digunakan untuk mengonversi teks tugas dan kata kunci pencarian menjadi huruf kecil agar pencarian tidak bersifat case-sensitive.
// .contains(enteredKeyWords.toLowerCase()) digunakan untuk memeriksa apakah teks tugas saat ini mengandung kata kunci pencarian yang telah diubah menjadi huruf kecil. Jika ya, elemen tugas ini akan disaring.
    }
    setState(() {
      _foundToDo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: tdBgColor,
            leading: Icon(
              Icons.menu,
              color: tdBlackColor,
              size: 30,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/image/avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Center(
                child: Column(children: <Widget>[
                  Search( onchanged: (value) {
                        _searchObject(value);
                      },),
                  Expanded(
                    //Expanded Digunakan Untuk membuat tata letak yg dinamis resposif atau mengisi full ruang kosong sampai batas layar
                    child: ListView(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Text(
                              "All Todo",
                              style:
                                  TextStyle(color: tdBlackColor, fontSize: 25),
                            )),
                        for (ToDo todoItems in _foundToDo.reversed)
                          // deklarasi loop atau perulangan yang digunakan untuk mengulangi (iterasi) setiap elemen dalam daftar toDoListItems.
                          // ToDo: Ini adalah class yg menjadi tipe data yang digunakan untuk menentukan tipe variabel todoItems. Dalam hal ini, kita mengasumsikan bahwa ToDo adalah tipe data yang mewakili item dalam daftar toDoListItems.
                          // todoItems: Ini adalah variabel yang digunakan untuk merepresentasikan setiap elemen dalam daftar toDoListItems selama iterasi. Anda dapat memberi nama variabel ini sesuai dengan preferensi Anda.
                          // in: Ini adalah kata kunci yang digunakan untuk menunjukkan bahwa kita akan mengiterasi melalui elemen dalam daftar.
                          // _foundToDo: Ini adalah daftar (list) yang akan diiterasi, dan setiap elemennya akan diwakili oleh variabel todoItems selama iterasi.
                          // .reversed: artinya kebalikan dari daftar
                          toDoItems(
                            onDeleteItem: _deleteItemsForToDo,
                            onToDoChanged: _toggleToChange,
                            todoItem: todoItems,
                            //  Ini adalah parameter dengan nama 'todoItem' yang diberikan kepada widget 'toDoItems'. Ini digunakan untuk memberikan objek ToDo yang akan ditampilkan atau dikelola oleh widget 'toDoItems'.
                            // Dengan cara ini, widget 'toDoItems' dapat menampilkan dan mengelola informasi tentang daftar yang diberikan.
                          ),
                      ],
                    ),
                  )
                ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                        top: 20, right: 10, bottom: 20, left: 20),
                    decoration: BoxDecoration(
                        color: tdBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: tdGreyColor,
                              blurRadius: 10.0,
                              offset: Offset(0, 0),
                              spreadRadius: 0.0)
                        ]),
                    child: TextFormField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: "Add A New List",
                          hintStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        color: tdDarkBlueColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: IconButton(
                      onPressed: () {
                        _addItemsForToDo(_todoController.text);
                      },
                      icon: Icon(
                        Icons.add,
                        color: tdBgColor,
                        size: 30,
                      ),
                    ),
                  )
                ]),
              )
            ],
          )),
    );
  }
}

class Search extends StatelessWidget {
  final Function(String) onchanged;
  const Search({super.key,required this.onchanged});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        height: 45,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            border: Border.all(color: tdGreyColor),
            color: tdBgColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextFormField(
          onChanged: onchanged,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search_rounded),
              prefixIconColor: tdGreyColor,
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ));
  }
}
