import 'dart:convert';

import 'package:api/user_Example.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getuserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User data without Model'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getuserApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          return Card(
                              child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Name', value: data[index]['name']),
                              ReusableRow(
                                  title: 'Email', value: data[index]['email']),
                              ReusableRow(
                                  title: 'Address',
                                  value: data[index]['address']['street'])
                            ],
                          ));
                        }));
                  }
                }),
          )
        ],
      ),
    );
  }
}
