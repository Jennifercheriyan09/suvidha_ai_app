import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'discover_schemes.dart';
import 'document_upload_screen.dart';
import 'profile.dart';
import 'login.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<String> _titles = [
    'Dashboard',
    'Discover Schemes',
    'Upload Documents',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

    final List<Widget> _pages = [
      DashboardContent(userName: userName),
      DiscoverSchemesScreen(),
      DocumentUploadScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6C63FF),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  final String userName;

  const DashboardContent({required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back, $userName!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Explore new schemes and track your progress seamlessly.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAnimatedStatisticsCard(
                  title: 'Schemes Explored',
                  endValue: 15,
                  color: Colors.purple,
                ),
                _buildAnimatedStatisticsCard(
                  title: 'Documents Uploaded',
                  endValue: 8,
                  color: Colors.teal,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Recommended for You',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.star, color: Color(0xFF6C63FF)),
                title: Text('PM Kisan Scheme'),
                subtitle: Text('Financial aid for small farmers.'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.star, color: Color(0xFF6C63FF)),
                title: Text('Ayushman Bharat'),
                subtitle: Text('Health insurance for families.'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tips for You',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.lightbulb, color: Colors.orange),
                title: Text('Keep your documents updated!'),
                subtitle: Text('Upload latest documents for best recommendations.'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedStatisticsCard({
    required String title,
    required int endValue,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: endValue),
                duration: Duration(seconds: 2),
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
