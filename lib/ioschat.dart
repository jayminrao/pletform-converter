import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class iosChat extends StatefulWidget {
  const iosChat({super.key});

  @override
  State<iosChat> createState() => _iosChatState();
}

class _iosChatState extends State<iosChat> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);
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
                return CupertinoListTile.notched(

                  onTap: (){
                    showCupertinoModalPopup(context: context, builder: (context) {
                      return Container(
                        height: 340,
                        width: width,
                        color: Colors.white,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(
                                  providerVar.contactData[index].Image!),
                            ),
                            Text(providerVar.contactData[index].name!),
                            Text(providerVar.contactData[index].chat!),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(child: Icon(Icons.edit,size: 27,), onPressed: (){
                                  showCupertinoDialog(context: context, builder: (context) {
                                    return Container(
                                      height: 400,
                                      width: width,
                                    color: Colors.red,
                                    child: Column(children: [],),
                                    );
                                  },);

                                }),
                                CupertinoButton(child: Icon(Icons.delete,size: 27,), onPressed: (){
                                  providerVar.deleteContactData(index);
                                  Navigator.of(context).pop();
                                }),

                              ],
                            ),
                            CupertinoButton(color:Colors.black38,child: Text('Cancel'), onPressed: (){Navigator.of(context).pop();})
                          ],
                        ),
                      );
                    },);
                  },
                  leadingSize: 60,
                  leadingToTitle: 20,
                  padding: EdgeInsets.all(5),
                  title: Text(providerVar.contactData[index].name!),
                  subtitle: Text(providerVar.contactData[index].chat!),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        FileImage(providerVar.contactData[index].Image!),
                  ),
                  trailing: Container(
                    width: 140,
                    child: Row(
                      children: [
                        Text(providerVar.contactData[index].Date.toString()),
                        Text(', '),
                        Text(providerVar.contactData[index].Time.toString()),
                      ],
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
