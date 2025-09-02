import 'package:flutter/material.dart';
import 'package:laundry_app/api/kategori.dart';
import 'package:laundry_app/extension/navigation.dart';
import 'package:laundry_app/models/kategori.dart';
import 'package:laundry_app/views/add_layanan_screen.dart';
import 'package:laundry_app/views/kiloan_screen.dart';
import 'package:laundry_app/views/satuan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  // final bool? appBar;
  static const id = "/homeScreen";

  @override
  State<HomeScreen> createState() => _TugasTujuhState();
}

class _TugasTujuhState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _namaController = TextEditingController();

  Future<void> showTambahKategoriDialog(
    BuildContext context,
    Function onSukses,
  ) async {
    final TextEditingController _controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Kategori"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Nama Kategori",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  try {
                    await KategoriAPI.addKategori(name: _controller.text);
                    Navigator.pop(context); 
                    onSukses(); 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Kategori berhasil ditambahkan")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal menambah kategori: $e")),
                    );
                  }
                }
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showHapusKategoriDialog(
    BuildContext context,
    int id,
    Function onSukses,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hapus Kategori"),
          content: Text("Apakah kamu yakin ingin menghapus kategori ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                try {
                  await KategoriAPI.hapusKategori(id);
                  Navigator.pop(context); 
                  onSukses(); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Kategori berhasil dihapus")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal menghapus kategori: $e")),
                  );
                }
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color(0xFF03A9F4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Selamat datang,",
                              style: TextStyle(
                                fontFamily: "Montserrat_Regular",
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 150),
                            Icon(Icons.search, color: Colors.white),
                            // SizedBox(width: 5,),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                "assets/images/shopping-cart.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Triana",
                          style: TextStyle(
                            fontFamily: "Montserrat_Bold",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 105),
                    child: Container(
                      height: 169,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(4, 4),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                      ),
                                      child: Text(
                                        "Lacak pesanan",
                                        style: TextStyle(
                                          fontFamily: "OpenSans_Regular",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        left: 20,
                                      ),
                                      child: Text(
                                        "Anda memiliki 2 laundry aktif",
                                        style: TextStyle(
                                          fontFamily: "Montserrat_Bold",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  right: 30,
                                ),
                                child: Image.asset(
                                  "assets/images/Jacuzzi.png",
                                  height: 73,
                                  width: 73,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Lihat semua",
                                style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF0D47A1),
                                  decorationThickness: 2,
                                  color: Color(0xFF0D47A1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kategori",
                    style: TextStyle(
                      fontFamily: "Montserrat_Bold",
                      fontSize: 16,
                    ),
                  ),
                  FutureBuilder<KategoriModel>(
                    future: KategoriAPI.getKategori(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Gagal memuat kategori");
                      } else if (!snapshot.hasData ||
                          snapshot.data!.data!.isEmpty) {
                        return Text("Kategori kosong");
                      }

                      final kategoriList = snapshot.data!.data!;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount:
                            kategoriList.length + 1, 
                        itemBuilder: (context, index) {
                          if (index == kategoriList.length) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showTambahKategoriDialog(context, () {
                                      setState(() {}); 
                                    });
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 32,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text("Tambah", style: TextStyle(fontSize: 11)),
                              ],
                            );
                          }

                          final kategori = kategoriList[index];
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (kategori.name == "Laundry Satuan") {
                                        context.pushNamed(KiloanScreen.id);
                                      } else if (kategori.name ==
                                          "Dry Cleaning") {
                                        context.pushNamed(SatuanScreen.id);
                                      }
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xFF03A9F4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          kategori.name ?? "NULL",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -5,
                                    top: -5,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showHapusKategoriDialog(
                                          context,
                                          kategori.id!,
                                          () {
                                            setState(
                                              () {},
                                            ); 
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                kategori.name ?? "NULL",
                                style: TextStyle(fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: 30),
                  Text(
                    "Riwayat",
                    style: TextStyle(
                      fontFamily: "Montserrat_Bold",
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 77,
                    width: 355,
                    decoration: BoxDecoration(
                      color: Color(0xFF03A9F4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Image.asset(
                            "assets/images/washer.png",
                            height: 44,
                            width: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Kiloan",
                                style: TextStyle(
                                  fontFamily: "Montserrat_SemiBold",
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Jemput",
                                style: TextStyle(
                                  fontFamily: "OpenSans_Regular",
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: Container(
                            height: 22,
                            width: 73,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFB74D),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Proses",
                                style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 77,
                    width: 355,
                    decoration: BoxDecoration(
                      color: Color(0xFF03A9F4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Image.asset(
                            "assets/images/washer.png",
                            height: 44,
                            width: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Kiloan",
                                style: TextStyle(
                                  fontFamily: "Montserrat_SemiBold",
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Jemput",
                                style: TextStyle(
                                  fontFamily: "OpenSans_Regular",
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: Container(
                            height: 22,
                            width: 73,
                            decoration: BoxDecoration(
                              color: Color(0xFF0D47A1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Selesai",
                                style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 77,
                    width: 355,
                    decoration: BoxDecoration(
                      color: Color(0xFF03A9F4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Image.asset(
                            "assets/images/washer.png",
                            height: 44,
                            width: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Kiloan",
                                style: TextStyle(
                                  fontFamily: "Montserrat_SemiBold",
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Jemput",
                                style: TextStyle(
                                  fontFamily: "OpenSans_Regular",
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: Container(
                            height: 22,
                            width: 73,
                            decoration: BoxDecoration(
                              color: Color(0xFF0D47A1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Selesai",
                                style: TextStyle(
                                  fontFamily: "Baloo",
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
