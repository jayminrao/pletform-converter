
import 'dart:io';

import 'package:contacts_app/modelclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class platformProvider with ChangeNotifier {

  bool isPlatform = false;
  bool isTheme = false;
  bool proData = false;

  File? addImage;
  File? proImage;

  TextEditingController proNameController = TextEditingController();
  TextEditingController proBioController = TextEditingController();

  platformProvider(){
    proNameGetSharePrefrence();
    getProBioSharePrefrence();
    getImageSharePref();
  }




  getImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {

      addImage = File(pickedFile.path);
    }
    notifyListeners();
  }


  profileImage() async {
    var proFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (proFile != null) {

      proImage = File(proFile.path);
    }
    notifyListeners();
  }


  List<ModelClass> contactData=[];

  set setPlatform(value){
    isPlatform = value;
    notifyListeners();
  }

  get getPlatform{
    return isPlatform;
  }

  set setTheme(value){
    isTheme = value;
    notifyListeners();
  }

  get getTheme{
    return isTheme;
  }

  set setProfile(value){
    proData = value;
    notifyListeners();
  }

  get getProfile{
    return proData;
  }


  addContactData(ModelClass Data){
    contactData.add(Data);
    notifyListeners();
  }

  editContactData(ModelClass Data, index){
    contactData[index]=(Data);
    notifyListeners();
  }

  deleteContactData(index){
    contactData.removeAt(index);
    notifyListeners();
  }



  proNameSetSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('proName', value);
  }

  proNameGetSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    proNameController.text = pref.getString('proName') ?? "Enter your profile data";
  }

  setProBioSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('proBio', value);
  }

  getProBioSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    proBioController.text = pref.getString('proBio') ?? "Enter your Bio...";
  }


  setImageSharePref(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('proImage', value);
  }

  getImageSharePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    proImage = File((pref.getString('proImage') ?? "Enter your Bio..."));
  }


}
