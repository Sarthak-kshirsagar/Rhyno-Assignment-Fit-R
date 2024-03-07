import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String selectedGender = 'Male'; // Default selected gender

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select Your Gender:',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        DropdownButton<String>(
          value: selectedGender,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black, fontSize: 16),
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue!;
            });
          },
          items: <String>['Male', 'Female', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          'Selected Gender: $selectedGender',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
