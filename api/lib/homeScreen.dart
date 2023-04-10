import 'dart:convert';

import 'package:api/Models/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Posts> postlist = [];

  Future<List<Posts>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postlist.clear();
      for (Map i in data) {
        postlist.add(Posts.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API'),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('loading');
                  } else {
                    return Expanded(
                      child: ListView.builder(itemBuilder: (context, index) {
                        return Card(
                          color: const Color.fromARGB(255, 238, 202, 84),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Title  ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 95, 80, 80)),
                                ),
                                Text(postlist[index].title.toString()),
                                const Text(
                                  'Description  ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 95, 80, 80)),
                                ),
                                Text(postlist[index].body.toString())
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }
                })
          ],
        ));
  }
}
