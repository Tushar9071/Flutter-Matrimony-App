import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:submition/db/my_db.dart';
import 'package:submition/utils/string_const.dart'; // For date formatting

class UserForm extends StatefulWidget {
  final int? id;

  const UserForm({super.key, this.id});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _isvisibility = true;
  bool _isvisforconfirmpassword = true;

  String? _selectedGender;
  String? _selectedCity;
  List<String> _hobbies = [];

  bool _isFirst = true;

  final List<String> cities = ['Rajkot', 'Ahmadabad', 'Jamnagar', 'Morbi'];
  final List<String> hobbiesOptions = [
    'Reading',
    'Traveling',
    'Gaming',
    'Sports'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _isFirst = false;
      fetchData(widget.id!);
    }
  }

  MyDb db = MyDb();

  Future<void> fetchData(int id) async {
    var data = await db.getById(id);

    setState(() {
      _nameController.text = data[0][NAME];
      _emailController.text = data[0][EMAIL];
      _passwordController.text = data[0][PASSWORD];
      _phoneController.text = data[0][PHONE];
      _dobController.text = data[0][DOB];
      _selectedGender = data[0][GENDER];
      _selectedCity = data[0][CITY];

      _hobbies = data[0][HOBBIES] != null && data[0][HOBBIES]!.isNotEmpty
          ? List<String>.from(jsonDecode(data[0][HOBBIES]))
          : []; // Default to empty list if null
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isFirst ? Text('Input Form') : Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"^[a-zA-Z\s'-]{3,50}$").hasMatch(value)) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isvisibility = !_isvisibility;
                            });
                          },
                          icon: Icon(_isvisibility
                              ? Icons.visibility_off
                              : Icons.visibility))),
                  obscureText: _isvisibility,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isvisforconfirmpassword =
                              !_isvisforconfirmpassword;
                            });
                          },
                          icon: Icon(_isvisforconfirmpassword
                              ? Icons.visibility_off
                              : Icons.visibility))),
                  obscureText: _isvisforconfirmpassword,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null ||
                        value.length != 10 ||
                        !RegExp(r'^\+?1?\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text('Gender:'),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                DropdownButtonFormField(
                  value: _selectedCity,
                  decoration: const InputDecoration(labelText: 'City'),
                  items: cities
                      .map((city) =>
                      DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a city';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text('Hobbies:'),
                ),
                Column(
                  children: hobbiesOptions.map((hobby) {
                    return CheckboxListTile(
                      title: Text(hobby),
                      value: _hobbies.contains(hobby),
                      onChanged: (isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            _hobbies.add(hobby);
                          } else {
                            _hobbies.remove(hobby);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2005),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      final age = DateTime
                          .now()
                          .year - pickedDate.year;
                      if (age < 18) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('You must be 18+ years old.')),
                        );
                      } else {
                        _dobController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> m = {};
                          m[NAME] = _nameController.text;
                          m[EMAIL] = _emailController.text;
                          m[PASSWORD] = _passwordController.text;
                          m[PHONE] = _phoneController.text;
                          m[GENDER] = _selectedGender;
                          m[ISFAVORITE] = 0;
                          m[CITY] = _selectedCity;
                          m[HOBBIES] = jsonEncode(_hobbies);
                          m[DOB] = _dobController.text;
                          m[AGE] = DateTime
                              .now()
                              .year -
                              int.parse(_dobController.text.split('-')[0]);

                          if (widget.id == null) {
                            await db.insert(m);
                          } else {
                            await db.updateUser(widget.id!, m);
                          }

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(widget.id == null
                                    ? 'User Added Successfully!'
                                    : 'User Updated Successfully!')),
                          );
                        }
                      },
                      child: _isFirst ? Text('Submit') : Text('Update'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
