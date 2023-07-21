import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPetPage extends StatefulWidget {
  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  File? _imageFile; // "?" ile null olabilen bir değişken olarak işaretleyin
  TextEditingController _titleController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  String? _selectedBreed;
  String? _genderController;
  String? _adoptionController;
  String? _vaccineController;
  String? _chipController;

  bool _isUploading = false; // Yükleme durumunu tutacak bool değişken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hayvan Ekle'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black),
                  ),
                  child: _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : Icon(Icons.add_a_photo, size: 50),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedBreed,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBreed = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Kedi',
                    child: Text('Kedi'),
                  ),
                  DropdownMenuItem(
                    value: 'Köpek',
                    child: Text('Köpek'),
                  ),
                  DropdownMenuItem(
                    value: 'Diğer',
                    child: Text('Diğer'),
                  ),
                  // Diğer cinsleri buraya ekleyin...
                ],
                decoration: InputDecoration(
                  labelText: 'Cins Seç',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              _buildTitleField('Hayvan İsmi', _titleController),
              SizedBox(height: 16),
              _buildTitleField('Yaş', _ageController),

              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _genderController,
                onChanged: (newValue) {
                  setState(() {
                    _genderController = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Erkek',
                    child: Text('Erkek'),
                  ),
                  DropdownMenuItem(
                    value: 'Dişi',
                    child: Text('Dişi'),
                  ),
                  // Diğer cinsleri buraya ekleyin...
                ],
                decoration: InputDecoration(
                  labelText: 'Cinsiyet Seç',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _adoptionController,
                onChanged: (newValue) {
                  setState(() {
                    _adoptionController = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Daha önce sahiplendirilmedi',
                    child: Text('Daha önce sahiplendirilmedi'),
                  ),
                  DropdownMenuItem(
                    value: 'Daha önce sahiplendirildi',
                    child: Text('Daha önce sahiplendirildi'),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Sahiplenme durumunu seç',
                  border: OutlineInputBorder(),
                ),
              ),SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _chipController,
                onChanged: (newValue) {
                  setState(() {
                    _chipController = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Çipli',
                    child: Text('Çipli'),
                  ),
                  DropdownMenuItem(
                    value: 'Çipsiz',
                    child: Text('Çipsiz'),
                  ),
                  // Diğer cinsleri buraya ekleyin...
                ],
                decoration: InputDecoration(
                  labelText: 'Hayvanın Çip Durumunu Seç',
                  border: OutlineInputBorder(),
                ),
              ),SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _vaccineController,
                onChanged: (newValue) {
                  setState(() {
                    _vaccineController = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Aşıları Tam',
                    child: Text('Aşıları Tam'),
                  ),
                  DropdownMenuItem(
                    value: 'Aşıları Eksik',
                    child: Text('Aşıları Eksik'),
                  ),
                  // Diğer cinsleri buraya ekleyin...
                ],
                decoration: InputDecoration(
                  labelText: 'Aşı Durumunu Seç',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              _buildTitleField('Hayvanın Türü', _type),
              SizedBox(height: 16),
              _buildTitleField('Telefon Numarası (11 Rakam)', _phoneNumberController), // Add phone number field
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadPetData,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadPetData() async {
    // _isUploading'i true yaparak butona tekrar basılmamasını sağla
    setState(() {
      _isUploading = true;
    });

    if (_imageFile == null ||
        _titleController.text.isEmpty ||
        _selectedBreed == null ||
        _ageController.text.isEmpty ||
        _genderController == null ||
        _type.text.isEmpty ||
        _vaccineController == null ||
        _adoptionController == null ||
        _chipController == null ||
        _phoneNumberController.text.isEmpty) {
      print('Tüm alanlar doldurulmalıdır.');
      // Hata durumunda _isUploading'i false yaparak butona tekrar basılmasını etkinleştir
      setState(() {
        _isUploading = false;
      });
      return;
    }

    // Validate the phone number
    final phoneNumber = _phoneNumberController.text;
    if (phoneNumber.length != 11 || !phoneNumber.contains(RegExp(r'^\d{11}$'))) {
      print('Geçerli bir 11 haneli telefon numarası girmelisiniz.');
      // Hata durumunda _isUploading'i false yaparak butona tekrar basılmasını etkinleştir
      setState(() {
        _isUploading = false;
      });
      return;
    }

    try {
      // Firebase Storage'a resim yükleme
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('pets_images')
          .child(_titleController.text + '.jpg');
      await storageRef.putFile(_imageFile!);

      // Firestore'a hayvan bilgilerini kaydetme
      final imageUrl = await storageRef.getDownloadURL();
      final user = FirebaseAuth.instance.currentUser;
      final petData = {
        'imagePath': imageUrl,
        'title': _titleController.text,
        'breed': _selectedBreed,
        'age': _ageController.text,
        'gender': _genderController,
        'vaccine': _vaccineController,
        'adoption': _adoptionController,
        'chip': _chipController,
        'type': _type.text,
        'email': user?.email ?? '', // Eğer kullanıcı giriş yapmamışsa email'i boş bırakırız
        'phone': phoneNumber, // Store the validated phone number
      };
      await FirebaseFirestore.instance
          .collection('pets')
          .doc(_titleController.text) // Set the document ID
          .set(petData); // Use set() method to add data with a specific ID

      Navigator.pop(context); // Sayfadan çık
    } catch (e) {
      print('Hayvan bilgileri kaydedilirken hata oluştu: $e');
    } finally {
      // Yükleme tamamlandığında _isUploading'i false yaparak butona tekrar basılmasını etkinleştir
      setState(() {
        _isUploading = false;
      });
    }
  }
}
