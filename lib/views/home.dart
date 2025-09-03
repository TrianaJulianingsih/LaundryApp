import 'package:flutter/material.dart';
import 'package:laundry_app/api/kategori.dart';
import 'package:laundry_app/extension/navigation.dart';
import 'package:laundry_app/models/kategori.dart';
import 'package:laundry_app/views/dry_cleaning.dart';
import 'package:laundry_app/views/laundry_satuan.dart';
import 'package:laundry_app/views/tambah_kategori.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  // final bool? appBar;
  static const id = "/homeScreen";

  @override
  State<HomeScreen> createState() => _TugasTujuhState();
}

class _TugasTujuhState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _refreshKey = UniqueKey();
  Future<KategoriModel>? _kategoriFuture;
  // final TextEditingController _namaController = TextEditingController();
  void initState() {
    super.initState();
    _loadKategori();
  }

  void _loadKategori() {
    setState(() {
      _kategoriFuture = KategoriAPI.getKategori();
    });
  }

  Future<void> showTambahKategoriDialog(
    BuildContext context,
    Function onSukses,
  ) async {
    final TextEditingController controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Kategori"),
          content: TextField(
            controller: controller,
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
                if (controller.text.isNotEmpty) {
                  try {
                    await KategoriAPI.addKategori(name: controller.text);
                    Navigator.pop(context);
                    _loadKategori();
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
    VoidCallback onKategoriDeleted,
  ) async {
    return showDialog(
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
            TextButton(
              onPressed: () async {
                try {
                  await KategoriAPI.hapusKategori(id);
                  Navigator.pop(context);
                  onKategoriDeleted();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              },
              child: Text("Hapus", style: TextStyle(color: Colors.red)),
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
                        padding: const EdgeInsets.only(top: 30),
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
                            SizedBox(width: 170),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.search, color: Colors.white),
                              ),
                            ),

                            // SizedBox(width: 5,),
                          ],
                        ),
                      ),
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
                    future: _kategoriFuture,
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
                        itemCount: kategoriList.length + 2,
                        itemBuilder: (context, index) {
                          if (index == kategoriList.length) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final result = await Navigator.pushNamed(
                                      context,
                                      TambahKategoriScreen.id,
                                    );
                                    if (result == true) {
                                      _loadKategori(); // refresh kategori setelah tambah
                                    }
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFF03A9F4),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 32,
                                      color: Color(0xFF03A9F4),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Tambah",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            );
                          } else if (index == kategoriList.length + 1) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (kategoriList.isNotEmpty) {
                                      final selected = await showDialog<int>(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            title: Text(
                                              "Pilih kategori yang akan dihapus",
                                            ),
                                            children: kategoriList.map((
                                              kategori,
                                            ) {
                                              return SimpleDialogOption(
                                                onPressed: () {
                                                  Navigator.pop(
                                                    context,
                                                    kategori.id,
                                                  );
                                                },
                                                child: Text(
                                                  kategori.name ?? "Tanpa Nama",
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        },
                                      );

                                      if (selected != null) {
                                        await showHapusKategoriDialog(
                                          context,
                                          selected,
                                          () {
                                            setState(() {});
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFF03A9F4),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      size: 32,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text("Hapus", style: TextStyle(fontSize: 11)),
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child:
                                            kategori.imageUrl != null &&
                                                kategori.imageUrl!.isNotEmpty
                                            ? Image.network(
                                                kategori.imageUrl!,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons.image_not_supported,
                                                      color: Colors.grey,
                                                    ),
                                              )
                                            : Icon(
                                                Icons.image,
                                                size: 30,
                                                color: Colors.grey,
                                              ),
                                      ),
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
                    width: 375,
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
