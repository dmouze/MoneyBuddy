import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BttmNavigationBar.dart';
import 'MainScreen.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  int _currentIndex = 1;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late ScaffoldMessengerState _scaffoldMessengerState;
  String newPassword = "";

  List<BttmNavigationBarModel> BttmNavigationBarItems = [
    BttmNavigationBarModel(icon: Icons.monetization_on, label: "Ekran Główny"),
    BttmNavigationBarModel(icon: Icons.account_circle, label: "Konto"),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
  }

  Future<bool> _isOldPasswordCorrect(String enteredOldPassword) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Sign in the user with their email and old password to verify it
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: enteredOldPassword,
        );

        // Attempt to re-authenticate the user with the entered old password
        await user.reauthenticateWithCredential(credential);

        // If re-authentication is successful, the old password is correct
        return true;
      } else {
        // No user signed in
        return false;
      }
    } catch (error) {
      // Re-authentication failed, meaning the old password is incorrect
      return false;
    }
  }

  Future<void> _changePassword(String newPassword) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the user's password
        await user.updatePassword(newPassword);

        // Password successfully updated
        // You can show a success message or perform other actions here
      } else {
        // No user signed in
        // You can handle this scenario accordingly
      }
    } catch (error) {
      // An error occurred while changing the password
      // You can handle and show the error message accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff49c4ad),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Ustawienia konta",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BttmNavigationBarItems.map((BttmNavigationBarModel item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          );
        }).toList(),
        backgroundColor: Color(0xffffffff),
        currentIndex: _currentIndex,
        elevation: 8,
        iconSize: 24,
        selectedItemColor: Color(0xff49c4ad),
        unselectedItemColor: Color(0xff9e9e9e),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AccountSettings()),
              );
            }
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Zmiana hasła",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              "Wprowadź nowe dane oraz zapisz zmiany",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff9e9e9e),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Column(
                children: [
                  TextField(
                    controller: _oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Stare hasło',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Nowe hasło',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Potwierdź nowe hasło',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: MaterialButton(
                onPressed: () {
                  String enteredOldPassword = _oldPasswordController.text;
                  if (_isOldPasswordCorrect(enteredOldPassword) == false) {
                    _scaffoldMessengerState.showSnackBar(SnackBar(
                      content: Text("Podane stare hasło jest nieprawidłowe."),
                    ));
                  } else if (_newPasswordController.text !=
                      _confirmPasswordController.text) {
                    _scaffoldMessengerState.showSnackBar(SnackBar(
                      content: Text("Nowe hasła nie są zgodne."),
                    ));
                  } else {
                    newPassword == _confirmPasswordController.text;
                    _changePassword(newPassword);
                  }
                },
                color: Color(0xff49c4ad),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(16),
                textColor: Color(0xffffffff),
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  "Zmień dane",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: MaterialButton(
                onPressed: () {
                  // Add your logout code here!
                },
                color: Color(0xff49c4ad),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(16),
                textColor: Color(0xffffffff),
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  "Wyloguj się",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
