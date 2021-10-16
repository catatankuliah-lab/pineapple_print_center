import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pineapple Print and Copy Center',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int hargaWarna = 250;
  TextEditingController dataHitamPutih = TextEditingController();
  TextEditingController dataBerwarna = TextEditingController();
  TextEditingController dataJumlahBayar = TextEditingController();
  TextEditingController dataJumlahUang = TextEditingController();
  TextEditingController dataJumlahKembalian = TextEditingController();

  int qtyHitamPutih = 0;
  int qtyWarna = 0;
  int jumlahBayar = 0;
  int jumlahUang = 0;
  int jumlahKembalian = 0;

  void clearAll() {
    dataHitamPutih.text = "";
    dataBerwarna.text = "";
    dataJumlahBayar.text = "";
    dataJumlahUang.text = "";
    dataJumlahKembalian.text = "";
  }

  void clearOutput() {
    dataJumlahBayar.text = "";
    dataJumlahUang.text = "";
    dataJumlahKembalian.text = "";
  }

  void clearKembalian() {
    dataJumlahKembalian.text = "";
  }

  void getJumlahTransaksi() {
    setState(() {
      if (dataHitamPutih.text != "" && dataBerwarna.text != "") {
        qtyHitamPutih = int.parse(dataHitamPutih.text);
        qtyWarna = int.parse(dataBerwarna.text);
      } else if (dataHitamPutih.text == "") {
        qtyHitamPutih = 0;
        qtyWarna = int.parse(dataBerwarna.text);
      } else if (dataBerwarna.text == "") {
        qtyWarna = 0;
        qtyHitamPutih = int.parse(dataHitamPutih.text);
      }
      jumlahBayar = (qtyHitamPutih * 100) + (qtyWarna * hargaWarna);
      dataJumlahBayar.text = jumlahBayar.toString();
      dataJumlahKembalian.text = "";
    });
  }

  void getJumlahKembalian() {
    setState(() {
      if (dataJumlahBayar.text != "" && dataJumlahUang.text != "") {
        jumlahBayar = int.parse(dataJumlahBayar.text);
        jumlahUang = int.parse(dataJumlahUang.text);
        jumlahKembalian = jumlahUang - jumlahBayar;
        if (jumlahKembalian >= 0) {
          dataJumlahKembalian.text = jumlahKembalian.toString();
        } else {
          dataJumlahKembalian.text = "";
        }
      }
    });
  }

  void getJenis() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pineapple Print and Copy Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: const ["Print", "Fotocopy"],
                // ignore: deprecated_member_use
                label: "Jenis Layanan",
                onChanged: (val) {
                  clearAll();
                  if (val == "Fotocopy") {
                    hargaWarna = 0;
                  } else {
                    hargaWarna = 250;
                  }
                },
                selectedItem: "Print",
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataHitamPutih,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: "Input Jumlah Hitam Putih (Lembar)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (clr) {
                  clearOutput();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataBerwarna,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: "Input Jumlah Berwarna (Lembar)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (clr) {
                  clearOutput();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: getJumlahTransaksi,
                child: const Text(
                  "Hitung Jumlah Bayar",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: const Size(double.maxFinite, 55),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataJumlahBayar,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Total Bayar (Rp.)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataJumlahUang,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: "Input Jumlah Uang (Rp.)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (clr) {
                  clearKembalian();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataJumlahKembalian,
                decoration: const InputDecoration(
                  labelText: "Jumlah Kembalian (Rp.)",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: getJumlahKembalian,
                child: const Text(
                  "Hitung Jumlah Kembalian",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: const Size(double.maxFinite, 55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
