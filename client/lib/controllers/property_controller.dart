import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:new_journey_app/storage/local_storage.dart';

class PropertyController extends GetxController with LocalStorage {
  final overviewController = TextEditingController();
  final rentalPriceController = TextEditingController();
  final floorController = TextEditingController();
  final roomsController = TextEditingController();
  final maxCapacityController = TextEditingController();
  final contactController = TextEditingController();
  final cabinsController = TextEditingController();
  final propertyAddressController = TextEditingController();
  var liftAvailable = false;
  var wifiAvailable = false;
  var acAvailable = false;
  RxBool isImagePicked = false.obs;
  RxBool isLocationPicked = false.obs;

  RxList<double> location = <double>[].obs;

  void clearFields() {
    overviewController.clear();
    rentalPriceController.clear();
    floorController.clear();
    roomsController.clear();
    maxCapacityController.clear();
    contactController.clear();
    cabinsController.clear();
    multiImageController.clearImages();
    liftAvailable = false;
    wifiAvailable = false;
    acAvailable = false;
    isImagePicked.value = false;
    isLocationPicked.value = false;
  }

  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  // multipart images

  var multiImageController =
      MultiImagePickerController(picker: (bool allowMultiple) async {
    final pickedImages = await ImagePicker().pickMultiImage();
    return convertXFilesToImageFiles(pickedImages);
  });

  static List<ImageFile> convertXFilesToImageFiles(List<XFile> xFiles) {
    List<ImageFile> imageFiles = [];
    for (var xFile in xFiles) {
      String fileName = xFile.path.split('/').last;
      String fileExtension = fileName.split('.').last;

      imageFiles.add(ImageFile(
        UniqueKey().toString(),
        name: fileName,
        extension: fileExtension,
        path: xFile.path,
      ));
    }
    return imageFiles;
  }
}
