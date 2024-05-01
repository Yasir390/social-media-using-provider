import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_media/res/component/reusable_text_form_field.dart';
import 'package:social_media/utils/toast_msg.dart';
import 'package:social_media/view_model/services/session_manager.dart';

class ProfileModel with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool loadingValue) {
    _loading = loadingValue;
    notifyListeners();
  }

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;

  Future pickFromGallery(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImages(context);
    }

    notifyListeners();
  }

  Future pickFromCamera(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImages(context);
    }
    notifyListeners();
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickFromCamera(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickFromGallery(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.folder),
                  title: const Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> uploadImages(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageReference.getDownloadURL();

    databaseReference
        .child(SessionController().userId.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      setLoading(false);
      Utils().toastMessage('Profile Updated');
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils().toastMessage(error.toString());
    });
  }

  final nameController = TextEditingController();

  Future<void> showUserNameDialogAlert(context, name) {
    nameController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: KReUsableTextFormField(
            myController: nameController,
            onFieldSubmitted: (newValue) {},
            onValidator: (value) {
              return value ? 'Enter name': null;
            },
            keyboardType: TextInputType.text,
            hintText: 'Edit Name',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                databaseReference.child(SessionController().userId.toString()).update({
                  'userName': nameController.text
                }).then((value) {
                  Utils().toastMessage('Updated Successfully');
                  nameController.clear();
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  final phoneController = TextEditingController();
  Future<void> showPhoneNumDialogAlert(context, phone) {
    phoneController.text = phone;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: KReUsableTextFormField(
            myController: phoneController,
            onFieldSubmitted: (newValue) {},
            onValidator: (value) {
              return value == null ? 'Enter name': null;
            },
            keyboardType: TextInputType.text,
            hintText: 'Edit Phone',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                databaseReference.child(SessionController().userId.toString()).update({
                  'phone': phoneController.text
                }).then((value) {
                  Utils().toastMessage('Updated Successfully');
                  phoneController.clear();
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
