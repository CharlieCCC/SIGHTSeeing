import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const URL_RECORD = 'https://api.sightseeing.projects.sight.ust.hk/check-record';


Future<OptTest> createOptTest(String patientID, Map<String, dynamic> body) async {

  return http.patch('${URL_RECORD}?patient_id=${patientID}', body: body).then((http.Response response) {

    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null){
      throw new Exception("Error while fetching data");
    }
    final rep = json.decode(response.body);
    final repJson = rep[0];
    return OptTest.fromJson(repJson);
  });
}

class OptTest{
  //final String patient_id;
  final String left_opto_diopter;
  final String right_opto_diopter;
  final String left_opto_astigmatism;
  final String right_opto_astigmatism;
  final String left_opto_astigmatismaxis;
  final String right_opto_astigmatismaxis;

  OptTest({this.left_opto_diopter, this.right_opto_diopter, this.left_opto_astigmatism, this.right_opto_astigmatism, this.left_opto_astigmatismaxis, this.right_opto_astigmatismaxis});

  factory OptTest.fromJson(Map<String, dynamic> json){
    return OptTest(
      //patient_id: json['data'][0]['patient_id'],
      left_opto_diopter: json['left_opto_diopter'],
      right_opto_diopter: json['right_opto_diopter'],
      left_opto_astigmatism: json['left_opto_astigmatism'],
      right_opto_astigmatism: json['right_opto_astigmatism'],
      left_opto_astigmatismaxis: json['left_opto_astigmatismaxis'],
      right_opto_astigmatismaxis: json['right_opto_astigmatismaxis'],
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    //map['patient_id'] = patient_id;
    map['left_opto_diopter'] = left_opto_diopter;
    map['right_opto_diopter'] = right_opto_diopter;
    map['left_opto_astigmatism'] = left_opto_astigmatism;
    map['right_opto_astigmatism'] = right_opto_astigmatism;
    map['left_opto_astigmatismaxis'] = left_opto_astigmatismaxis;
    map['right_opto_astigmatismaxis'] = right_opto_astigmatismaxis;

    return map;
  }

}

// Updated
