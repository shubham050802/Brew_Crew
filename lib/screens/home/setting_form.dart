import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currName = '';
  String _currSugars = '';
  int _currStrength = 100;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Text(
          'Update your brew preferance',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: textInputDecoration.copyWith(fillColor: Colors.grey[300]),
          validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
          onChanged: (val) => setState(() {
            _currName = val;
          }),
        ),
        SizedBox(
          height: 20.0,
        ),
        //Drop down
        DropdownButtonFormField(
          value: '0',
          decoration: textInputDecoration,
          items: sugars.map((sugar) {
            return DropdownMenuItem(
              value: sugar,
              child: Text(sugar + ' sugars'),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _currSugars = val.toString();
            });
          },
        ),
        //Slider
        Slider(
          activeColor: Colors.brown[_currStrength],
          inactiveColor: Colors.brown[_currStrength],
          min: 100.0,
          max: 900.0,
          divisions: 8,
          onChanged: (value) => setState(() {
            _currStrength = value.toInt();
          }),
          value: (_currStrength).toDouble(),
        ),
        ElevatedButton(
          onPressed: () async {
            print(_currName);
            print(_currStrength);
            print(_currSugars);
          },
          child: Text(
            'Update',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[400],
          ),
        ),
      ]),
    );
  }
}
