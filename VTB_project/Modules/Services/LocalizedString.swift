//
//  Localization.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 13.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

struct LocalizedString {
    
    //    MARK: - Properties
    
    private var currentLanguage: Language
    
    //    MARK: - Init
    
    init() {
        currentLanguage = SettingsStore.shared.getNativeLanguage()
    }
    
    //    MARK: - Tab bar items
    
    var collection: String {
        return _collection[currentLanguage] ?? ""
    }
    
    var favorite: String {
        return _favorite[currentLanguage] ?? ""
    }
    
    var add: String {
        return _add[currentLanguage] ?? ""
    }
    
    var settings: String {
        return _settings[currentLanguage] ?? ""
    }
    
    //    MARK: - Buttons
    
    var cameraButton: String {
        return _cameraButton[currentLanguage] ?? ""
    }
    
    var galeryButton: String {
        return _galeryButton[currentLanguage] ?? ""
    }
    
    var backButton: String {
        return _backButton[currentLanguage] ?? ""
    }
    
    //    MARK: - Settings list
    
    func getSettingsString(settings: SettingsList)->String {
        switch settings {
        case .mainLanguage:
            return _mainLanguage[currentLanguage] ?? ""
        case .foreignLanguage:
            return _foreignLanguage[currentLanguage] ?? ""
        case .deleteData:
            return _deleteData[currentLanguage] ?? ""
        }
    }
    
    //    MARK: - Remember game
    
    var remember: String {
        return _remember[currentLanguage] ?? ""
    }
    
    //    MARK: - Alert
    
    var emptyObjectAlertTitle: String {
        return _emptyObjectAlertTitle[currentLanguage] ?? ""
    }
    
    var alertMessage: String {
        return _alertMessage[currentLanguage] ?? ""
    }
    
    var alertCancelTitle: String {
        return _alertCancelTitle[currentLanguage] ?? ""
    }
    
    //    MARK: - Other
    
    var image: String {
        return _image[currentLanguage] ?? ""
    }
    
    //    MARK: - Tab bar items (private)
    
    private let _collection: [Language:String] = [
        .en : "Collection",
        .ru : "Коллекция",
        .es : "Colección",
        .fr : "Collection",
        .pt : "Coleção",
        .it : "Collezione",
        .de : "Sammlung",
        .nl : "Kollektion",
        .ja : "コレクション",
        .ko : "수집",
        .vi : "Bộ sưu tập",
        .sv : "Samling",
        .da : "Kollektion",
        .fi : "Kokoelma",
        .nb : "Samling",
        .tr : "Toplamak",
        .el : "Συλλογή",
        .id : "Koleksi",
        .ms : "Koleksi",
        .th : "ชุด",
        .hi : "संग्रह",
        .hu : "Gyűjtemény",
        .pl : "Kolekcja",
        .cs : "Sbírka",
        .sk : "zbierka",
        .uk : "Колекція",
        .ca : "Col·lecció",
        .ro : "Colectie",
        .hr : "Kolekcija"
    ]
    
    private let _favorite: [Language:String] = [
        .en : "Favorite",
        .ru : "Избранное",
        .es : "Favorito",
        .fr : "Préféré",
        .pt : "Favorito",
        .it : "Preferito",
        .de : "Lieblings",
        .nl : "Favorit",
        .ja : "お気に入り",
        .ko : "인기 있는 말",
        .vi : "Yêu thích",
        .sv : "Favorit",
        .da : "Favorit",
        .fi : "Suosikki",
        .nb : "Favoritt",
        .tr : "Favori",
        .el : "Αγαπημένη",
        .id : "Favorit",
        .ms : "Kegemaran",
        .th : "ที่ชื่นชอบ",
        .hi : "पसंदीदा",
        .hu : "Kedvenc",
        .pl : "Ulubiony",
        .cs : "Oblíbený",
        .sk : "najobľúbenejšie",
        .uk : "Улюблений",
        .ca : "Favorit",
        .ro : "Favorită",
        .hr : "ljubimac"
    ]
    
    private let _add: [Language:String] = [
        .en : "Add",
        .ru : "Добавить",
        .es : "Añadir",
        .fr : "Ajouter",
        .pt : "Adicionar",
        .it : "Inserisci",
        .de : "Hinzufügen",
        .nl : "Tilføje",
        .ja : "追加",
        .ko : "더하다",
        .vi : "Thêm vào",
        .sv : "Lägg till",
        .da : "Tilføje",
        .fi : "Lisätä",
        .nb : "Legg til",
        .tr : "Ekle",
        .el : "Προσθήκη",
        .id : "Menambahkan",
        .ms : "Tambah",
        .th : "เพิ่ม",
        .hi : "जोड़ना",
        .hu : "hozzáad",
        .pl : "Dodaj",
        .cs : "Přidat",
        .sk : "Pridať",
        .uk : "Додайте",
        .ca : "Afegiu",
        .ro : "Adăuga",
        .hr : "Dodati"
    ]
    
