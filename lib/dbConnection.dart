import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:lifting_vision/Bean/DoctorBean.dart';
import 'package:http/http.dart' as http;
import 'package:lifting_vision/Bean/PatientBean.dart';
import 'file_operation.dart';

class DbConnection {
  String URL = "http://79.52.17.125:8000/api/doctorRegistration";
  List<PatientBean>? patientList = <PatientBean>[];

  Future<http.Response> addDoctor(DoctorBean nwDoctor) async {
    print("Before dbConnection");
    final response = await http.post(
      Uri.parse(URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': nwDoctor.name,
        'surname': nwDoctor.surname,
        'email': nwDoctor.email,
        'password': nwDoctor.password,
        'phone_number': nwDoctor.phone_number,
        'birth': nwDoctor.birth,
      }),
    );

    print(response.body);

    return response;
  }

  Future<bool> emailcheck(String email) async {
    print("Inside the email checher");

    final response = await http.post(
      Uri.parse("http://79.52.17.125:8000/api/checkDoctorEmail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    print(response.body);
    //response.bodyBytes
    print("l'email testate è : $email");
    JsonDecoder result = JsonDecoder();

    LinkedHashMap<String, dynamic> map = result.convert(response.body);
    if (map["result"].toString().contains("true")) {
      print("Email già usata");
      return true;
    }

    print("Email non usata");
    return false;
  }

  Future<bool> login(String email, String password) async {
    print("Inside the login checher");

    final response = await http.post(
      Uri.parse("http://79.52.17.125:8000/api/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    print("email: $email");
    print("password: $password");

    JsonDecoder result = JsonDecoder();

    LinkedHashMap<String, dynamic> map = result.convert(response.body);
    if (map["status"] == true) {
      print("Check of map status");
      saveFileToken(map["token"]);
      print("il tuo token è: " + map["token"]);

      print("tipologia di utente : " + map["type"]);
      saveFileType(map["type"]);

      return true;
    }
    return false;
  }

  //to implement
  Future<DoctorBean> getDoctor(String Token) async {
    print("Inside the getDcotor");

    final response = await http.post(
      Uri.parse("http://79.52.17.125:8000/api/getDoctorData"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + Token,
      },
      body: jsonEncode(<String, String>{}),
    );

    print(response.body);
    JsonDecoder result = JsonDecoder();
    LinkedHashMap<String, dynamic> map = result.convert(response.body);
    return DoctorBean(
      map["data"]["name"],
      map["data"]["surname"],
      "", // the password will not be recive for security reason
      map["data"]["birth"],
      map["data"]["email"],
      map["data"]["phoneNumber"],
    );
  }

  void addPatient(String Token, PatientBean patient) async {
    print("Inside the add token");
    //String password = RandomPasswordGenerator() as String;

    final response = await http.post(
      Uri.parse("http://79.52.17.125:8000/api/patientRegistration"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + Token,
      },
      body: jsonEncode(<String, String>{
        'email': patient.email,
        'name': patient.name,
        'surname': patient.surname,
        'phone_number': patient.phone_number,
        'birth': patient.birth,
        'password': "EMAD2223",
      }),
    );

    print(response.body);
    JsonDecoder result = JsonDecoder();
    LinkedHashMap<String, dynamic> map = result.convert(response.body);
    print(map["status"]);
  }

  Future<List<PatientBean>?> getPatient(String Token) async {
    print("Inside the getPatient token");
    print(Token);

    final response = await http.post(
      Uri.parse("http://79.52.17.125:8000/api/getDoctorPatients"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + Token,
      },
      body: jsonEncode(<String, String>{}),
    );

    JsonDecoder result = JsonDecoder();
    LinkedHashMap<String, dynamic> map = result.convert(response.body);

    for (var p in map["data"]) {
      PatientBean patient = PatientBean(
          p["name"], p["surname"], p["birth"], p["email"], p["phoneNumber"]);
      if (!patientList!.contains(patient)) {
        patientList?.add(patient);
      }
    }
    return patientList;
  }

  Future<bool> changePassword(String Token, String password) async {
    print("Inside the changePassword");

    final response = await http.post(
      Uri.parse("http://79.52.17.125:8000/api/changePassword"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + Token,
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    //JsonDecoder result = JsonDecoder();
    //LinkedHashMap<String, dynamic> map = result.convert(response.body);
    //print(map);
    print(response.body);
    return true;
  }
}
