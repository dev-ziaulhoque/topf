import 'package:get_storage/get_storage.dart';



class LocalStorage{
  static final _box = GetStorage();

  static Future<void> saveData({required String key, required dynamic data})async{
    await _box.write(key.toString(), data);
  }

  static dynamic getData({required String key}){
    return _box.read(key.toString());
  }

  static Future<void> removeData({required String key})async{
    await _box.remove(key.toString());
  }
  static Future<void> removeAllData()async{
    await _box.erase();
  }
}