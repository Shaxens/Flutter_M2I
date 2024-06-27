import 'package:flutter/material.dart';

class Album {
  const Album({
    required this.title,
    required this.numero,
    required this.year,
    this.yearInColor,
    required this.image,
    required this.resume,
  });

  final String title;
  final int numero;
  final int year;
  final int? yearInColor;
  final String image;
  final String resume;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Album(title: $title, numero: $numero, year: $year, yearInColor: $yearInColor, image: $image, resume: $resume)';
  }

  Map<String, dynamic> _toJson() {
    return {
      'title': title,
      'numero': numero,
      'year': year,
      'yearInColor': yearInColor,
      'image': image,
      'resume': resume,
    };
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json['titre'],
      numero: json['numero'],
      year: json['parution'],
      yearInColor: json['parutionEnCouleur'],
      image: 'assets/images/tintin/${json['image']}',
      resume: json['resume'],
    );
  }
}
