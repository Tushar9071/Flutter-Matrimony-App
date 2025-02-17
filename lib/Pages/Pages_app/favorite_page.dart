import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submition/db/my_db.dart';
import 'package:submition/utils/temp_date.dart';
import '../../utils/string_const.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  MyDb myDb = MyDb();

  Future<List<Map<String, dynamic>>> fetchData() {
    return myDb.getFavoriteUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Users',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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
                );
              },
            );
          } else {
            return Center(
              child: Text('No favorite users found'),
            );
          }
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
      isfavorite}) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {},
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
}
