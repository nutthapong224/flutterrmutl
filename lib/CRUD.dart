// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class CRUDEoperation extends StatefulWidget {
  const CRUDEoperation({super.key});

  @override
  State<CRUDEoperation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CRUDEoperation> {
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _datecomeController = TextEditingController();
  final TextEditingController _datetranController = TextEditingController();
  final TextEditingController _resoureController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();  
  
  late Map datas;
   String imageUrl = '';
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('students');

  String searchText = '';
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['ชื่อ'];
      _numberController.text = documentSnapshot['ขวดที่'];
      _datecomeController.text = documentSnapshot['วันที่ปลูก'];
      _codeController.text = documentSnapshot['code'];
      _datetranController.text = documentSnapshot['วันที่ย้าย'];
      _resoureController.text = documentSnapshot['resoure'];
      _foodController.text = documentSnapshot['อาหาร'];
      _detailController.text = documentSnapshot['ลักษณะ'];
      _widthController.text = documentSnapshot['ความกว้าง'];
      _longController.text = documentSnapshot['ความยาว'];
      _imageController.text = documentSnapshot['image'];
      _noteController.text = documentSnapshot['หมายเหตุ'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อ', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                      labelText: 'รหัส', hintText: 'eg.Elon'),
                ),

                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                      labelText: 'ขวดที่', hintText: 'eg.1'),
                ),
                TextField(
                  controller: _datecomeController,
                  decoration: const InputDecoration(
                      labelText: 'วันที่ปลูก', hintText: 'eg.10'),
                ),
              
                TextField(
                  controller: _resoureController,
                  decoration: const InputDecoration(
                      labelText: 'resoure', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _foodController,
                  decoration: const InputDecoration(
                      labelText: 'อาหาร', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _detailController,
                  decoration: const InputDecoration(
                      labelText: 'ลักษณะ', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _widthController,
                  decoration: const InputDecoration(
                      labelText: 'ความกว้าง', hintText: 'eg.Elon'),
                ),
                TextField(
                  controller: _longController,
                  decoration: const InputDecoration(
                      labelText: 'ความยาว', hintText: 'eg.Elon'),
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
                    
                    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(_imageController.text);
                    try {
                      await referenceImageToUpload.putFile(File(file.path));
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {}
                  },
                  icon: Icon(Icons.camera_alt)),  
                TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                      labelText: 'หมายเหตุ', hintText: 'eg.Elon'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String number = _numberController.text;
                      final String datecome = _datecomeController.text;
                      final String datetran = _datetranController.text;
                      final String code = _codeController.text;
                      final String resoure = _resoureController.text;
                      final String food = _foodController.text;
                      final String detail = _detailController.text;
                      final String width = _widthController.text;
                      final String long = _longController.text;
                      final String note = _noteController.text;
                      final String image = _imageController.text;
   
                      await _items.doc(documentSnapshot!.id).update({
                        "ชื่อ": name,
                        "ขวดที่": number,
                        "code": code,
                        "วันที่ปลูก": datecome,
                        "วันที่ย้าย": datetran,
                        "resoure": resoure,
                        "อาหาร": food,
                        "ลักษณะ": detail,
                        "ความกว้าง": width,
                        "ความยาว": long, 
                        "image":image,
                        "หมายเหตุ": note
                      });
                     

                      _nameController.text = '';
                      _datecomeController.text = '';
                      _numberController.text = '';
                      _codeController.text = '';
                      _datetranController.text = '';
                      _resoureController.text = '';
                      _foodController.text = '';
                      _detailController.text = '';
                      _widthController.text = '';
                      _longController.text = '';
                      _noteController.text = '';

                      Navigator.of(context).pop();
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  } 
 
  Future<void> _READ(String productID) async {
    await showModalBottomSheet(
      
      isScrollControlled: true,
      context: context, builder: (BuildContext ctx){ 
      
      return Scaffold(  
        
        // appBar: AppBar(title: Text("ข้อมูลต้นไม้"),),
        body: Padding( 
          
          padding: const EdgeInsets.only(top:35,left: 20,right: 20,bottom: 35),
          child: 
          FutureBuilder<DocumentSnapshot>(
          future:  _items.doc(productID).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //Get the data
              DocumentSnapshot documentSnapshot = snapshot.data;
              datas = documentSnapshot.data() as Map;
              //display the data
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70, top: 10),
                        child: Text('กล้วยไม้',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),  
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('รหัส:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['code']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ),  
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('ชื่อ:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['ชื่อ']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ),
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('วันที่ปลูก:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['วันที่ปลูก']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ), 
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('วันที่ย้าย:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['วันที่ย้าย']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ),
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('แหล่งที่มา:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['resoure']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ), 
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('อาหาร:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['อาหาร']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ), 
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('ลักษณะ:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['ลักษณะ']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ), 
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                    child: Text('ความกว้าง:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text('${documentSnapshot['ความกว้าง']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ),  
                   Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20,top: 10),
                    child: Text('ความยาว:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10 ,bottom: 20,top: 10),
                    child: Text('${documentSnapshot['ความยาว']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ),  
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                    child: Text('รูปภาพ:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Container(
                        height: 200,
                        width: 200,
                        child: Image.network(documentSnapshot['image']),
                      )
                  
                    ],

                  ),  
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                    child: Text('หมายเหตุ:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20),
                    child: Text('${documentSnapshot['หมายเหตุ']}',style: TextStyle(fontSize: 20)),
                  ), 
                  
                    ],

                  ),  
                
                ],
              );
            }
        
            return Center(child: CircularProgressIndicator());
          },
              ),
        ),
      ); 
      
    }); 
    
  }
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully deleted a itmes")));
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isSearchClicked
            ? Container( 
              
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField( 
                  
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration( 
                  
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('หน้ารายงานผล'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                .where((doc) => doc['ชื่อ'].toLowerCase().contains(
                      searchText.toLowerCase(),
                    ))
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];
                  return Card(
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(top:10,right: 3,left: 3,bottom: 10),
                    child: ListTile(
                      leading: Container(
                        height: 80,
                        width: 80,
                        child: Image.network(documentSnapshot['image']),
                      ),
                      title: Text(
                        documentSnapshot['ชื่อ'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Row(children: [ Text("${documentSnapshot['วันที่ปลูก']}"), Text("ขวดที่:${documentSnapshot['ขวดที่']}")],),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [ 
                               
                            IconButton(
                                color: Colors.blue,
                                onPressed: () => _update(documentSnapshot),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                color: Colors.blue,
                                onPressed: () => _delete(documentSnapshot.id),
                                icon: const Icon(Icons.delete)), 
                              
                          ],
                        ),
                      ), 
                      onTap:()=>_READ(documentSnapshot.id),
                    
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
     
    );
  }
}
