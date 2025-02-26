import 'package:get_storage/get_storage.dart';

final GetStorage _storage=GetStorage();

class StorageHep<T>{
  final String key;
  final T _defaultValue;

  StorageHep({required this.key,required T defaultValue}):_defaultValue=defaultValue;

  save(T t){
    _storage.write(key, t);
  }

  T get()=>_storage.read(key)??_defaultValue;
}