    private let _settings: [Language:String] = [
        .en : "Settings",
        .ru : "Настройки",
        .es : "Favorito",
        .fr : "Paramètres",
        .pt : "Configurações",
        .it : "Impostazioni",
        .de : "die Einstellungen",
        .nl : "Indstillinger",
        .ja : "設定",
        .ko : "설정",
        .vi : "Cài đặt",
        .sv : "Inställningar",
        .da : "Indstillinger",
        .fi : "asetukset",
        .nb : "innstillinger",
        .tr : "Ayarlar",
        .el : "Ρυθμίσεις",
        .id : "Pengaturan",
        .ms : "Tetapan",
        .th : "การตั้งค่า",
        .hi : "समायोजन",
        .hu : "Beállítások",
        .pl : "Ustawienia",
        .cs : "Nastavení",
        .sk : "Nastavenie",
        .uk : "Налаштування",
        .ca : "Configuració",
        .ro : "Setări",
        .hr : "Postavke"
    ]
    
    //    MARK: - Buttons (private)
    
    private let _cameraButton: [Language:String] = [
        .en : "Camera",
        .ru : "Камера",
        .es : "Cámara",
        .fr : "Caméra",
        .pt : "Câmera",
        .it : "Telecamera",
        .de : "Kamera",
        .nl : "Kamera",
        .ja : "カメラ",
        .ko : "카메라",
        .vi : "Máy ảnh",
        .sv : "Kamera",
        .da : "Kamera",
        .fi : "Kamera",
        .nb : "Kamera",
        .tr : "Kamera",
        .el : "ΦΩΤΟΓΡΑΦΙΚΗ ΜΗΧΑΝΗ",
        .id : "Kamera",
        .ms : "Kamera",
        .th : "กล้อง",
        .hi : "कैमरा",
        .hu : "Kamera",
        .pl : "Aparat fotograficzny",
        .cs : "Fotoaparát",
        .sk : "Fotoaparát",
        .uk : "Камера",
        .ca : "Càmera",
        .ro : "Aparat foto",
        .hr : "Fotoaparat"
    ]
    
    private let _galeryButton: [Language:String] = [
        .en : "Gallery",
        .ru : "Галерея",
        .es : "Galeria",
        .fr : "Galerie",
        .pt : "Galeria",
        .it : "Galery",
        .de : "Galerie",
        .nl : "Galery",
        .ja : "ギャラリー",
        .ko : "갤러리",
        .vi : "bộ sưu tập",
        .sv : "Galleri",
        .da : "Galleri",
        .fi : "galleria",
        .nb : "Galleri",
        .tr : "galeri",
        .el : "Εκθεσιακός χώρος",
        .id : "Galeri",
        .ms : "Galeri",
        .th : "เฉลียง",
        .hi : "गेलरी",
        .hu : "Képtár",
        .pl : "Galeria",
        .cs : "Galerie",
        .sk : "Galéria",
        .uk : "Галерея",
        .ca : "Galeria",
        .ro : "Galerie",
        .hr : "Galerija"
    ]
    
    private let _backButton: [Language:String] = [
        .en : "Back",
        .ru : "Назад",
        .es : "Espalda",
        .fr : "Arrière",
        .pt : "Costas",
        .it : "Indietro",
        .de : "Zurück",
        .nl : "Tilbage",
        .ja : "バック",
        .ko : "뒤",
        .vi : "Trở lại",
        .sv : "Tillbaka",
        .da : "Tilbage",
        .fi : "Takaisin",
        .nb : "Tilbake",
        .tr : "Geri",
        .el : "Πίσω",
        .id : "Kembali",
        .ms : "Belakang",
        .th : "กลับ",
        .hi : "वापस",
        .hu : "Vissza",
        .pl : "Plecy",
        .cs : "Zadní",
        .sk : "Späť",
        .uk : "Назад",
        .ca : "Esquena",
        .ro : "Înapoi",
        .hr : "Leđa"
    ]
    
    //    MARK: - Settings list (private)
    
