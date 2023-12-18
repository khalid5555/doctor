import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/app/data/models/qr_product_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/repositories/database_helper.dart';

class AddInfoController extends GetxController {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController priceCtl = TextEditingController();
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController quantityCtl = TextEditingController();
  RxList<QrProductModel> productsList = <QrProductModel>[].obs;
  static const String dbName = "qr_database";
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<void> writeToFile(QrProductModel data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    await file.writeAsString(jsonEncode(data.toMap()));
  }

  Future<int> getFileLength() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    int length = await file.length();
    return length;
  }

  /* Future<File> get _localFile async {
    final path = await localPath;
    return File('$path/my_file.txt');
  } */
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // printInfo(info: directory.path.toString());
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/my_file.txt');
  }

  /* Future<List<dynamic>?> readListFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      if (await file.exists()) {
        // File exists, proceed with reading
        String contents = await file.readAsString();
        List<dynamic> list = jsonDecode(contents);
        return list;
      } else {
        // File does not exist, handle the error
        return null;
      }
    } catch (e) {
      // If encountering an error, return null
      return null;
    }
  } */
  /*  Future<List<QrProductModel>?> readFromFile() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      // Convert the string to a QrProductModel
      productsList.assignAll({QrProductModel.fromMap(jsonDecode(contents))});
      // List<QrProductModel> products = [
      //   QrProductModel.fromJson(jsonDecode(contents))
      // ];
      // QrProductModel product = QrProductModel.fromJson(jsonDecode(contents));
      return productsList;
    } catch (e) {
      // If encountering an error, return null
      return null;
    }
  }
  void methodName() async {
    final List<QrProductModel>? numberOfDocuments = await readFromFile();
    print('Number of documents: ${numberOfDocuments![0].quantity}  ');
    print('Number of documents2222222222: ${productsList.length}  ');
  } */
  Future<void> getAllQrCode() async {
    List<Map<String, dynamic>> qrList = await DatabaseHelper().getDocuments();
    productsList
        .assignAll(qrList.map((e) => QrProductModel.fromMap(e)).toList());
    update();
  }

  Future<void> deleteById(int id) async {
    _databaseHelper.delete(id).then((value) {
      getAllQrCode();
      Get.snackbar('أنتبة', 'تم الحذف  بنجاح');
    }).catchError((e) {
      Get.snackbar('أنتبة', 'يوجد خطاء \n $e');
      printInfo(info: 'يوجد خطاء');
    });
    // await getAllQrCode();
    // printInfo(info: 'Document deleted successfully');
    // print(' id qrlist ${qrList.length}');
  }

  Future<void> deleteDatabase() async {
    try {
      // final directory = await getDatabasesPath();
      // final path = '$directory/qr_database.db';
      // String path = '${await getDatabasesPath()}/qr_database.db';
      // String path = '$directory/qr_database.db';
      String path = '${await getDatabasesPath()} + qr_database.db';
      // String path = '${await getDatabasesPath()}/qr_database.db';
      await File(path).delete();
      // final file = File(path);
      // if (file.existsSync()) {
      //   await file.delete();
      // }
      await getAllQrCode();
      Get.snackbar('أنتبة', 'تم حذف قاعدة البيانات بنجاح');
      printInfo(info: 'Database deleted successfully');
    } catch (e) {
      printError(info: 'Error deleting database: $e');
      Get.snackbar('أنتبة', 'يوجد خطاء \n $e');
    }
  }
}
