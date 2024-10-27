import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';

class ExcelUtil {
  static Future<List<(String, String)>> importExcel() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    List<(String, String)> arr = [];

    try {
      if (result != null) {
        var bytes = File(result.files.single.path!).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]?.rows ?? []) {
            var name = '';
            var email = '';
            for (var cell in row) {
              final value = cell?.value;
              if (cell?.rowIndex != 0) {
                switch (value) {
                  case null:
                  // throw Exception('Empty Cell');
                  case TextCellValue():
                    if (cell?.columnIndex == 0) {
                      name = '$value';
                    }
                    if (cell?.columnIndex == 1) {
                      email = '$value';
                    }
                  default:
                    name = '';
                    email = '';
                }
              }
            }
            if (name.isNotEmpty || email.isNotEmpty) {
              arr.add((name, email));
            }
          }
        }
        return arr;
      } else {
        throw Exception('Could not read excel file');
      }
    } catch (e) {
      return [];
    }
  }
}
