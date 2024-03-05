import 'dart:io';
import 'package:contacts_app/modelclass.dart';
import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'contactandroid.dart';

class chatAndroid extends StatefulWidget {
  const chatAndroid({super.key});

  @override
  State<chatAndroid> createState() => _chatScreenAndroidState();
}

class _chatScreenAndroidState extends State<chatAndroid> {
  TextEditingController editName = TextEditingController();
  TextEditingController editNumber = TextEditingController();
  TextEditingController editChat = TextEditingController();
  File? editImage;
  var editDate;
  var editTime;
  int? editIndex;

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            child: ListView.builder(
              itemCount: providerVar.contactData.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  height: 80,
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        shape: OutlineInputBorder(),
                        context: context,
                        builder: (context) {
                          return Container(
                            width: width,
                            height: 320,
                            child: Column(
                              children: [
                                SizedBox(height:5 ,),
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: FileImage(
                                      providerVar.contactData[index].Image!),
                                ),
                                Text(providerVar.contactData[index].name!),
                                Text(providerVar.contactData[index].chat!),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            editName.text = providerVar
                                                .contactData[index].name!;
                                            editNumber.text = providerVar
                                                .contactData[index].number!;
                                            editChat.text = providerVar
                                                .contactData[index].chat!;
                                            editImage = providerVar
                                                .contactData[index].Image!;
                                            editDate = providerVar
                                                .contactData[index].Date!;
                                            editTime = providerVar
                                                .contactData[index].Time!;
                                            editIndex = index;

                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    height: 550,
                                                    width: width,
                                                    child: Column(children: [
                                                      (editImage != null)
                                                          ? CircleAvatar(
                                                              radius: 60,
                                                              backgroundImage:
                                                                  FileImage(
                                                                      editImage!),
                                                            )
                                                          : Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .black12),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  providerVar
                                                                      .getImage();
                                                                },
                                                                icon: Icon(
                                                                  CupertinoIcons
                                                                      .add,
                                                                  size: 60,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                      SizedBox(height: 10,),
                                                      TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Name';
                                                          }
                                                        },
                                                        controller: editName,
                                                        decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons
                                                              .person_outline_rounded),
                                                          labelText:
                                                              'Full Name',
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  color: Colors
                                                                      .black,
                                                                  width: 4)),
                                                        ),
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Number';
                                                          }
                                                        },
                                                        controller: editNumber,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                                Icons.call),
                                                            labelText:
                                                                'Phone Number',
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    color: Colors
                                                                        .black,
                                                                    width: 4))),
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Chat';
                                                          }
                                                        },
                                                        controller: editChat,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(Icons
                                                                .chat_outlined),
                                                            labelText:
                                                                'Chat Conversation',
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    color: Colors
                                                                        .black,
                                                                    width: 4))),
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              date = await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  firstDate:
                                                                      DateTime(
                                                                          1990),
                                                                  lastDate:
                                                                      DateTime(
                                                                          3000),
                                                                  initialDate:
                                                                      DateTime
                                                                          .now());
                                                              print(date);
                                                              if (date !=
                                                                  null) {
                                                                setState(() {
                                                                  formatedDate = (date != null)?
                                                                      DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(
                                                                              date):editDate;
                                                                });
                                                              }
                                                            },
                                                            icon: Icon(Icons
                                                                .date_range_outlined),
                                                          ),
                                                          (formatedDate == null)
                                                              ? Text(editDate)
                                                              : Text(formatedDate),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              time = await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now());
                                                              print(time.format(
                                                                  context));
                                                              if (time !=
                                                                  null) {
                                                                datepicker = DateTime(
                                                                    DateTime.now()
                                                                        .year,
                                                                    DateTime.now()
                                                                        .month,
                                                                    DateTime.now()
                                                                        .day,
                                                                    time.hour,
                                                                    time.minute);
                                                                setState(() {
                                                                  formateTime = (datepicker != null)?DateFormat(
                                                                          'HH:mm')
                                                                      .format(
                                                                          datepicker):editTime;
                                                                });
                                                                print(
                                                                    formateTime);
                                                              }
                                                            },
                                                            icon: Icon(Icons
                                                                .access_time),
                                                          ),
                                                          (formateTime == null)
                                                              ? Text(editTime)
                                                              : Text(formateTime),
                                                        ],
                                                      ),
                                                      OutlinedButton(
                                                          style: OutlinedButton.styleFrom(
                                                            backgroundColor: Colors.blue,
                                                          ),
                                                          onPressed: () {
                                                            ModelClass edit =
                                                                ModelClass(
                                                              name: editName.text,
                                                              number: editNumber.text,
                                                              chat: editChat.text,
                                                              Image: editImage,
                                                              Date: (formatedDate == null)?editDate:formatedDate,
                                                              Time: (formateTime == null)?editTime:formateTime,
                                                            );
                                                            providerVar.editContactData(edit, index);
                                                            setState(() {
                                                              Navigator.of(context).pop();
                                                            });
                                                          },
                                                          child:
                                                              Text('Save',style: TextStyle(color: Colors.black))),
                                                    ]),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 30,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            providerVar
                                                .deleteContactData(index);
                                            //setState(() {
                                            Navigator.of(context).pop();
                                            //});
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 30,
                                          )),
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel',style: TextStyle(color: Colors.black),))
                              ],
                            ),
                          );
                        },
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          FileImage(providerVar.contactData[index].Image!),
                    ),
                    title: Text(providerVar.contactData[index].name!),
                    subtitle: Text(providerVar.contactData[index].chat!),
                    trailing: Container(
                      width: 101,
                      child: Row(
                        children: [
                          Text(providerVar.contactData[index].Date.toString()),
                          Text(', '),
                          Text(providerVar.contactData[index].Time.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
