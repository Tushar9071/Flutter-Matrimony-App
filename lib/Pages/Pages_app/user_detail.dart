import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final String? name;
  final String? email;
  final String? password;
  final String? city;
  final String? phone;
  final String? gender;
  final String? deb;
  final List<String>? hobbies;
  final int? age;

  UserDetail({
    super.key,
    this.name,
    this.email,
    this.password,
    this.city,
    this.phone,
    this.gender,
    this.deb,
    this.hobbies,
    this.age,
  });

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;
  String? _selectedCity;
  List<String> _hobbies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.name ?? '';
    _emailController.text = widget.email ?? '';
    _passwordController.text = widget.password ?? '';
    _phoneController.text = widget.phone ?? '';
    _dobController.text = widget.deb ?? '';
    _selectedGender = widget.gender;
    _selectedCity = widget.city;
    _hobbies = widget.hobbies ?? [];
    _ageController.text = widget.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
                    Text(
                      _nameController.text,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'About',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              infoTile('Name', _nameController.text),
              infoTile('Gender', _selectedGender.toString()),
              infoTile('Date of Birth', _dobController.text),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Age',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      '${_ageController.text}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              infoTile('Country', 'India'),
              infoTile('City', _selectedCity.toString()),
              SizedBox(height: 20),
              Text(
                'Professional Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              infoTile('Higher Education', 'B.Sc(Hons)CS'),
              infoTile('Occupation', 'Software Engineer'),
              SizedBox(height: 20),
              Text(
                'Contact Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              infoTile('Email ID',_emailController.text),
              infoTile('Phone', _phoneController.text),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
