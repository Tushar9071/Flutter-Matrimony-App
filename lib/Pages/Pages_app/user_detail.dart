import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:submition/db/my_db.dart';
import '../../utils/string_const.dart';

class UserDetail extends StatefulWidget {
  final int? id;

  const UserDetail({super.key, required this.id});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  MyDb myDb = MyDb();
  String? _name, _email, _phone, _dob, _age, _selectedGender, _selectedCity;
  List<String> _hobbies = [];
  bool _isLoading = true; // 🟢 Show loading indicator initially

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      fetchData(widget.id!);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchData(int id) async {
    try {
      var data = await myDb.getById(id);

      if (data.isNotEmpty) {
        setState(() {
          _name = data[0][NAME] ?? "N/A";
          _email = data[0][EMAIL] ?? "N/A";
          _phone = data[0][PHONE] ?? "N/A";
          _dob = data[0][DOB] ?? "N/A";
          _age = data[0][AGE]?.toString() ?? "N/A";
          _selectedGender = data[0][GENDER] ?? "N/A";
          _selectedCity = data[0][CITY] ?? "N/A";

          _hobbies = data[0][HOBBIES] != null && data[0][HOBBIES]!.isNotEmpty
              ? List<String>.from(jsonDecode(data[0][HOBBIES]))
              : [];

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Profile')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _name == null
          ? Center(child: Text("No user found with this ID"))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(Icons.account_circle, size: 100, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(_name ?? "N/A",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              sectionTitle('About'),
              infoTile('Name', _name ?? "N/A"),
              infoTile('Gender', _selectedGender ?? "N/A"),
              infoTile('Date of Birth', _dob ?? "N/A"),
              infoTile('Age', _age ?? "N/A"),

              SizedBox(height: 20),
              sectionTitle('Location'),
              infoTile('Country', 'India'),
              infoTile('City', _selectedCity ?? "N/A"),

              SizedBox(height: 20),
              sectionTitle('Professional Details'),
              infoTile('Higher Education', 'B.Sc(Hons)CS'),
              infoTile('Occupation', 'Software Engineer'),

              SizedBox(height: 20),
              sectionTitle('Contact Details'),
              infoTile('Email ID', _email ?? "N/A"),
              infoTile('Phone', _phone ?? "N/A"),

              if (_hobbies.isNotEmpty) ...[
                SizedBox(height: 20),
                sectionTitle('Hobbies'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _hobbies.map((hobby) => Text("• $hobby")).toList(),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Divider(),
      ],
    );
  }

  Widget infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
