import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class iosCall extends StatefulWidget {
  const iosCall({super.key});

  @override
  State<iosCall> createState() => _iosCallScreenState();
}

class _iosCallScreenState extends State<iosCall> {
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
                  leadingSize: 60,
                  leadingToTitle: 20,
                  padding: EdgeInsets.all(5),
                  title: Text(providerVar.contactData[index].name!),
                  subtitle: Text(providerVar.contactData[index].chat!),
                  leading: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                    FileImage(providerVar.contactData[index].Image!),
                  ),
                  trailing: CupertinoButton(onPressed: ()async {
                    final Uri url = Uri(
                        path: providerVar.contactData[index].number,
                        scheme: 'tel');
                    await launchUrl(url);},child: Icon(CupertinoIcons.phone,size: 28,)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
