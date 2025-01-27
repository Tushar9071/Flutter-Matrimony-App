import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class UserDetail extends StatefulWidget {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? gender;
  final String? deb;

  const UserDetail({super.key,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.deb});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender;
  String? _selectedCity;
  final List<String> _hobbies = [];

  final List<String> cities = ['Rajkot', 'Ahmadabad', 'Jamnagar', 'Morbi'];
  final List<String> hobbiesOptions = [
    'Reading',
    'Traveling',
    'Gaming',
    'Sports'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !RegExp(r"^[a-zA-Z\s'-]{3,50}$").hasMatch(value)) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}\$')
                            .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                // Password
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

                // Confirm Password
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

                // Phone Number
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null ||
                        value.length != 10 ||
                        !RegExp(r'^\d{10}\$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),

                // Gender
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

                // City
                DropdownButtonFormField(
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

                // Hobbies
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text('Hobbies:'),
                ),
                Column(
                  children: hobbiesOptions
                      .map((hobby) =>
                      CheckboxListTile(
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
                      ))
                      .toList(),
                ),

                // Date of Birth
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

                // Submit Button
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Form Submitted Successfully!')),
                          );
                        }
                      },
                      child: const Text('Submit'),
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
