import 'package:flutter/material.dart';
import 'package:laundry_app/api/kategori.dart';
import 'package:laundry_app/models/kategori.dart';
import 'package:laundry_app/views/item_screen.dart';

class KategoriDetailScreen extends StatelessWidget {
  final Data kategori;
  static const id = "/kategoriDetail";

  const KategoriDetailScreen({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 86,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color(0xFF03A9F4),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 115),
                    child: Text(
                      kategori.name ?? "Detail Kategori",
                      style: TextStyle(
                        fontFamily: "Montserrat_Bold",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder<KategoriModel>(
            future: KategoriAPI.getKategori(),
            builder:
                (BuildContext context, AsyncSnapshot<KategoriModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final kategori = snapshot.data!;

                    return SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: kategori.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final dataKategori = kategori;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsByCategoryScreen(
                                    selectedCategoryId: 0,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.shade100,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),

                              child: Center(
                                child: Text(
                                  kategori.data?[index].name ?? "NULL",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text("Gagal Memuat data");
                  }
                },
          ),
          SizedBox(height: 8),
          Text("ID Kategori: ${kategori.id}"),
        ],
      ),
    );
  }
}
