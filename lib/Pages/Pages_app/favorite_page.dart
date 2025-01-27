import 'package:flutter/material.dart';
import 'package:submition/utils/temp_date.dart';
import '../../utils/string_const.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List user_List = userList;

  @override
  Widget build(BuildContext context) {
    List favoriteList =
        user_List.where((user) => user[ISFAVORITE] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Users',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: favoriteList.isEmpty
          ? Center(
              child: Text(
                'No favorite users found!',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                return listCard(
                  index,
                  favoriteList[index][NAME],
                  favoriteList[index][EMAIL],
                  favoriteList[index][PHONE],
                  favoriteList[index][GENDER],
                  favoriteList[index][AGE],
                  favoriteList[index][CITY],
                  favoriteList[index][ISFAVORITE],
                );
              },
            ),
    );
  }

  Widget listCard(
    index,
    username,
    email,
    phoneNumber,
    gender,
    age,
    city,
    isFavorite,
  ) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
                      icon: isFavorite
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          user_List[index][ISFAVORITE] =
                              !user_List[index][ISFAVORITE];
                          print(
                              'Favorite Status: ${user_List[index][ISFAVORITE]}');
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Add edit action here
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          user_List.removeAt(index);
                        });
                        print('User Removed: $username');
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Email
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
            // Phone Number
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
            // Gender, Age, City
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
    );
  }
}
