import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/world_states_model.dart';
import 'Utilties/API.dart';

class WorldServices{
  Future<WorldStatesModel> getWorld() async{
  final response=await http.get(Uri.parse(APIURL.worldstateApi));
  if(response.statusCode==200){
 var data= jsonDecode(response.body);
  return WorldStatesModel.fromJson(data);
  }
else{
  throw Exception("Error");
}
  }
    
}

class CountriesServices{
  Future<List<dynamic>> getCountriesAPI() async{
  final response=await http.get(Uri.parse(APIURL.countrieslist));
  if(response.statusCode==200){
 var data= jsonDecode(response.body);
  return data;
  }
else{
  throw Exception("Error");
}
  }
    
}