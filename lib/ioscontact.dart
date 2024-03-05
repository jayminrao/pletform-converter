import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'modelclass.dart';

class iosContact extends StatefulWidget {
  const iosContact({super.key});

  @override
  State<iosContact> createState() => _iosContactAddState();
}

class _iosContactAddState extends State<iosContact> {
  TextEditingController nameIosController = TextEditingController();
  TextEditingController numberIosCotroller = TextEditingController();
  TextEditingController chatIosController = TextEditingController();

  var iosDate;
  var iosTime;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);

    return Form(
      key: formkey,

      child: Column(
        children: [
          SizedBox(height: 15,),
          (providerVar.addImage != null)
              ? CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(providerVar.addImage!),
                )
              : Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black12),
                  child: CupertinoButton(
                      child: Icon(CupertinoIcons.camera),
                      onPressed: () {
                        providerVar.getImage();
                      })),
          SizedBox(height: 10,),
          CupertinoTextFormFieldRow(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Name';
              }
            },
            controller: nameIosController,
            prefix: Icon(
              Icons.person_outline_outlined,
              size: 30,
            ),
            placeholder: 'Name',
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadiusDirectional.circular(6)),
          ),
          SizedBox(height: 10,),
          CupertinoTextFormFieldRow(

            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Number';
              }
            },
            controller: numberIosCotroller,
            prefix: Icon(
              CupertinoIcons.phone,
              size: 30,
            ),
            placeholder: 'Number',
            keyboardType: TextInputType.number,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadiusDirectional.circular(6)),
          ),
          SizedBox(height: 10,),
          CupertinoTextFormFieldRow(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Chat';
              }
            },
            controller: chatIosController,
            prefix: Icon(
              CupertinoIcons.chat_bubble_text,
              size: 30,
            ),
            placeholder: 'Chats',
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadiusDirectional.circular(6)),
          ),
          GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                      height: 300,
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (DateTime value) {
                          setState(() {
                            iosDate = DateFormat('dd/MM/yyyy').format(value);
                          });
                        },
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: false,
                        initialDateTime: DateTime.now(),
                      ));
                },
              );
              print(iosDate);
            },
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 22,height: 50,),
                  Icon(CupertinoIcons.calendar,size: 30),
                  SizedBox(width: 8,),
                  (iosDate != null)
                      ? Text(iosDate.toString())
                      : Text('PickDate')
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                      height: 300,
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (DateTime value) {
                          setState(() {
                            iosTime = DateFormat('HH:mm').format(value);
                          });
                        },
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: false,
                        initialDateTime: DateTime.now(),
                      ));
                },
              );
              print(iosTime);
            },
            child: Row(
              children: [
                SizedBox(width: 22,),
                Icon(CupertinoIcons.time,size: 30,),
                SizedBox(width: 10,),
                (iosTime != null) ? Text(iosTime.toString()) : Text('PickTime')
              ],
            ),
          ),
          SizedBox(height: 10,),
          CupertinoButton(
              onPressed: ()
              {
                if (providerVar.addImage != null) {
                  if (formkey.currentState!.validate()) {
                    ModelClass Data = ModelClass(
                        name: nameIosController.text,
                        number: numberIosCotroller.text,
                        chat: chatIosController.text,
                        Image: providerVar.addImage,
                        Date: iosDate,
                        Time: iosTime);

                  }
                } else {
                  Fluttertoast.showToast(msg: 'PickUp Image');
                }
              },
            color: Colors.blue,
            child: Text('SAVE',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),)
        ],
      ),
    );
  }
}
