import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// Widget for capturing images using device camera
/// Shows camera button initially, then displays captured image
class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image)
  onPickImage; // Callback when image is captured

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  /// Opens camera and captures image with size optimization
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600, // Limit image width for storage efficiency
    );

    if (pickedImage == null) {
      return; // User cancelled camera
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    // Notify parent widget about selected image
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // Default content: camera button
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    // If image selected: show image with tap-to-retake functionality
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture, // Tap to take new picture
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: content,
    );
  }
}
