import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    _library = (await secureStorage.getStringList('ff_library')) ?? _library;
  }

  late FlutterSecureStorage secureStorage;

  List<String> _library = [];
  List<String> get library => _library;
  set library(List<String> _value) {
    notifyListeners();

    _library = _value;
    secureStorage.setStringList('ff_library', _value);
  }

  void deleteLibrary() {
    notifyListeners();
    secureStorage.delete(key: 'ff_library');
  }

  void addToLibrary(String _value) {
    notifyListeners();
    _library.add(_value);
    secureStorage.setStringList('ff_library', _library);
  }

  void removeFromLibrary(String _value) {
    notifyListeners();
    _library.remove(_value);
    secureStorage.setStringList('ff_library', _library);
  }

  String _croppedPictureURI =
      'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZHViYWl8ZW58MHx8MHx8&w=1000&q=80';
  String get croppedPictureURI => _croppedPictureURI;
  set croppedPictureURI(String _value) {
    notifyListeners();

    _croppedPictureURI = _value;
  }

  String _selectPhoto = '';
  String get selectPhoto => _selectPhoto;
  set selectPhoto(String _value) {
    notifyListeners();

    _selectPhoto = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await write(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await write(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await write(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await write(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await write(key: key, value: ListToCsvConverter().convert([value]));
}
