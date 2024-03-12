import 'dart:io';
import 'dart:typed_data';
import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/home_screen.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ai/Widget/bottom_motion_tabbar.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Uint8List? _image;
  File? selectedIMage;

  @override
  Widget build(BuildContext context) {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    return Scaffold(
       appBar: AppBarWidget(
        showBackButton: false,
        title: 'Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "PERSONAL DETAILS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image != null
                                ? MemoryImage(_image!)
                                : AssetImage('assets/icons/user.png')
                                    as ImageProvider<Object>,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 2,
                          right: 0,
                          child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.blue,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    showImagePickerOption(context);
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white, size: 15)))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                buildTextField(
                  "Name",
                  "${_providerState.getFirstName.toString()} ${_providerState.getLastName.toString()}",
                ),
                SizedBox(
                  height: 25,
                ),
                buildTextField(
                  "E-mail",
                  "${_providerState.getEmail.toString()}",
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MotionTabBarWidget(),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromCamera();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}
