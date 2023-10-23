import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practiceflutter/CRUD.dart';
// import 'package:practiceflutter/ItemList.dart';
import 'package:practiceflutter/formscreen.dart';
import 'package:practiceflutter/login_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final FirebaseAuth _auth =  FirebaseAuth.instance;
  
  
  @override
  Widget build(BuildContext context) { 
    String? _email = _auth.currentUser!.email;
    return Scaffold(
    //   appBar: AppBar(
    //   title: const Text("Dashboard"),
    // ), 
    body: Padding(padding: const EdgeInsets.all(15), 
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [  
          const SizedBox(height: 50,),   
          SearchBar(
             padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)), 
                  leading:  Row(children: [Icon(Icons.search),Text("Search  files")],),
          ),
           
          Card(
             margin: const EdgeInsets.all(10) , 
              child: ListTile(
                      title: Text(
                          "กรอกข้อมูลการเพาะเลี้ยง",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const FormScreen()));
                      },
              ),
            
          ), 
          Card(
             margin: const EdgeInsets.all(10) , 
              child: ListTile( 
                
                      title: Text(
                          "รายงานผลการเพาะเลี้ยง",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const  CRUDEoperation()));
                      },
              ),
            
          ), 
         
          const SizedBox(height: 80,), 
           ElevatedButton(onPressed: (){
            _auth.signOut(); 
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
          }, child: const Text("ออกจากระบบ")) , 
        ],
      ),
    ),
    ),
    );
  }
}