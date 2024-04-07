import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:new_journey_app/storage/local_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/string_manager.dart';
import '../models/room_model.dart';

class PropertyController extends GetxController with LocalStorage {
  final formKey = GlobalKey<FormState>();

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
  final Rx<List<Room>> _myAddedRooms = Rx<List<Room>>([]);
  List<Room> get myAddedRooms => _myAddedRooms.value;

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
    isLoading.value = false;
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

  // add room

  Future<void> addRoom() async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        toggleLoading();
        final List<ImageFile> images = multiImageController.images.toList();

        final formData = {
          'room_number': propertyAddressController.text.trim(),
          'overview': overviewController.text.trim(),
          'rental_price': double.parse(rentalPriceController.text),
          'max_capacity': int.parse(maxCapacityController.text),
          'wifiAvailable': wifiAvailable,
          'contact_number': contactController.text.trim(),
          'owner': getUserId(),
          'location': jsonEncode({'coordinates': location.toList()}),
        };

        final url = Uri.parse("${AppStrings.BASE_URL}/room");
        var request = http.MultipartRequest('POST', url);
        Map<String, String> headers = {'Content-Type': 'multipart/form-data'};

        request.headers.addAll(headers);

        formData.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        // ignore: avoid_function_literals_in_foreach_calls
        images.forEach((image) async {
          request.files.add(await http.MultipartFile.fromPath(
            'files',
            image.path!,
            contentType: MediaType('image', image.extension),
          ));
        });

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        print(response.body);

        if (response.statusCode == 201) {
          clearFields();
          Get.snackbar(
            'Success',
            'Room created successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            jsonDecode(response.body)['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar(
        'Error',
        'Failed to create room',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      toggleLoading();
    }
  }
}
