import 'package:flutter/material.dart';

class HeaderProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      color: Colors.blue,
      height: 120.0,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: 60.0,
            height: 100.0,
            child: CircleAvatar(                            
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.blue, size: 30.0,),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Container(                           
              margin: EdgeInsets.only(left: 10.0),
              child: Column(                
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Text("Usuário logado" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
