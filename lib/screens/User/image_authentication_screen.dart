import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageAuthenticationScreen extends StatefulWidget {
  const ImageAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<ImageAuthenticationScreen> createState() => _ImageAuthenticationScreenState();
}

class _ImageAuthenticationScreenState extends State<ImageAuthenticationScreen> {
  XFile? nationalIdImage;
  XFile? selfieImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, bool isNationalId) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      if (isNationalId) {
        nationalIdImage = image;
      } else {
        selfieImage = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Authentication"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload National ID",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery, true),
              child: const Text("Select National ID Image"),
            ),
            if (nationalIdImage != null) Image.file(File(nationalIdImage!.path)),
            const SizedBox(height: 20),
            const Text(
              "Take a Selfie",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera, false),
              child: const Text("Take Selfie"),
            ),
            if (selfieImage != null) Image.file(File(selfieImage!.path)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle authentication logic here
                if (nationalIdImage != null && selfieImage != null) {
                  // Proceed with authentication
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please upload both images."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Authenticate"),
            ),
          ],
        ),
      ),
    );
  }
} 