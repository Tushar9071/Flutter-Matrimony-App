import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submition/Pages/Pages_app/user_detail.dart';
import 'package:submition/Pages/Pages_app/user_form.dart';
import 'package:submition/utils/string_const.dart';
import 'package:submition/utils/temp_date.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List user_List = userList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserForm();
                    },
                  ),
                ).then((value) {
                  userList.add(value);
                  setState(() {});
                });
              },
              icon: Icon(Icons.person_add))
        ],
        title: Text(
          'List Of Users',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: user_List.length,
        itemBuilder: (context, index) {
          return listCard(
              index,
              user_List[index][NAME],
              user_List[index][EMAIL],
              user_List[index][PHONE],
              user_List[index][GENDER],
              user_List[index][AGE],
              user_List[index][CITY],
              user_List[index][ISFAVORITE]);
        },
      ),
    );
  }

  Widget listCard(
      index, username, email, phoneNumber, gender, age, city, isfavorite) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return UserDetail(name: user_List[index][NAME],
              email: user_List[index][EMAIL],
              gender: user_List[index][GENDER],
              deb: user_List[index][DOB],
              password: user_List[index][PASSWORD],
              phone: user_List[index][PHONE],
              city: user_List[index][CITY],
              hobbies: user_List[index][HOBBIES],
            age: int.parse(user_List[index][AGE]),);
          },));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: isfavorite
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            user_List[index][ISFAVORITE] =
                                !user_List[index][ISFAVORITE];
                            // print(':::${user_List[index][ISFAVORITE]}:::');
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UserForm(
                                name: user_List[index][NAME],
                                email: user_List[index][EMAIL],
                                gender: user_List[index][GENDER],
                                deb: user_List[index][DOB],
                                password: user_List[index][PASSWORD],
                                phone: user_List[index][PHONE],
                                city: user_List[index][CITY],
                                hobbies: user_List[index][HOBBIES],
                              );
                            },
                          )).then((value){
                            // print(':::$value');
                            user_List[index][NAME] = value[NAME];
                            user_List[index][EMAIL] = value[EMAIL];
                            user_List[index][PASSWORD]  = value[PASSWORD];
                            user_List[index][PHONE] = value[PHONE];
                            user_List[index][GENDER] = value[GENDER];
                            user_List[index][AGE] = value[AGE];
                            user_List[index][CITY] = value[CITY];
                            user_List[index][HOBBIES] = value[HOBBIES];
                            user_List[index][ISFAVORITE] = value[ISFAVORITE];
                            user_List[index][DOB] = value[DOB];
                            setState(() {
        
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Delete User'),
                                content: Text(
                                    'Are you sure you want to delete this user?'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    child: Text('Agree'),
                                    onPressed: () {
                                      user_List.removeAt(index);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '$gender, $age years',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_city, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    city,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
