import 'dart:io';

import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';

class CashFileUtils{
  static Future<Null> clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    //删除缓存目录
    await delDir(tempDir);
    await loadCache();
    showToast( 'success');
  }
  ///递归方式删除目录
 static  Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

 static  Future<String> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await getTotalSizeOfFilesInDir(tempDir);
    /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
    print('临时目录大小: ' + value.toString());

    return renderSize(value);
  }

 static Future<double> getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }



 static String renderSize(double value) {
    if (null == value) {
      return "";
    }
    List<String> unitArr = List()
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }



}