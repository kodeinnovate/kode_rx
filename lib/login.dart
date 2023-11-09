import 'package:flutter/material.dart';

import 'app_colors.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
      backgroundColor: AppColors.customBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset('assets/images/kodeinnovate.png',
                              width: 50.0, height: 50.0),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('NEORx',
                                style: TextStyle(
                                    fontSize: 44.0, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double spacing;
                      if (constraints.maxWidth < 600) {
                        // Mobile mode
                        spacing = 133.0;
                      } else {
                        // Tablet mode or larger
                        spacing = 273.0;
                      }

                      return SizedBox(height: spacing); // Add space below the top elements
                    },
                  ),
                  // Add the login_image here
                  Image.asset('assets/images/login_image.png', fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        // Other container properties...
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Phone Number ',
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                TextSpan(text: 'To Get Started'),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 15.0)),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              border: Border.all(
                                color: Colors.black38, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onSubmitted: (String value) {
                                Navigator.of(context).pushReplacementNamed('/otpPage');
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter your phone number',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
