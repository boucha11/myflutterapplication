import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  static final ImagePicker _picker = ImagePicker();

  static final CloudinaryPublic cloudinary =
      CloudinaryPublic('IIT_sfax', 'LSI', cache: false);

  // ================= CAMERA =================
  static Future<String?> uploadFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image == null) return null;

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );

      return response.secureUrl;
    } catch (e) {
      debugPrint('Camera upload error: $e');
      return null;
    }
  }

  // ================= GALLERY =================
  static Future<String?> uploadFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );

      return response.secureUrl;
    } catch (e) {
      debugPrint('Gallery upload error: $e');
      return null;
    }
  }
}
