import 'dart:io';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
}
