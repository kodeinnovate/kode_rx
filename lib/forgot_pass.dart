import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forgot_Pass extends StatefulWidget {
  @override
  State<Forgot_Pass> createState() => _Forgot_PassState();
}

class _Forgot_PassState extends State<Forgot_Pass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/Forgot.jpg', fit: BoxFit.cover),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'email',
                            hintText: 'Enter your email to get recovery link',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty ? 'please enter email' : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: MaterialButton(                        
                          minWidth: double.infinity,
                          onPressed: () {},
                          child: Text('reset password'),
                          color: Colors.blueAccent,
                          textColor: CupertinoColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
