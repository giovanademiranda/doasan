import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Campaign {
  final String id;
  final String descricao;
  final String img;
  final String usuarioNome;

  Campaign({
    required this.id,
    required this.descricao,
    required this.img,
    required this.usuarioNome,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['_id'],
      descricao: json['descricao'],
      img: json['img'],
      usuarioNome: json['usuario_id']['nome'],
    );
  }
}

class CampaignService {
  static const String baseUrl = 'http://localhost:3001/api';

  Future<Map<String, dynamic>> createCampaign(
      String userId,
      String description,
      XFile imageFile,
      ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/campanha/create/$userId'),
    );

    request.fields['descricao'] = description;

    if (kIsWeb) {
      var bytes = await imageFile.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: imageFile.name,
      );
      request.files.add(multipartFile);
    } else {
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      return {'success': true};
    } else {
      var responseData = await response.stream.bytesToString();
      return {
        'success': false,
        'message': jsonDecode(responseData)['message']
      };
    }
  }

  Future<List<Campaign>> fetchCampaigns() async {
    final response = await http.get(Uri.parse('$baseUrl/campanha/get'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Campaign> campaigns = body
          .map((dynamic item) => Campaign.fromJson(item))
          .toList();
      return campaigns;
    } else {
      throw Exception('Erro ao carregar campanhas');
    }
  }
}
