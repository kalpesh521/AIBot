import 'package:ai/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai/Screens/registration_screen.dart';
import 'package:ai/Screens/login_screen.dart';

class ProviderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ProviderState _providerState = Provider.of<ProviderState>(context,listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("UID: ${_providerState.getUid}"),
            Text("Email : ${_providerState.getEmail}"),
            Text("Email : ${_providerState.getFirstName}"),
            Text("Email : ${_providerState.getLastName}"),
            ElevatedButton(onPressed: (){
              //logout
              _providerState.signOut();
              Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProviderLogin()));
            },child: Text("Sign Out "),),
          ],
        ),
      ),
    );
  }
}