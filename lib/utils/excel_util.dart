import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../model/excel_model.dart';
import 'dart:io';

class ExcelUtil {
  Future<List<ExcelModel>> importExcel() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    List<ExcelModel> companies = [];

    List<String> names = [];
    List<String> emails = [];

    try {
      late dynamic numFormat;
      if (result != null) {
        var bytes = File(result.files.single.path!).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]?.rows ?? []) {
            for (var cell in row) {
              final value = cell?.value;
              numFormat = cell?.cellStyle?.numberFormat ?? NumFormat.standard_0;
              if (cell?.rowIndex != 0) {
                switch (value) {
                  case null:
                    throw Exception('Empty Cell');
                  case TextCellValue():
                    if (cell?.columnIndex == 0) {
                      names.add('$value');
                    } else {
                      emails.add('$value');
                    }
                  default:
                }
              }
            }
          }

          for (var email in emails) {
            companies.add(ExcelModel.fromJson(
                {'name': names[emails.indexOf(email)], 'email': email}));
          }
        }
        return companies;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
