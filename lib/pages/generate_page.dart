import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  String? qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Barcode'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Barang',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    controller: tanggalController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Beli',
                      hintText: 'contoh: 10-02-2024',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    controller: lokasiController,
                    decoration: const InputDecoration(
                      labelText: 'Lokasi Barang',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (namaController.text.isEmpty ||
                            tanggalController.text.isEmpty ||
                            lokasiController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Semua data wajib diisi'),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          qrData = '''
      ASSAF SCAN
      Nama Barang : ${namaController.text}
      Tanggal Beli: ${tanggalController.text}
      Lokasi      : ${lokasiController.text}
      Status      : Milik Yayasan Assalafiyyah
      ''';
                        });
                      },
                      child: const Text('Generate QR Code'),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (qrData != null)
                    Column(
                      children: [
                        BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: qrData!,
                          width: 220,
                          height: 220,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'QR Code Inventaris',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
