import 'dart:convert';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

postWithMultiFile(String url, Map data, List<File> files, names) async {
  print(files);
  print(names);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var multipartrequest = await http.MultipartRequest('POST', Uri.parse(url));
  for (int i = 0; i < files.length; i++) {
    var length = await files[i].length();
    var stream = await http.ByteStream(files[i].openRead());
    var multipartfile = await http.MultipartFile('${names[i]}', stream, length,
        filename: basename(files[i].path));
    multipartrequest.files.add(multipartfile);
  }
  data.forEach((key, value) {
    multipartrequest.fields[key] = value;
  });
  http.StreamedResponse sresponce = await multipartrequest.send();
  http.Response response = await http.Response.fromStream(sresponce);
  print(jsonDecode(response.body));
  return jsonDecode(response.body);
}
