import 'dart:io';

import 'package:aplicacion_notas_edteam/src/core/constants/parameters.dart';
import 'package:aplicacion_notas_edteam/src/core/models/note.dart';
import 'package:aplicacion_notas_edteam/src/core/models/task.dart' as task;
import 'package:aplicacion_notas_edteam/src/core/services/internet_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices extends InternetServices {
  FirebaseServices._();
  static final instance = FirebaseServices._();

  final ref = FirebaseFirestore.instance;

  //Crear
  Future<Map<String, dynamic>> create(
      String collection, Map<String, dynamic> data) async {
    Map<String, dynamic> dataResponse = {};
    if (await super.connected()) {
      try {
        await ref.collection(collection).add(data);
        dataResponse["status"] = StatusNetwork.Connected;
      } catch (e) {
        dataResponse["status"] = StatusNetwork.Exception;
      }
    } else {
      dataResponse["status"] = StatusNetwork.NoInternet;
    }
    return dataResponse;
  }

  //Leer
  Future<Map<String, dynamic>> read(String collection) async {
    Map<String, dynamic> dataResponse = {};
    List<dynamic> elements = [];
    if (await super.connected()) {
      try {
        final response = await ref.collection(collection).get();
        for (int i = 0; i < response.docs.length; i++) {
          switch (collection) {
            case "notes":
              elements.add(
                  Note.fromSnapshot(response.docs[i], response.docs[0].id));
              break;
            case "task":
              elements.add(task.Task.fromSnapshot(
                  response.docs[i], response.docs[0].id));
              break;
            default:
              break;
          }
        }
        dataResponse["data"] = elements;
        dataResponse["status"] = StatusNetwork.Connected;
      } catch (e) {
        dataResponse["status"] = StatusNetwork.Exception;
      }
    } else {
      dataResponse["status"] = StatusNetwork.NoInternet;
    }
    return dataResponse;
  }

  //Actualizar
  Future<Map<String, dynamic>> update(
      String collection, String id, Map<String, dynamic> data) async {
    Map<String, dynamic> dataResponse = {};
    if (await super.connected()) {
      try {
        await ref.collection(collection).doc(id).update(data);
        dataResponse["status"] = StatusNetwork.Connected;
      } catch (e) {
        dataResponse["status"] = StatusNetwork.Exception;
      }
    } else {
      dataResponse["status"] = StatusNetwork.NoInternet;
    }
    return dataResponse;
  }

  //Eliminar
  Future<Map<String, dynamic>> delete(String collection, String id) async {
    Map<String, dynamic> dataResponse = {};
    if (await super.connected()) {
      try {
        await ref.collection(collection).doc(id).delete();
        dataResponse["status"] = StatusNetwork.Connected;
      } catch (e) {
        dataResponse["status"] = StatusNetwork.Exception;
      }
    } else {
      dataResponse["status"] = StatusNetwork.NoInternet;
    }
    return dataResponse;
  }

  //upload image
  Future<Map<String, dynamic>> uploadImage(File file) async {
    Map<String, dynamic> dataResponse = {};
    if (await super.connected()) {
      try {
        final path = file.path.split("/").last;
        final ref =
            FirebaseStorage.instance.ref().child("images").child("/$path");
        UploadTask uploadTask = ref.putFile(file);

        final uri = await (await uploadTask).ref.getDownloadURL();

        dataResponse["data"] = uri;
        dataResponse["status"] = StatusNetwork.Connected;
      } catch (e) {
        dataResponse["status"] = StatusNetwork.Exception;
      }
    } else {
      dataResponse["status"] = StatusNetwork.NoInternet;
    }
    return dataResponse;
  }
}
