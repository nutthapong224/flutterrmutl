import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practiceflutter/signup_screen.dart';
import 'package:practiceflutter/welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {  
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  TextEditingController _emailController = TextEditingController(); 
  TextEditingController _passController = TextEditingController(); 
 
 String _email = ""; 
 String _password = ""; 
 void  _handleLogin() async{
  try{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    print("User Logged In: ${userCredential.user!.email}"); 
     Navigator.push(context, MaterialPageRoute(builder: (context)=>const Welcome()));
  
  }catch(e){
          print("Error During Logged In: $e");
  }
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("หน้าล็อคอิน"),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text("Login", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
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
                 Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(onPressed: (){
                   if(_formKey.currentState!.validate()){
                    _handleLogin();
                   }
                 }, child: const Text("Login")), 
                 SizedBox(width: 50,),  
                ElevatedButton(onPressed: (){
            
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
               }, child: const Text("สมัครสมาชิก ")) ,
                 ],)


            ],
            
            ),key: _formKey,),), 
        
      ),
    );
  }
}