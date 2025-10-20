import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPickerWidget  extends StatefulWidget {
  final Function(File) onImageSelected;
  final String? initialImageUrl;
  final String? initialImagePath;

  const AvatarPickerWidget({
    Key? key,
    required this.onImageSelected,
    this.initialImagePath,
    this.initialImageUrl,
  }) : super(key: key);

  @override
  State<AvatarPickerWidget> createState() => _AvatarPickerWidgetState();
}

class _AvatarPickerWidgetState extends State<AvatarPickerWidget> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.initialImagePath != null) {
      _imageFile = File(widget.initialImagePath!);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 400,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        widget.onImageSelected(_imageFile!);
      }
    } catch (e) {
      print('Ошибка выхода изображения $e');
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF212226),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library, color: Color(0xFFA1A1A1)),
                  title: Text(
                    'Галерея',
                    style: TextStyle(color: Color(0xFFA1A1A1)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Color(0xFFA1A1A1)),
                  title: Text(
                    'Камера',
                    style: TextStyle(color: Color(0xFFA1A1A1)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF2A2A2E),
        ),
        child: _imageFile != null
          ? ClipOval(
              child: Image.file(
                _imageFile!,
                fit: BoxFit.cover,
                width: 160,
                height: 160,
              ),
            )
          : (widget.initialImageUrl != null
              ? ClipOval(
                  child: Image.network(
                    widget.initialImageUrl!,
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultAvatar();
                    },
                  ),
                )
              : _buildDefaultAvatar()),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Icon(
      Icons.person,
      size: 80,
      color: Color(0xFFA1A1A1),
    );
  }
}