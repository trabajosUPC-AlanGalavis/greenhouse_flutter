import 'package:flutter/material.dart';
import 'package:greenhouse/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://cdn.bioguia.com/embed/6f2a4f61c912d23c0a874b9a33377c8c31684724081/alimentacion-saludable-hongos.jpeg?imagick=1&size=750"),
            fit: BoxFit.cover,
            colorFilter:
            ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black12,
                Colors.black87,
              ],
            ),
          ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Positioned(top: 80, right: 50, left: 50, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom(context)),
          ]),
        )
      )
    );
  }

  Widget _buildTop(){
    return Center(
      child: Container(
          height: 150,
          child: Image.network("https://github.com/greenhouse-mobile/greenhouse-jcompose/blob/feat/authorization/app/src/main/res/drawable/logo.png?raw=true")
      ),
    );
  }

  Widget _buildBottom(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: _loginForm(context),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context){
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          _loginSignUpButton(context),
          SizedBox(height: 40),
          _inputField("Username", Icons.person),
          SizedBox(height: 20),
          _inputField("Password", Icons.lock),
          SizedBox(height: 150),
          _button("Login"),
        ],
      ),
    );
  }

  Widget _loginSignUpButton(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = (screenWidth - 100) / 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            TextButton(
              onPressed: () {},
              child: Text("LOG IN", style: TextStyle(color: Color(0xFF7DA257))),
            ),
            SizedBox(height: 5),
            Container(
              width: containerWidth,
              margin: EdgeInsets.only(left: 10),
              height: 2,
              color: Color(0xFF7DA257),
            ),
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text("SIGN UP", style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 5),
            Container(
              width: containerWidth,
              margin: EdgeInsets.only(right: 10),
              height: 2,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputField(String hintText, IconData icon){
    return TextFormField(
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Please enter your $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: Color(0xFF727272)),
        hintText: 'Enter $hintText',
        hintStyle: TextStyle(color: Color(0xFF727272)),
        fillColor: Color(0xFFECECEC),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF67864A)),
        ),

          prefixIcon: Icon(icon, color: Colors.grey)
      ),
    );
  }

  Widget _button(String buttonText){
    return Container(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF67864A)),
        ),
        child: Text("$buttonText", style: TextStyle(color: Colors.white)
        ),
      ),
    );
  }
}