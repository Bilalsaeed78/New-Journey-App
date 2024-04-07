import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:new_journey_app/models/property_model.dart';
import 'package:new_journey_app/storage/local_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/string_manager.dart';
import '../models/room_model.dart';

class PropertyController extends GetxController with LocalStorage {
  final formKey = GlobalKey<FormState>();

  final roomNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  final officeNumberController = TextEditingController();
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

  final Rx<List<Property>> _myProperties = Rx<List<Property>>([]);
  List<Property> get myProperties => _myProperties.value;

  void clearFields() {
    propertyAddressController.clear();
    overviewController.clear();
    roomNumberController.clear();
    apartmentNumberController.clear();
    officeNumberController.clear();
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

  @override
  void onInit() {
    super.onInit();
    loadAllRooms();
  }

  Future<void> loadAllRooms() async {
    try {
      toggleLoading();
      final url = Uri.parse("${AppStrings.BASE_URL}/room");
      final response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);
      final roomsJson = jsonResponse['rooms'] as List<dynamic>;
      print(roomsJson);

      _myAddedRooms.value = roomsJson
          .map((roomJson) => Room.fromJson(roomJson))
          .where((room) => room.owner == getUserId())
          .toList();
      toggleLoading();
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    }
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

        if (!isImagePicked.value) {
          Get.snackbar(
            'Empty Field',
            'Please provide images by adding them.',
          );
          return;
        }

        if (!isLocationPicked.value) {
          Get.snackbar(
            'Empty Field',
            'Please pick your property location.',
          );
          return;
        }

        toggleLoading();
        final List<ImageFile> images = multiImageController.images.toList();
        final formData = {
          'room_number': roomNumberController.text.trim(),
          'address': propertyAddressController.text.trim(),
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

        if (response.statusCode == 201) {
          var decoded = jsonDecode(response.body)['room'];
          Property property = Property(
              propertyId: decoded['_id'],
              propertyType: 'room',
              ownerId: getUserId()!);
          _myProperties.value.add(property);
          print(property.ownerId);
          print(property.propertyId);
          print(property.propertyType);
          Room room = Room.fromJson(decoded);
          _myAddedRooms.value.add(room);
          clearFields();
          Get.back();
          print(_myAddedRooms.value.length);
          Get.snackbar(
            'Success',
            'Room created successfully',
          );
        } else {
          Get.snackbar(
            'Error',
            jsonDecode(response.body)['message'],
          );
        }
      }
    } catch (error) {
      print(error);
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
