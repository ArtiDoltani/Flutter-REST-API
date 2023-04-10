import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photolist = [];
  Future<List<Photos>> getphotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photolist.add(photos);
      }
      return photolist;
    } else {
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getphotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: photolist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          subtitle: Text(snapshot.data![index].title),
                          title: Text(
                              'id: ' + snapshot.data![index].id.toString()),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}

// photos Model
class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
