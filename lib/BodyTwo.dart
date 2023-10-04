import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BodyTwo extends StatelessWidget {
  const BodyTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height:
          MediaQuery.of(context).size.height - 148 - (Platform.isIOS ? 78 : 24),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("todoList").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document["title"],
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                document["release_date"],
                                style: TextStyle(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("todoList")
                                  .doc(document.id)
                                  .delete();
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
