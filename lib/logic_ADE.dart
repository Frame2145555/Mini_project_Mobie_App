import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/model.dart'; // นำเข้า class Expense ของคุณ[cite: 2]

class ADELogic {
  // ตั้งค่า URL สำหรับ expenses 
  static const String baseUrl = 'http://localhost:3000/expenses';

  // 1. Add - ฟังก์ชันเพิ่มรายการใหม่
  static Future<bool> addExpense(Expense expense) async { 
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(expense.toJSON()), // แปลงข้อมูลกลับเป็น JSON[cite: 2]
      );
      
      // json-server มักจะคืนค่า 201 Created เมื่อ POST สำเร็จ
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error adding expense: $e');
      return false;
    }
  }

  // 2. Edit - ฟังก์ชันแก้ไขรายการเดิม
  static Future<bool> editExpense(String id, Expense updatedExpense) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedExpense.toJSON()), // แปลงข้อมูลอัปเดตเป็น JSON[cite: 2]
      );
      
      // json-server คืนค่า 200 OK เมื่อ PUT สำเร็จ
      if (response.statusCode == 200) {
        return true;
      }
        return false;
    } catch (e) {
      print('Error editing expense: $e');
      return false;
    }
  }

  // 3. Delete - ฟังก์ชันลบรายการ
  static Future<bool> deleteExpense(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );
      
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting expense: $e');
      return false;
    }
  }
}

