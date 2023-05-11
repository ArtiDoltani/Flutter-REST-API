import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;


class UploadimageScreen extends StatefulWidget {
  const UploadimageScreen({Key? key}) : super(key: key);

  @override
  State<UploadimageScreen> createState() => _UploadimageScreenState();
}

class _UploadimageScreenState extends State<UploadimageScreen> {
  File? image;
   final _picker=ImagePicker();
   bool showSpinner= false;
   Future getimage() async{
    final pickedfile=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedfile!=null){
      image=File(pickedfile.path);
      setState(() {
        
      });
  
    }
    else{
      print('image not selected');
    } }
    Future<void> uploadimage()async{
setState(() {
  showSpinner=true;
});
var stream= http.ByteStream(image!.openRead());
stream.cast();
var length=await image!.length();
var uri=Uri.parse('https://fakestoreapi.com/products');
var request= http.MultipartRequest('post', uri);
 request.fields['title']="Static title";
 var multiport= http.MultipartFile('image', stream, length);
 request.files.add(multiport);
 var reponse= await request.send();
 if(reponse.statusCode==200){
  print('image uploaded');
  setState(() {
    showSpinner=false;
  });
 }
 else{
   setState(() {
    showSpinner=false;
  });
  print('failed');
 }

    }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
     inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title:const Text('Upload Image'),
        automaticallyImplyLeading: false,),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          GestureDetector(
            onTap: () {
              getimage();
            },
            child: Container(
              child: image==null ?const Center(child: Text('Pick image')): Container(
                child: Center(
                  child: Image.file(
                    File(image!.path).absolute,
                height: 100,
               
              fit: BoxFit.cover,
                    ),
                ),
              ) ,
            ),
          ),
        const  SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
              uploadimage();
            },
            child: Container(
              height: 50,
             
              color: Colors.amber,
              child:const Center(child: Text('Upload')),
          
            ),
          )

        ],),
      ),
    );
  }
}