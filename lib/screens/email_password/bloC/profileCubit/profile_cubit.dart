import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  File? profile;
  ProfileCubit() : super(ProfileInitialState());

  Future<void> setSelectedImage() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File convertedFile = File(selectedImage.path);
      profile = convertedFile;
      emit(ProfileImageSetState());
    }
  }

  Future<void> submitProfileDetail(String _fullName, String _age) async {
    emit(ProfileLoadingState());
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('profileImage')
          .child(Uuid().v1())
          .putFile(profile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String _downloadUrl = await taskSnapshot.ref.getDownloadURL();
      await _storage.collection('firebaseUsers').add({
        'firebaseUserAge': _age,
        'firebaseUserImage': _downloadUrl,
        'firebaseUserName': _fullName,
      });
      emit(ProfileSavelState('Profile save successfully'));
    } on FirebaseException catch (e) {
      emit(ProfileSaveErrorState(e.message.toString()));
    }
  }
}
