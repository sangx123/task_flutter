

import 'dart:io';
import 'dart:typed_data';

class MFileUtils{
  /**
   * 根据地址获取byte数组
   */
    static Future<Uint8List> readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }


    /**
     * 根据uri获取byte数组
     */
    static Future<Uint8List> readFileByUri(Uri myUri) async {
      File audioFile = new File.fromUri(myUri);
      Uint8List bytes;
      await audioFile.readAsBytes().then((value) {
        bytes = Uint8List.fromList(value);
        print('reading of bytes is completed');
      }).catchError((onError) {
        print('Exception Error while reading audio from path:' +
            onError.toString());
      });
      return bytes;
    }
}