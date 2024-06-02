import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({required this.title, this.image}) : id = uuid.v4();

  final String id;
  final String title;
  XFile? image;
}
