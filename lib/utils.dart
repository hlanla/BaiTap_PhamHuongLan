import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'constant/text_style.dart';

class Utils {
  Utils._();

  static Future<ImageSource?> showOptionPickImage(
    BuildContext context,
    Function(XFile) onPhotoFileChanged,
  ) async {
    Future<void> pickImage(ImageSource source) async {
      final tempPhotoFile = await Utils.pickImage(imageSource: source);
      if (tempPhotoFile != null) {
        onPhotoFileChanged.call(tempPhotoFile);
      }
    }

    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Text(
                "Add from Camera",
                style: AppStyles.button01(color: Colors.black),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Text(
                "Add from gallery",
                style: AppStyles.button01(color: Colors.black),
              ),
            )
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                "Add from camera",
                style: AppStyles.button01(color: Colors.black),
              ),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                "Add from gallery",
                style: AppStyles.button01(color: Colors.black),
              ),
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  static Future<XFile?> pickImage({
    required ImageSource imageSource,
    int? quality,
    int? imageWidthResize,
    int? imageHeightResize,
  }) async {
    final imagePicker = ImagePicker();
    final XFile? imageFile = await imagePicker.pickImage(
      source: imageSource,
      imageQuality: quality,
    );
    if (imageFile == null) {
      return null;
    }

    return imageFile;
  }

  static Future<String> saveLocalImage(XFile xfile) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final path = '$tempPath${DateTime.now().toString()}.png';
    xfile.saveTo(path);

    return path;
  }
}
