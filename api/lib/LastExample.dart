import 'dart:convert';

import 'package:api/Models/products/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LastExample extends StatefulWidget {
  const LastExample({Key? key}) : super(key: key);

  @override
  State<LastExample> createState() => _LastExampleState();
}

class _LastExampleState extends State<LastExample> {
Future<Products> productModel()async{
final response=await http.get(Uri.parse('https://webhook.site/fd486bfd-0966-49d7-a0d6-330645e3394d'));
var data= jsonDecode(response.body.toString());
if(response.statusCode==200){
 return Products.fromJson(data);
}
else{
  return Products.fromJson(data);
}
  

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('API'),),
      body: Padding(
        padding: const EdgeInsets.all( 20),
        child: Column(
          children: [
          Expanded(
            child: FutureBuilder<Products>(
            future: productModel(),
            builder: (context, snapshot) {
            if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: ((context, index) {
                return Column(             
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   child: Column(children: [

                    //   ]),
                    // ),
                    ListTile(
                      title: Text(snapshot.data!.data![index].shop!.name.toString()),
                      subtitle:Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                      leading: CircleAvatar(backgroundImage: 
                      NetworkImage(snapshot.data!.data![index].shop!.image.toString()),),
                    ),
                  Container(
                     height: MediaQuery.of(context).size.height*.3,
                      width: MediaQuery.of(context).size.width*1,
                    child: 
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.data![index].images!.length,
                    itemBuilder: ((context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height*.25,
                        width: MediaQuery.of(context).size.width*.5,
                        decoration: BoxDecoration(
                         
                          image: DecorationImage(
                            fit: BoxFit.cover,
                          image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()))
                        ),

                      ),
                      
                    );
                   
                  })
                  )
                  ),
                Icon(snapshot.data!.data![index].inWishlist! == true ? 
                Icons.favorite :Icons.favorite_outline )
                
                ],);
              
            })
            );
            }
            else{
              return const Text('Loading');
            }
          },)
          
          )

        ],),
      ),
    );
  }
}