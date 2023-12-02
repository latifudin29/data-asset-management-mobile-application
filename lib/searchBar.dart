// ----------------------------- BARANG --------------------------------

// DropdownSearch<String>(
//   popupProps: PopupProps.menu(
//     showSelectedItems: true,
//     showSearchBox: true,
//   ),
//   items: kategoriController.kategoriList
//     .map<String>((Map<String, dynamic> item) {
//       return item['kode'] + ' - ' + item['nama'];
//     })
//     .toList(),
//   dropdownDecoratorProps: DropDownDecoratorProps(
//     dropdownSearchDecoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//   ),
//   onChanged: (String? newValue) {
//     if (newValue != null) {
//       List<String> values = newValue.split(' - ');
//       String kode = values[0];
//       String nama = values[1];

//       String id = kategoriController.kategoriList
//           .firstWhere((item) => item['kode'] == kode && item['nama'] == nama)['id']
//           .toString();

//       setState(() {
//         invA.selectedKategori = id;
//         print(invA.selectedKategori);
//       });
//     }
//   },
//   selectedItem: invA.selectedKategori != ""
//     ? kategoriController.kategoriList
//         .where((item) => item['id'].toString() == invA.selectedKategori)
//         .map((item) => item['kode'] + ' - ' + item['nama'])
//         .first
//     : kategoriController.kategoriList.isNotEmpty
//         ? kategoriController.kategoriList[0]['kode'] +
//             ' - ' +
//             kategoriController.kategoriList[0]['nama']
//         : "Pilih kategori",
//   dropdownBuilder: (context, selectedItem) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5),
//       child: Text(selectedItem.toString(), style: TextStyle(fontSize: 16)),
//     );
//   },
// )

// ----------------------------- SATUAN --------------------------------

// DropdownSearch<String>(
//   popupProps: PopupProps.menu(
//     showSelectedItems: true,
//     showSearchBox: true,
//   ),
//   items: [
//     "Pilih satuan",
//     ...satuanController.satuanList.map<String>((Map<String, dynamic> item) {
//       return item['satuan_nm'].toString();
//     }).toList(),
//   ],
//   dropdownDecoratorProps: DropDownDecoratorProps(
//     dropdownSearchDecoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//   ),
//   onChanged: (String? newValue) {
//     setState(() {
//       invA.selectedSatuan = newValue ?? invA.selectedSatuan;
//     });
//   },
//   selectedItem: invA.selectedSatuan != "" ? invA.selectedSatuan : "Pilih satuan",
//   dropdownBuilder: (context, selectedItem) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5),
//       child: Text(selectedItem.toString(), style: TextStyle(fontSize: 16)),
//     );
//   },
// ),

// ----------------------------- KIR --------------------------------

// DropdownSearch<String>(
//   popupProps: PopupProps.menu(
//     showSelectedItems: true,
//     showSearchBox: true,
//   ),
//   items: ruangController.ruangList
//       .map<String>((Map<String, dynamic> item) {
//         return item['ruang_nm'];
//       })
//       .toList(),
//   dropdownDecoratorProps: DropDownDecoratorProps(
//     dropdownSearchDecoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//   ),
//   onChanged: (String? newValue) {
//     setState(() {
//       invB.selectedKartuRuangan = newValue ?? invB.selectedKartuRuangan;
//     });
//   },
//   selectedItem: invB.selectedKartuRuangan != ""
//       ? invB.selectedKartuRuangan
//       : ruangController.ruangList.isNotEmpty
//           ? ruangController.ruangList[0]['ruang_nm']
//           : "Pilih ruangan",
//   dropdownBuilder: (context, selectedItem) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5),
//       child: Text(selectedItem.toString(), style: TextStyle(fontSize: 16)),
//     );
//   },
// )