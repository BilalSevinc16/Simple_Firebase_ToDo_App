import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BodyOne extends StatefulWidget {
  const BodyOne({Key? key}) : super(key: key);

  @override
  State<BodyOne> createState() => _BodyOneState();
}

class _BodyOneState extends State<BodyOne> {
  late String _text;
  late String _releaseDate;

  Future<void> _addTodo(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Todo"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _text = value;
                  _releaseDate = DateTime.now().toString();
                });
              },
            ),
            actions: [
              TextButton(
                child: const Text("Add"),
                onPressed: () {
                  setState(() {
                    /*_myList
                          .add((title: _text, release_date: _release_date));*/
                    FirebaseFirestore.instance
                        .collection("todoList")
                        .doc()
                        .set({
                      "title": _text,
                      "release_date": _releaseDate,
                    });
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 148,
      child: Stack(
        children: [
          Container(
            width: width,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                "Todo App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: width - 56 - 16,
            top: 92,
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                /*setState(() {
                          _myList.add((title: "sad", release_date: ""));
                        });*/
                _addTodo(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
