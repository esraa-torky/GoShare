import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_share/Home_page.dart';
import 'package:go_share/Screens/Welcome/welcome_screen.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }


}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

final bool showTopTitle = false;
final bool showTitleLeft = false;
final bool showAsTextField = false;
final bool showAsSingleSetting = false;
String _searchAreaResult = "";

class _EditProfilePageState extends State<EditProfilePage> {
  //getCurrentUser();
  bool showPassword = false;
  String Password = "";
  String newEmail = "";
  String newName = "";
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  final myControllerName = TextEditingController();
  //final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        ),

      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextField("Change Name", "", false, myControllerName),
                buildTextField("Change Email", "", false, myControllerEmail),
                buildTextField("Change Password", "", true, myControllerPassword),
                Text("",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SettingRow(
                    rowData: SettingsDropDownConfig(
                        title: 'City',
                        initialKey: _searchAreaResult,
                        choices: {
                          'Germany': 'Berlin',
                          'Spain': 'Barcelona',
                          'France': 'Paris',
                          'Turkey': 'Istanbul'
                        }),
                    onSettingDataRowChange: onSearchAreaChange,
                    config: const SettingsRowConfiguration(
                        showAsTextField: false,
                        showTitleLeft: true,
                        showAsSingleSetting: false)),
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        //padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () {

                          if(myControllerName.text != ""){
                            var user = FirebaseAuth.instance.currentUser;
                            user.updateProfile(displayName: myControllerName.text).then((value)=>{
                              print("Profile has been changed successfully")}
                              //DO Other compilation here if you want to like setting the state of the app
                            ).catchError((e){
                              print("There was an error updating profile");
                            });

                          }


                          if(myControllerEmail.text != ""){
                            FirebaseAuth.instance.currentUser.updateEmail(myControllerEmail.text).then((value) => {
                              print("update succesfull")}
                            ).catchError((error) => {
                              print("Email error" + myControllerEmail.text)
                            });
                          }

                          if(myControllerPassword.text != ""){
                            FirebaseAuth.instance.currentUser.updatePassword("deneme@gmail.com").then((value) => {
                              print("update succesfull")}
                            ).catchError((error) => {
                              print("error occured")
                            });
                          }





                        },
                        color: Colors.green,
                        //padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                      OutlineButton(
                       // padding: EdgeInsets.symmetric(horizontal: 40),

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return WelcomeScreen();
                              },
                            ),
                          );
                        },
                        child: Text("SIGN OUT",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSearchAreaChange(String data) {
    setState(() {
      _searchAreaResult = data;
    });
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,

            )),
      ),
    );
  }

}
