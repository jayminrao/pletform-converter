import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class iosSetting extends StatefulWidget {
  const iosSetting({super.key});

  @override
  State<iosSetting> createState() => _iosSettingState();
}

class _iosSettingState extends State<iosSetting> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);

    return Column(
      children: [
        CupertinoListTile.notched(
          leading: Icon(CupertinoIcons.person),
          leadingToTitle: 20,
          leadingSize: 40,
          title: Text('Profile'),
          subtitle: Text('Upadate Profile Data'),
          trailing: CupertinoSwitch(
              value: providerVar.getProfile,
              onChanged: (value) {
                providerVar.setProfile = value;
              }),
        ),
        Visibility(
            visible: providerVar.getProfile,
            child: Column(
              children: [
                (providerVar.proImage != null)
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(providerVar.proImage!),
                      )
                    : Container(
                        height: 145,
                        width: 145,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black12),
                        child: CupertinoButton(
                            onPressed: () {
                              providerVar.profileImage();
                            },
                            child: Icon(
                              CupertinoIcons.camera,
                              size: 45,
                            )),
                      ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Enter your name...',
                  textAlign: TextAlign.center,
                  controller: providerVar.proNameController,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Enter your Bio...',
                  textAlign: TextAlign.center,
                  controller: providerVar.proBioController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        child: Text('SAVE'),
                        onPressed: () {
                          providerVar.proNameSetSharePrefrence(
                              providerVar.proNameController.text);
                          providerVar.setProBioSharePrefrence(
                              providerVar.proBioController.text);
                          providerVar.setImageSharePref(providerVar.proImage);
                        }),
                    CupertinoButton(
                        child: Text('CLEAR'),
                        onPressed: () {
                          providerVar.proBioController.clear();
                          providerVar.proNameController.clear();
                          setState(() {
                            providerVar.proImage = null;
                          });
                        }),
                  ],
                ),
              ],
            )),
        Divider(height: 20, endIndent: 20, indent: 20),
        CupertinoListTile.notched(
          leading: Icon(CupertinoIcons.sun_max),
          leadingToTitle: 20,
          leadingSize: 40,
          title: Text('Theme'),
          subtitle: Text('Change Theme'),
          trailing: CupertinoSwitch(
              value: providerVar.getTheme,
              onChanged: (value) {
                providerVar.setTheme = value;
              }),
        ),
      ],
    );
  }
}
