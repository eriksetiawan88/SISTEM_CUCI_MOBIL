//SISTEM CUCI MOBIL
import 'dart:io';

void main() {
  bool jalan = true;

  // Representasi Pos Cuci Mobil (menyimpan plat nomor atau null jika kosong)
  Map<String, String?> posA = {'plat': null};
  Map<String, String?> posB = {'plat': null};
  Map<String, String?> posC = {'plat': null};

  // List untuk menampung antrean mobil (Waiting List)
  List<String> waitingList = [];

  void tampilMenu() {
    print('\n========================================');
    print('             WASH & CLEAN               ');
    print('========================================');
    print('1. Tambah Waiting List / Masuk Mobil');
    print('2. Lihat Waiting List');
    print('3. Lihat Pos');
    print('4. Selesaikan Pos');
    print('5. Keluar dari aplikasi');
    print('========================================');
    stdout.write('Pilih menu (1-5): ');
  }

  void tambahList() {
    stdout.write('Masukkan Plat Nomor Kendaraan: ');
    String? plat = stdin.readLineSync();

    if (plat == null || plat.trim().isEmpty) {
      print('Plat nomor tidak boleh kosong!');
      return;
    }

    plat = plat.toUpperCase();

    // Logika pengisian pos: Jika A kosong -> B kosong -> C kosong, langsung masuk pos.
    // Selain itu, masuk ke waiting list.
    if (posA['plat'] == null) {
      posA['plat'] = plat;
      print('-> Mobil dengan plat $plat langsung masuk ke Pos A.');
    } else if (posB['plat'] == null) {
      posB['plat'] = plat;
      print('-> Mobil dengan plat $plat langsung masuk ke Pos B.');
    } else if (posC['plat'] == null) {
      posC['plat'] = plat;
      print('-> Mobil dengan plat $plat langsung masuk ke Pos C.');
    } else {
      waitingList.add(plat);
      print('-> Semua pos penuh! Mobil dengan plat $plat masuk ke Waiting List (Antrean ke-${waitingList.length}).');
    }
  }

  void lihatList() {
    print('\n--- DAFTAR WAITING LIST ---');
    if (waitingList.isEmpty) {
      print('Waiting list saat ini kosong.');
    } else {
      for (int i = 0; i < waitingList.length; i++) {
        print('${i + 1}. Plat: ${waitingList[i]}');
      }
    }
  }

  void lihatPos() {
    print('\n--- STATUS POS CUCI ---');
    print('Pos A : ${posA['plat'] ?? 'Kosong'}');
    print('Pos B : ${posB['plat'] ?? 'Kosong'}');
    print('Pos C : ${posC['plat'] ?? 'Kosong'}');
  }

  void selesaikanPos() {
    lihatPos();
    stdout.write('Pilih pos yang ingin diselesaikan (A/B/C): ');
    String? pilihanPos = stdin.readLineSync()?.toUpperCase();

    Map<String, String?> targetPos;

    if (pilihanPos == 'A') {
      targetPos = posA;
    } else if (pilihanPos == 'B') {
      targetPos = posB;
    } else if (pilihanPos == 'C') {
      targetPos = posC;
    } else {
      print('Pilihan pos tidak valid!');
      return;
    }

    // Cek apakah pos yang dipilih ada mobilnya
    if (targetPos['plat'] == null) {
      print('Pos $pilihanPos saat ini sedang kosong.');
      return;
    }

    String? mobilSelesai = targetPos['plat'];
    print('-> Mobil dengan plat $mobilSelesai di Pos $pilihanPos telah selesai dicuci.');

    // Kosongkan pos, lalu cek apakah ada antrean di waiting list
    if (waitingList.isNotEmpty) {
      // Ambil mobil pertama dari waiting list (FIFO: First In, First Out)
      String mobilBaru = waitingList.removeAt(0);
      targetPos['plat'] = mobilBaru;
      print('-> Mobil dari waiting list dengan plat $mobilBaru dipindahkan ke Pos $pilihanPos.');
    } else {
      targetPos['plat'] = null;
      print('-> Pos $pilihanPos sekarang kosong.');
    }
  }

  void keluarApp() {
    print('Terima kasih telah menggunakan aplikasi Wash & Clean!');
    jalan = false;
  }

  // Loop utama aplikasi
  while (jalan) {
    tampilMenu();
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        tambahList();
        break;
      case '2':
        lihatList();
        break;
      case '3':
        lihatPos();
        break;
      case '4':
        selesaikanPos();
        break;
      case '5':
        keluarApp();
        break;
      default:
        print('Pilihan tidak valid. Silakan masukkan angka 1-5.');
    }
  }
}