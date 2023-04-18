import 'dart:convert';

import 'package:api/Models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserExample extends StatefulWidget {
  const UserExample({Key? key}) : super(key: key);

  @override
  State<UserExample> createState() => _UserExampleState();
}

class _UserExampleState extends State<UserExample> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getuserModel() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Model'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getuserModel(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: userlist.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Name',
                                  value: snapshot.data![index].name.toString()),
                              ReusableRow(
                                  title: 'Email',
                                  value:
                                      snapshot.data![index].email.toString()),
                              ReusableRow(
                                  title: 'Company Name',
                                  value: snapshot.data![index].company!.name
                                      .toString()),
                            ],
                          ),
                        );
                      })),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);
  String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
