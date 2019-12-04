import 'package:carwashapp/core/models/chatModel.dart';
import 'package:carwashapp/core/services/chatApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {

  ChatApi _api = locator<ChatApi>();

  Stream<QuerySnapshot> fetchPersonsAsStream(String contractId) {
    return _api.streamDataCollection(contractId);
  }

  Future<void> addChat(Chat data, String contractId) async{
    await _api.addDocument(data.toJson(), contractId);
  }

}