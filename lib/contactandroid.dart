import 'dart:io';
import 'package:contacts_app/modelclass.dart';
import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

var formatedDate;
var datepicker;
var formateTime;
var date;
var time;

class contactAndroid extends StatefulWidget {
  final String? name;
  final String? number;
  final String? chat;
  final File? Image;
  final int? index;
  var Date;
  var Time;

  contactAndroid(
      {super.key,
      this.name,
      this.number,
      this.chat,
      this.Image,
      this.Time,
      this.Date,
      this.index});

  @override
  State<contactAndroid> createState() => _contactAndroidState();
}

class _contactAndroidState extends State<contactAndroid> {



  TextEditingController nameController = TextEditingController();
  TextEditingController numberCotroller = TextEditingController();
  TextEditingController chatController = TextEditingController();


  final formkey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(children: [
            SizedBox(height: 15,),
            (providerVar.addImage != null)
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(providerVar.addImage!),
                  )
                : Container(
                    height: 115,
                    width: 115,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black12),
                    child: IconButton(
                      onPressed: () {
                        providerVar.getImage();
                      },
                      icon: Icon(
                        CupertinoIcons.photo_camera,
                        size: 60,
                        color: Colors.blue,
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Name';
                }
              },
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded,color: Colors.blue,),
                labelText: 'Name',
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 4)),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Number';
                }
              },
              controller: numberCotroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.call,color: Colors.blue,),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                          width: 4))),
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Chat';
                }
              },
              controller: chatController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.chat_outlined,color: Colors.blue,),
                  labelText: 'Chat Conversation',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                          width: 4))),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(3000),
                        initialDate: DateTime.now());
                    print(date);
                    if (date != null) {
                      setState(() {
                        formatedDate = DateFormat('dd/MM/yyyy').format(date);
                      });

                    }
                  },
                  icon: Icon(Icons.date_range_outlined),
                ),
                (formatedDate == null) ? Text('Pick Date') : Text(formatedDate),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    print(time.format(context));
                    if (time != null) {
                      datepicker = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          time.hour,
                          time.minute);
                      setState(() {
                        formateTime = DateFormat('HH:mm').format(datepicker);
                      });


                      print(formateTime);
                    }
                  },
                  icon: Icon(Icons.access_time),
                ),
                (formateTime == null) ? Text('Pick Time') : Text(formateTime),
              ],
            ),

            ElevatedButton(  style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Background color
              onPrimary: Colors.black, // Text Color (Foreground color)
            ),
                onPressed: () {
                  if (providerVar.addImage != null) {
                    if (formkey.currentState!.validate()) {
                      ModelClass Data = ModelClass(
                          name: nameController.text,
                          number: numberCotroller.text,
                          chat: chatController.text,
                          Image: providerVar.addImage,
                          Date: formatedDate,
                          Time: formateTime);
                      providerVar.addContactData(Data);
                      nameController.clear();
                      numberCotroller.clear();
                      chatController.clear();
                      providerVar.addImage = null;
                      formatedDate = null;
                      formateTime = null;
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'PickUp Image');
                  }
                },
                child: Text('Save',style: TextStyle(fontSize: 20),)),
          ]),
        ),
      ),
    );
  }
}
