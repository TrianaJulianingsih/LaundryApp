// views/items_by_category.dart
import 'package:flutter/material.dart';
import 'package:laundry_app/api/kategori.dart';
import 'package:laundry_app/api/order.dart';
import 'package:laundry_app/models/item_model.dart';
import 'package:laundry_app/models/kategori.dart' hide Data;

class ItemsByCategoryScreen extends StatefulWidget {
  final int selectedCategoryId;

  const ItemsByCategoryScreen({super.key, required this.selectedCategoryId});
  static const id = "/itemsByCategory";

  @override
  State<ItemsByCategoryScreen> createState() => _ItemsByCategoryScreenState();
}

class _ItemsByCategoryScreenState extends State<ItemsByCategoryScreen> {
  Future<ItemModel>? _layananFuture;
  Future<KategoriModel>? _kategoriFuture;
  int _selectedCategoryId = 0;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.selectedCategoryId;
    _loadData();
  }

  void _loadData() {
    setState(() {
      _kategoriFuture = KategoriAPI.getKategori();

      if (_selectedCategoryId == 0) {
        // Jika kategori "Semua" dipilih, ambil semua items
        _layananFuture = LayananAPI.getAllLayanan();
      } else {
        // Ambil items berdasarkan kategori tertentu
        _layananFuture = LayananAPI.getLayananByCategory(_selectedCategoryId);
      }
    });
  }

  void _changeCategory(int categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Layanan"),
        backgroundColor: const Color(0xFF03A9F4),
      ),
      body: Column(
        children: [
          FutureBuilder<KategoriModel>(
            future: _kategoriFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 60,
                  child: Center(child: Text("Error: ${snapshot.error}")),
                );
              } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                return const SizedBox(
                  height: 60,
                  child: Center(child: Text("Tidak ada kategori")),
                );
              }

              final kategoriList = snapshot.data!.data!;

              return SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Tombol "Semua"
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => _changeCategory(0),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedCategoryId == 0
                              ? Colors.blue[700]
                              : Colors.blue[400],
                        ),
                        child: const Text("Semua"),
                      ),
                    ),
                    ...kategoriList.map((kategori) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _changeCategory(kategori.id!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedCategoryId == kategori.id
                                ? Colors.blue[700]
                                : Colors.blue[400],
                          ),
                          child: Text(kategori.name ?? "Unnamed"),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),

          const Divider(),

          // Bagian untuk menampilkan items berdasarkan kategori yang dipilih
          Expanded(
            child: FutureBuilder<ItemModel>(
              future: _layananFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.data == null) {
                  return const Center(
                    child: Text("Tidak ada layanan tersedia"),
                  );
                }

                final layananList = snapshot.data!.data!;

                return ListView.builder(
                  itemCount: layananList.length,
                  itemBuilder: (context, index) {
                    final layanan = layananList[index];

                    return ListTile(
                      title: Text(
                        layanan.name ?? "Unnamed",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Harga: Rp ${layanan.price}"),
                          Text("ID Kategori: ${layanan.categoryId}"),
                          Text("Tipe Service: ${layanan.serviceTypeId}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          _addToOrder(layanan);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addToOrder(Data layanan) {
    // Implementasi untuk menambahkan item ke pesanan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${layanan.name} ditambahkan ke pesanan")),
    );

    // Di sini Anda bisa menyimpan data ke state management atau langsung ke API
  }
}
