import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InquiryForm extends StatefulWidget {
  const InquiryForm({super.key});

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  Future <void> _submitForm() async{
     if(_formKey.currentState!.validate()){
                    await FirebaseFirestore.instance.collection('users').add({
                          'name':_nameController.text,
                          'phone no.':_mobileController.text,
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Form Submitted Successfully"),),);
                    _nameController.clear();
                    _mobileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
               // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                      Expanded(
                  flex:5,
                  child: Text(""),),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Expanded(
                    flex:1,
                    child: TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(labelText: "Mobile No."),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your Mobile Number";
                        }
                        return null;
                      },
                    ),
          
                  ),
                 
                 ElevatedButton(
                
                  onPressed: _submitForm,
                   
                  
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [    
                    Text("Enquire Now"),
                    SizedBox(width: 10.0,),
                    Icon(Icons.send),
                  ],)
                 ),
                 Expanded(
                  flex:5,
                  child: Text(""),)
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
