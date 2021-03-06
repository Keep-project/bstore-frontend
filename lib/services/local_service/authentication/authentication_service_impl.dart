
import 'package:bstore/core/constants.dart';
import 'package:bstore/services/local_service/local_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthenticationServicesImpl implements LocalAuthenticationServices{
  
  @override
  Future<bool> deleteToken() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.remove(Constants.BSTORE_TOKEN);
    return true;
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    return preferences.getString(Constants.BSTORE_TOKEN);
  }

  @override
  Future<bool> saveToken(String token) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setString(Constants.BSTORE_TOKEN, token);
    return true;
  }
  
  @override
  Future<bool> hasAuthToken() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    if (preferences.getString(Constants.BSTORE_TOKEN) != null){
      return true;
    }
    else{
      return false;
    }
  }
  
  @override
  Future<void> saveUser(String user) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setString(Constants.BSTORE_USER, user);
  }
  
  @override
  Future<String?> getUser() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    return preferences.getString(Constants.BSTORE_USER) ?? "";
  }
  
  @override
  Future<String?> getBookId() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    return preferences.getString(Constants.BSTORE_BOOK_ID) ?? "";
  }
  
  @override
  Future<void> saveBookId(String id) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setString(Constants.BSTORE_BOOK_ID, id);
  }
  
  @override
  Future<bool> deleteBookId() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.remove(Constants.BSTORE_BOOK_ID);
    return true;
  }

}