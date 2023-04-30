import 'package:flutter/material.dart';
import 'package:http/http.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller=TextEditingController();
    TextEditingController passwordcontroller=TextEditingController();
  void  login(String email,password) async{
      try{
Response response= await post(
  Uri.parse('https://reqres.in/api/register'),
  body:{
    'email':email,
    'password': password

  }
);
if(response.statusCode==200){
print('created');

}
else{
  print('failed');

}

      }
      catch(e){
      print(e.toString());
      }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Signup'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            TextFormField(
              controller: emailcontroller,
              decoration:const InputDecoration(
                hintText: 'Email',
                ),


            ),
            TextFormField(controller: passwordcontroller,
              decoration:const InputDecoration(
                hintText: 'Password'),


            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (() {
                login(emailcontroller.text.toString(),passwordcontroller.text.toString());
              }),
              child: Container(
                height: 50,
                       
                decoration:BoxDecoration(
                  color: Color(0xFFA3811E),
                  borderRadius: BorderRadius.circular(10)
                ),
                child:const Center(
                  child:   Text('Sign Up')),
              ),
            )

          ],
        ),
      ),
    );
  }
  
}