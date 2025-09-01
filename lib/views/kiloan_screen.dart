import 'package:flutter/material.dart';
import 'package:laundry_app/extension/navigation.dart';
import 'package:laundry_app/views/buat_pesanan.dart';

class KiloanScreen extends StatefulWidget {
  const KiloanScreen({super.key});
  // final bool? appBar;
  static const id = "/kiloanScreen";

  @override
  State<KiloanScreen> createState() => _TugasTujuhState();
}

class _TugasTujuhState extends State<KiloanScreen> {
  final List<String> kategoriList = [
    "Kiloan",
    "Satuan",
    "VIP",
    "Sepatu",
    "Setrika",
    "Express",
  ];
  final Map<String, List<Map<String, dynamic>>> dataKategori = {
    "Kiloan": [
      {
        "nama": "Reguler",
        "lama_waktu": "2-3 hari",
        "harga": "Rp.30000,-",
        "qty": 0,
      },
      {
        "nama": "Hemat",
        "lama_waktu": "3-4 hari",
        "harga": "Rp.25000,-",
        "qty": 0,
      },
      {
        "nama": "Express",
        "lama_waktu": "1 hari",
        "harga": "Rp.50000,-",
        "qty": 0,
      },
    ],
    "Satuan": [
      {
        "nama": "Kaos",
        "gambar": "assets/images/kaos.png",
        "harga": "Rp.5000,-",
        "qty": 0,
      },
      {
        "nama": "Kemeja",
        "gambar": "assets/images/kemeja.png",
        "harga": "Rp.5000,-",
        "qty": 0,
      },
      {
        "nama": "Celana jeans",
        "gambar": "assets/images/celana jeans.png",
        "harga": "Rp.10000,-",
        "qty": 0,
      },
      {
        "nama": "Celana cotton",
        "gambar": "assets/images/celana cotton.png",
        "harga": "Rp.10000,-",
        "qty": 0,
      },
      {
        "nama": "Celana panjang",
        "gambar": "assets/images/celana panjang.png",
        "harga": "Rp.10000,-",
        "qty": 0,
      },
      {
        "nama": "Blazzer",
        "gambar": "assets/images/blazer.png",
        "harga": "Rp.20000,-",
        "qty": 0,
      },
    ],
    "VIP": [
      {
        "nama": "Pakaian formal",
        "gambar": "assets/images/kaos.png",
        "harga": "Rp.50000,-",
        "qty": 0,
      },
      {
        "nama": "Gaun pesta",
        "gambar": "assets/images/kemeja.png",
        "harga": "Rp.100000,-",
        "qty": 0,
      },
      {
        "nama": "Bed cover premium",
        "gambar": "assets/images/celana jeans.png",
        "harga": "Rp.200000,-",
        "qty": 0,
      },
      {
        "nama": "Pakaian berbahan sensitif",
        "gambar": "assets/images/celana cotton.png",
        "harga": "Rp.400000,-",
        "qty": 0,
      },
    ],
    "Sepatu": [
      {
        "nama": "Sneakers",
        "gambar": "assets/images/kaos.png",
        "harga": "Rp.50000,-",
        "qty": 0,
      },
      {
        "nama": "Sepatu kulit",
        "gambar": "assets/images/kemeja.png",
        "harga": "Rp.100000,-",
        "qty": 0,
      },
      {
        "nama": "Sepatu olahraga",
        "gambar": "assets/images/celana jeans.png",
        "harga": "Rp.200000,-",
        "qty": 0,
      },
      {
        "nama": "Sepatu pesta",
        "gambar": "assets/images/celana cotton.png",
        "harga": "Rp.100000,-",
        "qty": 0,
      },
    ],
    "Setrika": [
      {
        "nama": "Reguler",
        "lama_waktu": "2-3 hari",
        "harga": "Rp.30000,-",
        "qty": 0,
      },
      {
        "nama": "Express",
        "lama_waktu": "1 hari",
        "harga": "Rp.50000,-",
        "qty": 0,
      },
      {"nama": "Per Kg", "lama_waktu": "-", "harga": "Rp.30000,-", "qty": 0},
      {
        "nama": "Per Potong",
        "lama_waktu": "-",
        "harga": "Rp.10000,-",
        "qty": 0,
      },
    ],
    "Express": [
      {"lama_waktu": "3 jam", "harga": "Rp.80000,-", "qty": 0},
      {"lama_waktu": "6 jam", "harga": "Rp.60000,-", "qty": 0},
      {"lama_waktu": "12 jam", "harga": "Rp.50000,-", "qty": 0},
    ],
  };
  String? selectedCategory;
  bool showCheckoutBar = false;
  void initState() {
    super.initState();
    selectedCategory = kategoriList[0];
  }

