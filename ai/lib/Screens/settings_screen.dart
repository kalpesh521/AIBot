import 'package:ai/Provider/theme_provider.dart';
import 'package:ai/Screens/signIn_screen.dart';
import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:ai/utils/Constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);

    final themeState = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: false,
        title: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(
                  themeState.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  "App",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                subtitle: Text(
                  "Customize Theme",
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                trailing: Switch(
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
                 
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info,
                            size: 25,
                            color: Theme.of(context).colorScheme.secondary),
                      ],
                    ),
                    SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "About",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Experience seamless interaction with our AI conversational agent, delivering contextually relevant responses and supporting voice-based interactions, while effortlessly translating ideas into exceptionally accurate images.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      _providerState.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You are Logged Out !',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app, color: Colors.red),
                      title: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
      // bottomNavigationBar:  NotchBarWidget() ,
    );
  }
}