    private let _mainLanguage: [Language:String] = [
        .en : "Main language",
        .ru : "Основной язык",
        .es : "Lenguaje principal",
        .fr : "Langage principal",
        .pt : "Idioma principal",
        .it : "Lingua principale",
        .de : "Muttersprache",
        .nl : "Hovedsprog",
        .ja : "主要言語",
        .ko : "주요 언어",
        .vi : "Ngôn ngữ chính",
        .sv : "Modersmål",
        .da : "Hovedsprog",
        .fi : "Pääkieli",
        .nb : "Hovedspråk",
        .tr : "Ana dil",
        .el : "Κύρια γλώσσα",
        .id : "Bahasa utama",
        .ms : "Bahasa utama",
        .th : "ภาษาหลัก",
        .hi : "मुख्य भाषा",
        .hu : "Fő nyelv",
        .pl : "Główny język",
        .cs : "Hlavní jazyk",
        .sk : "Hlavný jazyk",
        .uk : "Основна мова",
        .ca : "Idioma principal",
        .ro : "Principala limbă de comunicare",
        .hr : "Glavni jezik"
    ]
    
    private let _foreignLanguage: [Language:String] = [
        .en : "Foreign language",
        .ru : "Иностранный язык",
        .es : "Idioma extranjero",
        .fr : "Une langue étrangère",
        .pt : "Lingua estrangeira",
        .it : "Lingua straniera",
        .de : "Fremdsprache",
        .nl : "Fremmedsprog",
        .ja : "外国語",
        .ko : "외국어",
        .vi : "Ngoại ngữ",
        .sv : "Främmande språk",
        .da : "Fremmedsprog",
        .fi : "Vieras kieli",
        .nb : "Fremmed språ",
        .tr : "Yabancı Dil",
        .el : "Ξένη γλώσσα",
        .id : "Bahasa asing",
        .ms : "Bahasa asing",
        .th : "ภาษาต่างประเทศ",
        .hi : "विदेशी भाषा",
        .hu : "Idegen nyelv",
        .pl : "Język obcy",
        .cs : "Cizí jazyk",
        .sk : "Cudzí jazyk",
        .uk : "Іноземна мова",
        .ca : "Llengua estrangera",
        .ro : "Limbă străină",
        .hr : "Strani jezik"
    ]
    
    private let _deleteData: [Language:String] = [
        .en : "Delete data",
        .ru : "Удалить данные",
        .es : "Borrar datos",
        .fr : "Suprimmer les données",
        .pt : "Apagar dados",
        .it : "Elimina i dati",
        .de : "Daten löschen",
        .nl : "Slet data",
        .ja : "データを削除する",
        .ko : "데이터 삭제",
        .vi : "Xóa dữ liệu",
        .sv : "Ta bort data",
        .da : "Slet data",
        .fi : "Poista tiedot",
        .nb : "Slett data",
        .tr : "Verileri sil",
        .el : "Διαγραφή δεδομένων",
        .id : "Hapus data",
        .ms : "Padamkan data",
        .th : "ลบข้อมูล",
        .hi : "डेटा हटाएं",
        .hu : "Adatok törlése",
        .pl : "Usunąć dane",
        .cs : "Smazat data",
        .sk : "Odstrániť údaje",
        .uk : "Видалити дані",
        .ca : "Suprimeix les dades",
        .ro : "Ștergeți datele",
        .hr : "Izbriši podatke"
    ]
    
    //    MARK: - Remember (private)
    
    private let _remember: [Language:String] = [
        .en : "Remember",
        .ru : "Запомнить",
        .es : "Recuerda",
        .fr : "Rappelles toi",
        .pt : "Lembrar",
        .it : "Ricorda",
        .de : "Merken",
        .nl : "Onthouden",
        .ja : "覚えて",
        .ko : "생각해 내다",
        .vi : "Nhớ lại",
        .sv : "Kom ihåg",
        .da : "Husk",
        .fi : "Muistaa",
        .nb : "Huske",
        .tr : "Hatırlamak",
        .el : "Θυμάμαι",
        .id : "Ingat",
        .ms : "Ingatlah",
        .th : "จำ",
        .hi : "याद है",
        .hu : "Emlékezik",
        .pl : "Zapamiętaj",
        .cs : "Pamatovat si",
        .sk : "Pamätať",
        .uk : "Пам'ятайте",
        .ca : "Recordeu",
        .ro : "Tine minte",
        .hr : "Zapamtit"
    ]
    
    //    MARK: - Alert (private)
    private let _emptyObjectAlertTitle: [Language:String] = [
        .en : "Error",
        .ru : "Ошибка",
        .es : "Error",
        .fr : "Erreur",
        .pt : "Erro",
        .it : "Errore",
        .de : "Bild",
        .nl : "Error",
        .ja : "エラー",
        .ko : "오류",
        .vi : "lỗi",
        .sv : "Fel",
        .da : "Fejl",
        .fi : "Virhe",
        .nb : "Feil",
        .tr : "Hata",
        .el : "Λάθος",
        .id : "Kesalahan",
        .ms : "Ralat",
        .th : "ข้อผิดพลาด",
        .hi : "त्रुटि",
        .hu : "Hiba",
        .pl : "Błąd",
        .cs : "Chyba",
        .sk : "Chyba",
        .uk : "Помилка",
        .ca : "Error",
        .ro : "Eroare",
        .hr : "Greška"
    ]
    
