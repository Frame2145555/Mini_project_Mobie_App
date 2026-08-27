import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/model.dart';


class TotalLogic  {
  static Future<List<Expense>> getTasks() async{
    //connect to backend
    http.Response URL = await http.get(Uri.parse('http://localhost:3000/todo'));

    try {
      if(URL.statusCode != 200){
        throw Exception('Connection fail!');
      }

      List data = json.decode(URL.body);
      
      List result = []; 
      for(Map<String, dynamic> d in data){
        result.add(Expense.formJSON(d));
      }

      return result.cast<Expense>();

    } catch (e) {
      print(e);
      throw Exception('Error : $e');
    }
  }
  
}