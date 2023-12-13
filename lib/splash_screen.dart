import 'package:flutter/material.dart';
import 'package:kode_rx/login.dart';
import 'app_colors.dart';


class Splashscreen extends StatefulWidget{

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
@override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(seconds: 2),(){});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen() ,));
  }

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: AppColors.customBackground,
        child: Center(child: Image.asset('assets/images/ic_logo.png', height: 200, width: 200,),)
      ),
    );
  }
}