// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/logic/addUpdateDeleteProperty/bloc/add_update_delete_propery_bloc.dart';
import 'package:real_estaye_app/presentation/pages/map_page.dart';

class AddPropertyPage extends StatefulWidget {
  const AddPropertyPage({Key? key}) : super(key: key);

  @override
  State<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final collectionRef = FirebaseFirestore.instance.collection('Real_Estate');

  final String _propertyName = "";
  final String _location = "";
  final String _price = "";
  final String _size = "";
  final String _description = "";
  File? _image;
  String _imageUrl = "";
  bool _isUploading = false;
  bool _isImageSelected = false;

  String? _validatePropertyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Property Name is required';
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    return null;
  }

  String? _validateSize(String? value) {
    if (value == null || value.isEmpty) {
      return 'Size is required';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
        _isUploading = true;
        _isImageSelected = true;
      });
      await _uploadImage(imageFile);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final imageName = basename(imageFile.path);
      final storageImage = storage.ref().child('property_images/$imageName');

      final UploadTask uploadTask = storageImage.putFile(imageFile);
      await uploadTask;

      final imageUrl = await storageImage.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
        _isUploading = false;
      });
    } catch (e) {
      debugPrint('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
      ),
      body:
          BlocListener<AddUpdateDeleteProperyBloc, AddUpdateDeleteProperyState>(
        listener: (context, state) {
          if (state is PropertyErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Property added successfully!'),
              ),
            );
          } else if (state is PropertyErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add property: '),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.real_estate_agent,
                        color: AppTheme.primaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: AppTheme.primaryColor)),
                      border: OutlineInputBorder(),
                      labelText: "property Name",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      handleLocationPermission(context);
                    },
                    child: const Text("data"),
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(labelText: 'Location'),
                  //   onSaved: (value) {
                  //     _location = value!;
                  //   },
                  //   validator: _validateLocation,
                  // ),

                  ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: const Text('Select Image'),
                  ),
                  if (_isUploading) // Show a loading indicator
                    const CircularProgressIndicator()
                  else if (_image != null) // Show the selected image
                    Image.file(_image!),
                  ElevatedButton(
                    onPressed: () async {
                      if (_isImageSelected &&
                          _formKey.currentState!.validate()) {
                        await collectionRef
                            .orderBy('id', descending: true)
                            .limit(1)
                            .get()
                            .then((QuerySnapshot querySnapshot) async {
                          if (querySnapshot.docs.isNotEmpty) {
                            final QuerySnapshot snapshot = await collectionRef
                                .orderBy('id', descending: true)
                                .limit(1)
                                .get();

                            final int maxId = snapshot.docs.isNotEmpty
                                ? (snapshot.docs.first['id'] as int)
                                : 0;
                            final int newId = maxId + 1;

                            _formKey.currentState!.save();
                            final realEstateModel = RealEstateModel(
                              typeOfProperty: "",
                              type: _location,
                              id: newId,
                              properyName: _propertyName,
                              photo: _imageUrl,
                              location: const GeoPoint(20, 30),
                              price: _price,
                              size: _size,
                              description: _description,
                            );
                            BlocProvider.of<AddUpdateDeleteProperyBloc>(context)
                                .add(AddPropertyEvent(
                                    realEstateModel: realEstateModel));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an image.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLocationPermission(BuildContext context) async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MyMapPage()),
      );
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Permission")));
    } else {
      final result = await Permission.location.request();

      if (result.isGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyMapPage()),
        );
      } else if (result.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }
}
