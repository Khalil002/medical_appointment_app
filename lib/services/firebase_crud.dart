/* import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _UserDataCollection =
    _firestore.collection('users_data');

class FirebaseCrud {
  static Future<Response> addEmployee({
    required String uid,
    required String name,
    required String gender,
    required String type,
    required DateTime birthDate,
    required String profilePicture,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _UserDataCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
 */