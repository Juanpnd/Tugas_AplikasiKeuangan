import 'dart:html';

void main() {
  List<Map<String, dynamic>> pengeluaranList = [
    {
      'kategori': 'Makanan',
      'jumlah': 50000,
      'tanggal': DateTime.now().subtract(Duration(days: 2))
    },
    {
      'kategori': 'Hiburan',
      'jumlah': 80000,
      'tanggal': DateTime.now().subtract(Duration(days: 10))
    },
    {
      'kategori': 'Transportasi',
      'jumlah': 30000,
      'tanggal': DateTime.now().subtract(Duration(days: 35))
    },
  ];

  String selectedKategori = 'Semua';
  String selectedPeriode = 'Semua';

  void displayPengeluaran(List<Map<String, dynamic>> list) {
    querySelector('#riwayatPengeluaran')?.children.clear();

    for (var item in list) {
      var entry = DivElement()
        ..text =
            '${item['kategori']} - Rp ${item['jumlah']} - ${item['tanggal']}';
      querySelector('#riwayatPengeluaran')?.append(entry);
    }
  }

  void updatePengeluaranList() {
    List<Map<String, dynamic>> filteredList = pengeluaranList;

    if (selectedKategori != 'Semua') {
      filteredList = filteredList
          .where((item) => item['kategori'] == selectedKategori)
          .toList();
    }

    if (selectedPeriode != 'Semua') {
      DateTime now = DateTime.now();
      switch (selectedPeriode) {
        case '1 Minggu Terakhir':
          filteredList = filteredList
              .where((item) =>
                  item['tanggal'].isAfter(now.subtract(Duration(days: 7))))
              .toList();
          break;
        case '1 Bulan Terakhir':
          filteredList = filteredList
              .where((item) =>
                  item['tanggal'].isAfter(now.subtract(Duration(days: 30))))
              .toList();
          break;
        case '3 Bulan Terakhir':
          filteredList = filteredList
              .where((item) =>
                  item['tanggal'].isAfter(now.subtract(Duration(days: 90))))
              .toList();
          break;
      }
    }

    displayPengeluaran(filteredList);
  }

  querySelector('#filterKategori')?.onChange.listen((e) {
    selectedKategori = (e.target as SelectElement).value!;
    updatePengeluaranList();
  });

  querySelector('#filterPeriode')?.onChange.listen((e) {
    selectedPeriode = (e.target as SelectElement).value!;
    updatePengeluaranList();
  });

  displayPengeluaran(pengeluaranList);
}
