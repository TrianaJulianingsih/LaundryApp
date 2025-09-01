import 'package:flutter/material.dart';
import 'package:laundry_app/api/register_user.dart';
import 'package:laundry_app/extension/navigation.dart';
import 'package:laundry_app/models/get_user_model.dart';
import 'package:laundry_app/views/login_api_screen.dart';

class ProfileAPIScreen extends StatefulWidget {
  const ProfileAPIScreen({super.key});
  static const id = "/profileapi";

  @override
  State<ProfileAPIScreen> createState() => _ProfileAPIScreenState();
}

class _ProfileAPIScreenState extends State<ProfileAPIScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  GetUserModel? userData;
  bool isEditing = false;
  bool isLoading = true;
  String? errorMessage = '';
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      print("Loading profile data...");
      final data = await AuthenticationAPI.getProfile();
      print("Profile data loaded: ${data.toJson()}");

      final userDataItem = data.data?.isNotEmpty == true ? data.data![0] : null;

      setState(() {
        userData = data;
        _nameController.text = userDataItem?.name ?? '';
        _emailController.text = userDataItem?.email ?? '';
        isLoading = false;
      });
    } catch (e) {
      print("Error loading profile: $e");
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal memuat profil: $e")));
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final updateData = await AuthenticationAPI.updateUser(
        name: _nameController.text,
        email: _emailController.text,
      );
      setState(() {
        userData = updateData;
        isEditing = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //   color: Color.fromARGB(141, 177, 175, 175)
                      // )
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //   color: Color.fromARGB(141, 177, 175, 175)
                      // )
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                updateProfile();
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: showEditDialog,
            tooltip: "Edit Profile",
          ),
        ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  foregroundImage: AssetImage("assets/images/jiso.jpg"),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 20,
                      bottom: 28,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          size: 40,
                          color: Color(0xFF0D47A1),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Nama: ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          userData?.data?.isNotEmpty == true
                              ? userData!.data![0].name ?? 'Tidak tersedia'
                              : 'Tidak tersedia',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Divider(indent: 20, endIndent: 20, color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      bottom: 30,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_rounded,
                          size: 40,
                          color: Color(0xFF0D47A1),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Email: ",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          userData?.data?.isNotEmpty == true
                              ? userData!.data![0].email ?? 'Tidak tersedia'
                              : 'Tidak tersedia',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     context.pushReplacement(LoginScreen());
            //   },
            //   child: Text("Logout"),
            // ),
            FloatingActionButton(
              onPressed: () {
                context.pushReplacement(LoginScreen());
              },
              child: Image.asset("name"),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: ButtomNav(),
    );
  }
}
