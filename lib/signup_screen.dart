import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practiceflutter/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {  
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  TextEditingController _emailController = TextEditingController(); 
  TextEditingController _passController = TextEditingController(); 
 
 String _email = ""; 
 String _password = ""; 
 void _handleSighUp() async{
  try{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
    print("User Registered: ${userCredential.user!.email}"); 
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  
  }catch(e){
          print("Error During Registration: $e");
  }
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("หน้าสมัครสมาชิก"),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
               Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text("สมัครสมาชิก", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  ), 
                 TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Email"
                  ),
                  validator: (value){
                        if(value==null||value.isEmpty){
                             return "Please Enter your email";
                        } 
                        return null;
                  }, 
                  onChanged: (value){
                    setState(() {
                      _email=value;
                    });
                  },
                 ), 
                 const SizedBox(height: 20,), 
                  TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Password"
                  ),
                  validator: (value){
                        if(value==null||value.isEmpty){
                             return "Please Enter your password";
                        } 
                        return null;
                  }, 
                  onChanged: (value){
                    setState(() {
                      _password=value;
                    });
                  },
                 ),  
                  SizedBox(height: 30,),
                 ElevatedButton(onPressed: (){
                   if(_formKey.currentState!.validate()){
                    _handleSighUp();
                   }
                 }, child: const Text("สมัครสมาชิก"))


            ],
            
            ),key: _formKey,),), 
        
      ),
    );
  }
}