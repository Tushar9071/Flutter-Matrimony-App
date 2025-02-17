import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submition/Pages/Pages_app/user_detail.dart';
import 'package:submition/Pages/Pages_app/user_form.dart';
import 'package:submition/db/my_db.dart';
import 'package:submition/utils/string_const.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _userList = [];
  List<Map<String, dynamic>> _filteredUserList = [];

  bool _isSearching = false;

  MyDb myDb = MyDb();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    var data = await myDb.getAllData();
    _userList = data ?? [];
    _filteredUserList = List.from(_userList);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search by Name, Email, or Phone",
                  border: InputBorder.none,
                ),
                onChanged: _filterUsers,
              )
            : Text(
                'List Of Users',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                  _filterUsers('');
                }
                _isSearching = !_isSearching;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserForm(),
                ),
              ).then((value) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: !_isSearching
          ? FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data! != []) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return list_card(
                        id: snapshot.data![index]['id'],
                        index: index,
                        username: snapshot.data![index][NAME],
                        email: snapshot.data![index][EMAIL],
                        phoneNumber: snapshot.data![index][PHONE],
                        city: snapshot.data![index][CITY],
                        age: snapshot.data![index][AGE],
                        isfavorite: snapshot.data![index][ISFAVORITE],
                        gender: snapshot.data![index][GENDER],
                        hobbies: snapshot.data![index][HOBBIES],
                        password: snapshot.data![index][PASSWORD],
                        dob: snapshot.data![index][DOB],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No Data Found'),
                  );
                }
              },
            )
          : _filteredUserList.isEmpty
              ? Center(child: Text('No Data Found'))
              : ListView.builder(
                  itemCount: _filteredUserList.length,
                  itemBuilder: (context, index) {
                    return list_card(
                      id: _filteredUserList[index]['id'],
                      index: index,
                      username: _filteredUserList[index][NAME],
                      email: _filteredUserList[index][EMAIL],
                      phoneNumber: _filteredUserList[index][PHONE],
                      city: _filteredUserList[index][CITY],
                      age: _filteredUserList[index][AGE],
                      isfavorite: _filteredUserList[index][ISFAVORITE],
                      gender: _filteredUserList[index][GENDER],
                      hobbies: _filteredUserList[index][HOBBIES],
                      password: _filteredUserList[index][PASSWORD],
                      dob: _filteredUserList[index][DOB],
                    );
                  },
                ),
    );
  }

  Widget list_card(
      {index,
      id,
      username,
      email,
      phoneNumber,
      gender,
      age,
      city,
      isfavorite,
      password,
      hobbies,
      dob}) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return UserDetail(
                id: id,
              );
            },
          ));
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (isfavorite == 1) {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text('Unfavorite User'),
                                  content: Text(
                                      'Are you sure you want to unfavorite this user'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('cancel'),
                                      onPressed: () {
                                        return Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text('Agree'),
                                      isDefaultAction: true,
                                      onPressed: () {
                                        isfavorite == 1
                                            ? isfavorite = 0
                                            : isfavorite = 1;
                                        setState(() {
                                          _changeFavorite(
                                              id: id, favorite: isfavorite);
                                          Navigator.pop(context);
                                        });
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            isfavorite == 1 ? isfavorite = 0 : isfavorite = 1;
                            setState(() {
                              _changeFavorite(id: id, favorite: isfavorite);
                            });
                          }
                        },
                        icon: Icon(
                          isfavorite == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserForm(
                                id: id,
                              ),
                            ),
                          ).then(
                            (value) {
                              setState(() {
                                // print(':::::update::::::');
                              });
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue.shade600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Delete User'),
                                content:
                                    Text('Are you sure you want to delete this '
                                        'user'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('cancel'),
                                    onPressed: () {
                                      return Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('Agree'),
                                    isDefaultAction: true,
                                    onPressed: () {
                                      setState(() {
                                        _deleteUser(id: id);
                                        Navigator.pop(context);
                                      });
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        email,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        phoneNumber,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '$gender,$age years',
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        city,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeFavorite({id, favorite}) async {
    await myDb.toggleFavorite(id, favorite);
  }

  Future<void> _deleteUser({id}) async {
    await myDb.deleteUser(id);
  }

  void _filterUsers(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredUserList = _userList.where((user) {
          String name = user[NAME].toLowerCase();
          String email = user[EMAIL].toLowerCase();
          String phone = user[PHONE].toLowerCase();

          return name.contains(query.toLowerCase()) ||
              email.contains(query.toLowerCase()) ||
              phone.contains(query.toLowerCase());
        }).toList();
      });
    } else {
      setState(() {
        _filteredUserList = List.from(_userList);
      });
    }
  }
}
