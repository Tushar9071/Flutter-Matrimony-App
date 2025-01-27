import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("About Us",style: TextStyle(color: Colors.white),),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/'),
                  radius: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  "Typing Tutor",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildKeyValueRow(
                        "Developed by",
                        "Tushar Rajpara "
                            "(23031701044)"),
                    _buildKeyValueRow(
                      "Mentored by",
                      "Prof. Mehul Bhundiya (Computer Engineering Department), "
                          "School of Computer Science",
                    ),
                    _buildKeyValueRow(
                      "Explored by",
                      "ASWDC, School of Computer Science",
                    ),
                    _buildKeyValueRow(
                      "Eulogized by",
                      "Darshan University, Rajkot, Gujarat - INDIA",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),


            Text(
              "About ASWDC",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/darshan_uni.png',
                      height: 60,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "ASWDC is Application, Software, and Website Development Center @ Darshan University run by Students and Staff of School of Computer Science.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sole purpose of ASWDC is to bridge gap between university curriculum & industry demands. Students learn cutting edge technologies, develop real-world applications & experience professional environments @ ASWDC under guidance of industry experts & faculty members.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildContactRow(Icons.email, "aswdc@darshan.ac.in"),
                    _buildContactRow(Icons.phone, "+91-9727747317"),
                    _buildContactRow(Icons.language, "www.darshan.ac.in"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFooterIcon(Icons.share, "Share App"),
                _buildFooterIcon(Icons.apps, "More Apps"),
                _buildFooterIcon(Icons.star, "Rate Us"),
                _buildFooterIcon(Icons.thumb_up, "Like us on Facebook"),
                _buildFooterIcon(Icons.update, "Check for Update"),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "© 2025 Darshan University\nAll Rights Reserved - Privacy Policy\nMade with ❤️ in India",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyValueRow(String keyText, String valueText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$keyText: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(valueText)),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
