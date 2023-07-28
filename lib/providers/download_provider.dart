import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProvider with ChangeNotifier {
  String? _directoryPath;
  Directory? _directory;
  final List<FileSystemEntity> _listOfFiles = [];

  List<FileSystemEntity> get listOfFiles {
    return [..._listOfFiles];
  }

  String? checkFile(String url) {
    var fileList = _listOfFiles
        .where((element) => element.path.contains((url).split('/').last));
    if (fileList.isNotEmpty) {
      return fileList.first.absolute.path;
    }
    return null;
  }

  Future initFilesAgain() async {
    try {
      var dir = (await getApplicationSupportDirectory());
      _directoryPath =
          '${dir.path}/downloads';
      _directory = Directory(_directoryPath ?? '');
      if ((await _directory?.exists()) == false) {
        _directory?.create();
      }
      _listOfFiles.clear();
      _directory?.listSync().forEach((element) {
        if(element.runtimeType.toString().toLowerCase().contains('file') == true) {
          _listOfFiles.add(element);
        }
      });
      WidgetsBinding.instance?.addPostFrameCallback((status) {
        notifyListeners();
      });
    } catch (e) {
      printDebug(e.toString());
    }
  }

  Future<String?> downloadFile(String url, {String type = 'doc'}) async {
    String? downloadedFilePath;
    try {
      var filePath = '$_directoryPath/${type}_${url.split('/').last}';
      Response response;
      Map<String, dynamic> result = {
        'isSuccess': false,
        'filePath': null,
        'error': null,
      };

      response = await Dio().get(
        url,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            validateStatus: (status) {
              return (status ?? 0) < 500;
            }),
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = filePath;
      File file = File(filePath);
      RandomAccessFile rAccessFile = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      rAccessFile.writeFromSync(response.data);
      //EasyLoading.dismiss();
      await rAccessFile.close();
      downloadedFilePath = filePath;
    } catch (e) {
      return null;
    }
    await initFilesAgain();
    return downloadedFilePath;
  }
}
