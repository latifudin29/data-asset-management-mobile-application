import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditInventoryController extends GetxController {
  // FIELDS FROM TABLES PENETAPAN
  late TextEditingController uraian,
      tahun,
      noRegister,
      tglPerolehan,
      caraPerolehan,
      thBeli,
      asalUsul,
      harga,
      jumlah,
      satuan,
      kondisi,
      masaManfaat,
      nilaiSisa,
      masaSisa,
      penyusutan,
      akumulasi,
      thnNilai,
      noSp2d,
      noId,
      kib,
      keterangan,
      lat,
      long,
      aRtRw,
      aNop,
      aLuasM2,
      aAlamat,
      aHakTanah,
      aSertifikatTgl,
      aSertifikatNo,
      aPenggunaan,
      aKelurahanId,
      aKecamatanId,
      aBatasUtara,
      aBatasSelatan,
      aBatasBarat,
      aBatasTimur,
      aUkuranTgl,
      aUkuranBa,
      aUkuranHasil,
      aUkuranNotes,
      aFisikJenis,
      aFisikTgl,
      aDokJenis,
      aDokNo,
      aDokTgl,
      aDokNotes,
      aDokSimpan,
      aTataRuang,
      aManfaat,
      aManfaatAlamat,
      aManfaatSkNo,
      aManfaatSkTgl,
      aManfaatMulai,
      aManfaatSelesai,
      bMerk,
      bType,
      bCc,
      bBahan,
      bNomorPabrik,
      bNomorRangka,
      bNomorMesin,
      bNomorPolisi,
      bNomorBpkb,
      bUkuran,
      bWarna,
      bThBuat,
      cBertingkatTidak,
      cBetonTidak,
      cLuasLantai,
      cLokasi,
      cDokumenTanggal,
      cDokumenNomor,
      cStatusTanah,
      cKodeTanah,
      cLuasBangunan,
      dKonstruksi,
      dPanjang,
      dLebar,
      dLuas,
      dLokasi,
      dDokumenTanggal,
      dDokumenNomor,
      dStatusTanah,
      dKodeTanah,
      eJudul,
      ePencipta,
      eBahan,
      eSpek,
      eAsal,
      eUkuran,
      eJenis,
      fBertingkatTidak,
      fBetonTidak,
      fPanjang,
      fLebar,
      fLuasLantai,
      fLokasi,
      fDokumenTanggal,
      fDokumenNomor,
      fStatusTanah,
      fKodeTanah,
      fLuasBangunan,
      created,
      updated,
      createUid,
      updateUid,
      status,
      gJenisBarang,
      gKeterangan1,
      gKeterangan2,
      gKeteranagn3,
      perolehanItemId,
      kibId,
      kategoriId,
      departemenId,
      pemilikId,
      bKdRuang,
      fileNm,
      kondisiAudited2019,
      koreksi,
      selisih,
      oldKondisi,
      hargaOld,
      koma,
      dasarSusut,
      perolehan,
      maxManfaat,
      bPemakai,
      bNipPemakai,
      bJabatanPemakai,
      pemecahanId,
      noBast,
      tglBast,
      aManfaatNilaiSewa,
      bTanggalStnk,
      manfaatFileNm,
      manfaatKategoriId,
      manfaatStatusId;

  // FIELDS RESULT JOIN WITH TABLE DEPARTEMEN, KATEGORIS, AND KIB_INVENTARIS

  // FIELDS CUSTOM

  @override
  void onInit() {
    super.onInit();
    uraian = TextEditingController();
    tahun = TextEditingController();
    noRegister = TextEditingController();
    tglPerolehan = TextEditingController();
    caraPerolehan = TextEditingController();
    thBeli = TextEditingController();
    asalUsul = TextEditingController();
    harga = TextEditingController();
    jumlah = TextEditingController();
    satuan = TextEditingController();
    kondisi = TextEditingController();
    masaManfaat = TextEditingController();
    nilaiSisa = TextEditingController();
    masaSisa = TextEditingController();
    penyusutan = TextEditingController();
    akumulasi = TextEditingController();
    thnNilai = TextEditingController();
    noSp2d = TextEditingController();
    noId = TextEditingController();
    kib = TextEditingController();
    keterangan = TextEditingController();
    lat = TextEditingController();
    long = TextEditingController();
    aRtRw = TextEditingController();
    aNop = TextEditingController();
    aLuasM2 = TextEditingController();
    aAlamat = TextEditingController();
    aHakTanah = TextEditingController();
    aSertifikatTgl = TextEditingController();
    aSertifikatNo = TextEditingController();
    aPenggunaan = TextEditingController();
    aKelurahanId = TextEditingController();
    aKecamatanId = TextEditingController();
    aBatasUtara = TextEditingController();
    aBatasSelatan = TextEditingController();
    aBatasBarat = TextEditingController();
    aBatasTimur = TextEditingController();
    aUkuranTgl = TextEditingController();
    aUkuranBa = TextEditingController();
    aUkuranHasil = TextEditingController();
    aUkuranNotes = TextEditingController();
    aFisikJenis = TextEditingController();
    aFisikTgl = TextEditingController();
    aDokJenis = TextEditingController();
    aDokNo = TextEditingController();
    aDokTgl = TextEditingController();
    aDokNotes = TextEditingController();
    aDokSimpan = TextEditingController();
    aTataRuang = TextEditingController();
    aManfaat = TextEditingController();
    aManfaatAlamat = TextEditingController();
    aManfaatSkNo = TextEditingController();
    aManfaatSkTgl = TextEditingController();
    aManfaatMulai = TextEditingController();
    aManfaatSelesai = TextEditingController();
    bMerk = TextEditingController();
    bType = TextEditingController();
    bCc = TextEditingController();
    bBahan = TextEditingController();
    bNomorPabrik = TextEditingController();
    bNomorRangka = TextEditingController();
    bNomorMesin = TextEditingController();
    bNomorPolisi = TextEditingController();
    bNomorBpkb = TextEditingController();
    bUkuran = TextEditingController();
    bWarna = TextEditingController();
    bThBuat = TextEditingController();
    cBertingkatTidak = TextEditingController();
    cBetonTidak = TextEditingController();
    cLuasLantai = TextEditingController();
    cLokasi = TextEditingController();
    cDokumenTanggal = TextEditingController();
    cDokumenNomor = TextEditingController();
    cStatusTanah = TextEditingController();
    cKodeTanah = TextEditingController();
    cLuasBangunan = TextEditingController();
    dKonstruksi = TextEditingController();
    dPanjang = TextEditingController();
    dLebar = TextEditingController();
    dLuas = TextEditingController();
    dLokasi = TextEditingController();
    dDokumenTanggal = TextEditingController();
    dDokumenNomor = TextEditingController();
    dStatusTanah = TextEditingController();
    dKodeTanah = TextEditingController();
    eJudul = TextEditingController();
    ePencipta = TextEditingController();
    eBahan = TextEditingController();
    eSpek = TextEditingController();
    eAsal = TextEditingController();
    eUkuran = TextEditingController();
    eJenis = TextEditingController();
    fBertingkatTidak = TextEditingController();
    fBetonTidak = TextEditingController();
    fPanjang = TextEditingController();
    fLebar = TextEditingController();
    fLuasLantai = TextEditingController();
    fLokasi = TextEditingController();
    fDokumenTanggal = TextEditingController();
    fDokumenNomor = TextEditingController();
    fStatusTanah = TextEditingController();
    fKodeTanah = TextEditingController();
    fLuasBangunan = TextEditingController();
    created = TextEditingController();
    updated = TextEditingController();
    createUid = TextEditingController();
    updateUid = TextEditingController();
    status = TextEditingController();
    gJenisBarang = TextEditingController();
    gKeterangan1 = TextEditingController();
    gKeterangan2 = TextEditingController();
    gKeteranagn3 = TextEditingController();
    perolehanItemId = TextEditingController();
    kibId = TextEditingController();
    kategoriId = TextEditingController();
    departemenId = TextEditingController();
    pemilikId = TextEditingController();
    bKdRuang = TextEditingController();
    fileNm = TextEditingController();
    kondisiAudited2019 = TextEditingController();
    koreksi = TextEditingController();
    selisih = TextEditingController();
    oldKondisi = TextEditingController();
    hargaOld = TextEditingController();
    koma = TextEditingController();
    dasarSusut = TextEditingController();
    perolehan = TextEditingController();
    maxManfaat = TextEditingController();
    bPemakai = TextEditingController();
    bNipPemakai = TextEditingController();
    bJabatanPemakai = TextEditingController();
    pemecahanId = TextEditingController();
    noBast = TextEditingController();
    tglBast = TextEditingController();
    aManfaatNilaiSewa = TextEditingController();
    bTanggalStnk = TextEditingController();
    manfaatFileNm = TextEditingController();
    manfaatKategoriId = TextEditingController();
    manfaatStatusId = TextEditingController();
  }
}

Future<void> getInventarisTanah() async {}
Future<void> getInventarisPeralatanMesin() async {}
Future<void> getInventarisGedungBangunan() async {}
Future<void> getInventarisJalanJaringanIrigasi() async {}
Future<void> getInventarisAsetTetap() async {}
Future<void> getInventarisKDP() async {}
Future<void> getInventarisTgrRbKa() async {}
Future<void> getInventarisAtb() async {}
Future<void> getInventarisBelumTerdaftar() async {}