    private let _alertMessage: [Language:String] = [
        .en : "Failed to recognize objects! Try again.",
        .ru : "Не удалось распознать объекты! Попробуйте снова.",
        .es : "¡Error al reconocer objetos! Inténtalo de nuevo.",
        .fr : "Impossible de reconnaître les objets! Réessayer.",
        .pt : "Falha ao reconhecer objetos! Tente novamente.",
        .it : "Impossibile riconoscere gli oggetti! Riprova.",
        .de : "Objekte konnten nicht erkannt werden! Versuch es noch einmal.",
        .nl : "Kunne ikke genkende genstande! Prøv igen.",
        .ja : "オブジェクトを認識できませんでした！ 再試行。",
        .ko : "개체를 인식하지 못했습니다! 다시 시도하십시오.",
        .vi : "Không thể nhận dạng các đối tượng! Thử lại.",
        .sv : "Det gick inte att känna igen objekt! Försök igen.",
        .da : "Kunne ikke genkende genstande! Prøv igen.",
        .fi : "Objektien tunnistaminen epäonnistui! Yritä uudelleen.",
        .nb : "Kunne ikke gjenkjenne gjenstander! Prøv igjen.",
        .tr : "Nesneler tanınamadı! Tekrar deneyin.",
        .el : "Αποτυχία αναγνώρισης αντικειμένων! Προσπάθησε ξανά.",
        .id : "Gagal mengenali objek! Coba lagi.",
        .ms : "Gagal mengenali objek! Cuba lagi.",
        .th : "ไม่สามารถจดจำวัตถุ! ลองอีกครั้ง.",
        .hi : "वस्तुओं को पहचानने में विफल! पुनः प्रयास करें।",
        .hu : "Nem sikerült felismerni az objektumokat! Próbáld újra.",
        .pl : "Nie udało się rozpoznać obiektów! Spróbuj ponownie.",
        .cs : "Nepodařilo se rozpoznat objekty! Zkus to znovu.",
        .sk : "Nepodarilo sa rozpoznať objekty! Skúste to znova.",
        .uk : "Чи не вдалося розпізнати об'єкти! Спробуйте знову.",
        .ca : "No s'ha pogut reconèixer els objectes! Torna-ho a provar.",
        .ro : "Nu a reușit să recunoască obiectele! Încearcă din nou.",
        .hr : "Prepoznavanje predmeta nije uspjelo! Pokušajte ponovo."
    ]
    
    private let _alertCancelTitle: [Language:String] = [
        .en : "Okay",
        .ru : "Хорошо",
        .es : "Bueno",
        .fr : "D'accord",
        .pt : "OK",
        .it : "Va bene",
        .de : "In Ordnung",
        .nl : "Okay",
        .ja : "はい",
        .ko : "괜찮아",
        .vi : "Được chứ",
        .sv : "Okej",
        .da : "Okay",
        .fi : "Okei",
        .nb : "Greit",
        .tr : "Tamam",
        .el : "εντάξει",
        .id : "Baik",
        .ms : "Baik",
        .th : "ตกลง",
        .hi : "ठीक है",
        .hu : "Oké",
        .pl : "W porządku",
        .cs : "Dobře",
        .sk : "Dobre",
        .uk : "Okay",
        .ca : "Bé",
        .ro : "Bine",
        .hr : "U redu"
    ]
    
    
    //    MARK: - Other (private)
    
    private let _image: [Language:String] = [
        .en : "Image",
        .ru : "Изображение",
        .es : "Imagen",
        .fr : "Image",
        .pt : "Imagem",
        .it : "Immagine",
        .de : "Bild",
        .nl : "Billede",
        .ja : "画像",
        .ko : "영상",
        .vi : "Hình ảnh",
        .sv : "Bild",
        .da : "Billede",
        .fi : "Kuva",
        .nb : "Bilde",
        .tr : "görüntü",
        .el : "Συλλογή",
        .id : "Gambar",
        .ms : "Imej",
        .th : "ภาพ",
        .hi : "छवि",
        .hu : "Kép",
        .pl : "Wizerunek",
        .cs : "Obraz",
        .sk : "Obraz",
        .uk : "Зображення",
        .ca : "Imatge",
        .ro : "Imagine",
        .hr : "Slika"
    ]
    
}
