import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_app/api/kategori.dart';

class TambahKategoriScreen extends StatefulWidget {
  const TambahKategoriScreen({super.key});
  static const id = "/tambahKategori";

  @override
  State<TambahKategoriScreen> createState() => _TambahKategoriScreenState();
}

class _TambahKategoriScreenState extends State<TambahKategoriScreen> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;

  // fungsi pilih gambar
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      print("Path gambar: ${picked.path}");
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  // fungsi simpan kategori
  Future<void> _saveKategori() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama kategori wajib diisi")),
      );
      return;
    }

    try {
      final result = await KategoriAPI.addKategori(
        name: _nameController.text,
        image: _image, // bisa null kalau user tidak pilih gambar
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result["message"] ?? "Kategori berhasil ditambahkan"),
        ),
      );

      Navigator.pop(context, true); // balik ke halaman sebelumnya
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal tambah kategori: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kategori")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nama Kategori"),
            ),
            const SizedBox(height: 16),

            // preview gambar
            _image != null
                ? SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text("Gagal load gambar");
                      },
                    ),
                  )
                : const Text("Belum ada gambar"),

            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pilih Gambar"),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: _saveKategori,
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
