import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practiceflutter/model/student.dart';
import 'package:practiceflutter/welcome.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>(); 

  Student myStudent = Student(name: '',code: "",number: "",datecome: "", dateout: '',resource: "",des: "",food: "",height: "",width: "",image: "",note: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _studentCollection = FirebaseFirestore.instance.collection("students");
 String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("กรอกข้อมูลการเพาะเลี้ยง"),
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ชื่อ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนชื่อด้วย"),
                          onSaved: (String? name) {
                            myStudent.name = name!;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "รหัส",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกรหัสเพาะเลี้ยง"),
                          onSaved: (String? code) {
                            myStudent.code = code!;
                          }, 
                          keyboardType: TextInputType.number,
                        ), 
                        
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ขวดที่",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: MultiValidator([
                           
                            RequiredValidator(
                                errorText: "กรุณากรอกจำนวนขวด")
                          ]),
                          onSaved: (String? number) {
                            myStudent.number = number!;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "วันที่ปลูก",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกวันที่ปลูก"),
                          onSaved: (String? datecome ) {
                            myStudent.datecome = datecome!;
                          },
                          
                        ), 
                         const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "วันที่ย้าย",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกวันที่ย้าย"),
                          onSaved: (String? dateout ) {
                            myStudent.dateout= dateout!;
                          },
                          
                        ),
                        
                         const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "แหล่งที่มา",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกแหล่งที่มา"),
                          onSaved: (String? resource) {
                            myStudent.resource= resource!;
                          },
                          
                        ),
                         const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "อาหาร",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "อาหาร"),
                          onSaved: (String? food) {
                            myStudent.food = food!;
                          },
                          
                          
                        ), 
                         const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ลักษณะ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกลักษณะ"),
                          onSaved: (String? des ) {
                            myStudent.des = des!;
                          },
                          
                        ), 
                         const SizedBox(
                          height: 15,
                        ),
                        
                         const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ความกว้าง",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกความกว้าง"),
                          onSaved: (String? width ) {
                            myStudent.width = width!;
                          }, 
                          keyboardType: TextInputType.number,
                          
                        ), 
                         const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ความยาว",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "ความยาว"),
                          onSaved: (String? height) {
                            myStudent.height = height!;
                          }, 
                          keyboardType: TextInputType.number,
                          
                        ), 
                        const SizedBox(
                          height: 15,
                        ),
                        IconButton(
                  onPressed: () async {
                

                    ImagePicker imagePicker = ImagePicker();
                    XFile? file =
                        await imagePicker.pickImage(source: ImageSource.gallery);
                    

                    if (file == null) return;
                    //Import dart:core
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');
                    Reference referenceImageToUpload = referenceDirImages.child('name2${DateTime.now()}');
                    try {
                      await referenceImageToUpload.putFile(File(file.path));
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {}
                  },
                  icon: Icon(Icons.camera_alt)),  
                   
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "หมายเหตุ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกหมายเหตุ"),
                          onSaved: (String? note ) {
                            myStudent.note = note!;
                          },
                          
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              child: const Text(
                                "บันทึกข้อมูล",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async{ 
                                if (imageUrl.isEmpty) {
                          ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Please upload an image')));

                       return;
                    }
                                if (formKey.currentState!.validate()) {
                                   formKey.currentState!.save();
                                   await _studentCollection.add({
                                      "ชื่อ":myStudent.name,
                                      "code":myStudent.code,
                                      "ขวดที่":myStudent.number,
                                      "วันที่ปลูก":myStudent.datecome,  
                                      "วันที่ย้าย":myStudent.dateout,
                                      "resoure":myStudent.resource,
                                      "อาหาร":myStudent.food,
                                      "ลักษณะ":myStudent.des,  
                                       "ความกว้าง":myStudent.width,
                                      "ความยาว":myStudent.height,
                                      "image": imageUrl,
                                      "หมายเหตุ":myStudent.note, 
                                   });
                                   formKey.currentState!.reset(); 
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Welcome()));
                                }
                              }),
                        ) , 
                         
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}