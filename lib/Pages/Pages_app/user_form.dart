import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:submition/utils/string_const.dart'; // For date formatting

class UserForm extends StatefulWidget {
  final String? name;
  final String? email;
  final String? password;
  final String? city;
  final String? phone;
  final String? gender;
  final String? deb;
  final List<String>? hobbies;

  const UserForm(
      {super.key,
      this.name,
      this.email,
      this.password,
      this.city,
      this.phone,
      this.gender,
      this.deb,
      this.hobbies});

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

  String? _selectedGender;
  String? _selectedCity;
  List<String> _hobbies = [];

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
    _nameController.text = widget.name ?? '';
    _emailController.text = widget.email ?? '';
    _passwordController.text = widget.password ?? '';
    _phoneController.text = widget.phone ?? '';
    _dobController.text = widget.deb ?? '';
    _selectedGender = widget.gender;
    _selectedCity = widget.city;
    _hobbies = widget.hobbies ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _nameController.text == ''?Text('Input Form'):Text('Update User'),
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
                        !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
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
                      .map((city) => DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                      print(':::$_selectedCity');
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
                      final age = DateTime.now().year - pickedDate.year;
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          Map<String, dynamic> m = {};
                          m[NAME] = _nameController.text;
                          m[EMAIL] = _emailController.text;
                          m[PASSWORD] = _passwordController.text;
                          m[PHONE] = _phoneController.text;
                          m[GENDER] = _selectedGender;
                          m[ISFAVORITE] = false;
                          m[CITY] = _selectedCity;
                          m[HOBBIES] = _hobbies;
                          m[DOB] = _dobController.text;
                          m[AGE] = DateTime.now().year -
                              int.parse(_dobController.text.split('-')[0]);
                          // print(":::$m:::");
                          Navigator.pop(context, m);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Form Submitted Successfully!')),
                          );
                        }
                      },
                      child: _nameController.text == ''?Text('Submit'):Text
                        ('Update'),
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
