import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCampaignPage extends StatefulWidget {
  const AddCampaignPage({super.key});

  @override
  _AddCampaignPageState createState() => _AddCampaignPageState();
}

class _AddCampaignPageState extends State<AddCampaignPage> {
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _displaySelectedImage() {
    if (_imageFile == null) {
      return const Text('Nenhuma imagem selecionada.');
    } else {
      if (kIsWeb) {
        return Image.network(_imageFile!.path);
      } else {
        return Image.file(File(_imageFile!.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF3737),
        title: const Text('Adicionar Campanha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Descrição da campanha',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Insira a descrição da campanha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Anexar Mídia'),
            ),
            const SizedBox(height: 16.0),
            _displaySelectedImage(),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFF3737),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: const Size.fromHeight(61),
              ),
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
