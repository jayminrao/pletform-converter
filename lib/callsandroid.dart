import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class callsAndroid extends StatefulWidget {
  const callsAndroid({super.key});

  @override
  State<callsAndroid> createState() => _callsAndroidState();
}

class _callsAndroidState extends State<callsAndroid> {
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
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        FileImage(providerVar.contactData[index].Image!),
                  ),
                  title: Text(providerVar.contactData[index].name!),
                  subtitle: Text(providerVar.contactData[index].chat!),
                  trailing: IconButton(
                      onPressed: () async {
                        final Uri url = Uri(
                            path: providerVar.contactData[index].number,
                            scheme: 'tel');
                        await launchUrl(url);
                      },
                      icon: Icon(
                        Icons.call,
                        color: Colors.green,
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
