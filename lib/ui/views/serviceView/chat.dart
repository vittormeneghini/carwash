import 'package:carwashapp/ui/widgets/messageWidget/listenContract.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  String contractId;
  Chat(this.contractId);

  @override
  Widget build(BuildContext context) {
    return ListenContract(contractId: contractId);
  }
}