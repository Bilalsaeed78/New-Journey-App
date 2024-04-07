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
  var liftAvailable = true;
  var wifiAvailable = true;
  var acAvailable = true;
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
    liftAvailable = true;
    wifiAvailable = true;
    acAvailable = true;
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
      final url =
          Uri.parse("${AppStrings.BASE_URL}/property/owner/${getUserId()}");
      final resp = await http.get(url);

      final jsonResponse = jsonDecode(resp.body);
      final propertiesJson = jsonResponse['properties'] as List<dynamic>;

      List<Property> properties = propertiesJson
          .map((propertyJson) => Property.fromJson(propertyJson))
          .toList();

      for (Property property in properties) {
        if (property.type == 'room') {
          final roomUrl =
              Uri.parse("${AppStrings.BASE_URL}/room/${property.propertyId}");
          final roomResp = await http.get(roomUrl);
          final roomJson = jsonDecode(roomResp.body)['room'];
          final room = Room.fromJson(roomJson);
          _myAddedRooms.value.add(room);
        }
      }
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
          Room room = Room.fromJson(decoded);
          _myAddedRooms.value.add(room);

          Property property = Property(
              propertyId: room.id, type: 'room', ownerId: getUserId()!);

          var url = Uri.parse("${AppStrings.BASE_URL}/property");
          final propertyResp = await http.post(
            url,
            body: property.toJson(),
          );

          var data = jsonDecode(propertyResp.body);
          _myProperties.value.add(Property.fromJson(data['property']));
          clearFields();
          Get.back();
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