  void decrementQty(int index) {
    setState(() {
      if (dataKategori[selectedCategory]![index]["qty"] > 0) {
        dataKategori[selectedCategory]![index]["qty"]--;
      }
    });
  }

  int get totalHarga {
    int total = 0;
    dataKategori.forEach((key, items) {
      for (var item in items) {
        final hargaString = (item["harga"] as String)
            .replaceAll("Rp.", "")
            .replaceAll(",-", "")
            .replaceAll(".", "");
        final harga = int.tryParse(hargaString) ?? 0;

        total += harga * (item["qty"] as int);
      }
    });
    return total;
  }

  int getTotalItem() {
    int total = 0;
    dataKategori.forEach((_, items) {
      for (var item in items) {
        total += item["qty"] as int;
      }
    });
    return total;
  }

  void checkoutBar() {
    setState(() {
      showCheckoutBar = totalHarga > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 150),
                        child: Text(
                          "Kategori",
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
            ],
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 33,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: kategoriList.length,
              itemBuilder: (context, index) {
                final kategori = kategoriList[index];
                final isSelected = kategori == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.blue : Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Color(0xFF03A9F4)),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = kategori;
                      });
                    },
                    child: Text(
                      kategori,
                      style: TextStyle(
                        fontFamily: "OpenSans_SemiBold",
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: dataKategori[selectedCategory]!.length,
              itemBuilder: (context, index) {
                final item = dataKategori[selectedCategory]![index];

                final nama = item["nama"] ?? "Paket";
                final harga = item["harga"] ?? "-";
                final lamaWaktu = item["lama_waktu"] ?? "";
                final gambar = item["gambar"];
                final qty = item["qty"] as int;

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: gambar != null
                        ? Image.asset(
                            gambar,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.local_laundry_service,
                            size: 40,
                            color: Color(0xFF03A9F4),
                          ),

                    title: Text(
                      nama,
                      style: const TextStyle(
                        fontFamily: "Montserrat_SemiBold",
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      lamaWaktu.isNotEmpty ? "$lamaWaktu\n$harga" : "$harga",
                      style: TextStyle(
                        fontFamily: "OpenSans_Bold",
                        fontSize: 12,
                        color: Color(0xFFFFB74D),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (dataKategori[selectedCategory]![index]["qty"] >
                                  0) {
                                dataKategori[selectedCategory]![index]["qty"]--;
                              }
                            });
                          },
                          icon: Image.asset(
                            "assets/images/minus.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Text(
                          "$qty",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              dataKategori[selectedCategory]![index]["qty"]++;
                            });
                            checkoutBar();
                          },
                          icon: Image.asset(
                            "assets/images/plus.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: showCheckoutBar
          ? Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/item.png",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Lacak pesanan", style: TextStyle(fontFamily: "OpenSans_Regular", fontSize: 14),),
                                Text("${getTotalItem()} Item", style: TextStyle(fontFamily: "Montserrat_SemiBold", fontSize: 16),),
                              ],
                            ),
                            SizedBox(width: 150,),
                            Column(
                              children: [Text("Harga", style: TextStyle(fontFamily: "OpenSans_Regular", fontSize: 14),), Text("$totalHarga", style: TextStyle(fontFamily: "Montserrat_SemiBold", fontSize: 16),)],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 65,
                      width: 365,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(BuatPesanan.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF03A9F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Buat Pesanan",
                          style: TextStyle(color: Colors.white, fontFamily: "Montserrat_SemiBold", fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
