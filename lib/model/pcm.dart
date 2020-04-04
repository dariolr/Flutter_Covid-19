import 'package:covid19/model/utils.dart';

class Nazionale {
    DateTime data;
    String stato;
    int ricoveratiConSintomi;
    int terapiaIntensiva;
    int totaleOspedalizzati;
    int isolamentoDomiciliare;
    int totaleAttualmentePositivi;
    int variazioneTotalePositivi;
    int nuoviPositivi;
    int dimessiGuariti;
    int deceduti;
    int totaleCasi;
    int tamponi;
    String noteIt;
    String noteEn;
    int codiceRegione;
    String denominazioneRegione;
    double lat;
    double long;

    Nazionale({
        this.data,
        this.stato,
        this.ricoveratiConSintomi,
        this.terapiaIntensiva,
        this.totaleOspedalizzati,
        this.isolamentoDomiciliare,
        this.totaleAttualmentePositivi,
        this.variazioneTotalePositivi,
        this.nuoviPositivi,
        this.dimessiGuariti,
        this.deceduti,
        this.totaleCasi,
        this.tamponi,
        this.noteIt,
        this.noteEn,
        this.codiceRegione,
        this.denominazioneRegione,
        this.lat,
        this.long,
    });

    factory Nazionale.fromJson(Map<String, dynamic> json) => Nazionale(
        data: DateTime.parse(json["data"]),
        stato: json["stato"],
        ricoveratiConSintomi: json["ricoverati_con_sintomi"],
        terapiaIntensiva: json["terapia_intensiva"],
        totaleOspedalizzati: json["totale_ospedalizzati"],
        isolamentoDomiciliare: json["isolamento_domiciliare"],
        totaleAttualmentePositivi: json["totale_positivi"],
        variazioneTotalePositivi: json["variazione_totale_positivi"],
        nuoviPositivi: json["nuovi_positivi"],
        dimessiGuariti: json["dimessi_guariti"],
        deceduti: json["deceduti"],
        totaleCasi: util.dynamicToInt(json["totale_casi"]),
        tamponi: json["tamponi"],
        noteIt: json["note_it"],
        noteEn: json["note_en"],
        codiceRegione: json["codice_regione"] == null ? null : json["codice_regione"],
        denominazioneRegione: json["denominazione_regione"] == null ? null : json["denominazione_regione"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        long: json["long"] == null ? null : json["long"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toIso8601String(),
        "stato": stato,
        "ricoverati_con_sintomi": ricoveratiConSintomi,
        "terapia_intensiva": terapiaIntensiva,
        "totale_ospedalizzati": totaleOspedalizzati,
        "isolamento_domiciliare": isolamentoDomiciliare,
        "totale_positivi": totaleAttualmentePositivi,
        "variazione_totale_positivi": variazioneTotalePositivi,
        "nuovi_positivi": nuoviPositivi,
        "dimessi_guariti": dimessiGuariti,
        "deceduti": deceduti,
        "totale_casi": totaleCasi,
        "tamponi": tamponi,
        "note_it": noteIt,
        "note_en": noteEn,
        "codice_regione": codiceRegione == null ? null : codiceRegione,
        "denominazione_regione": denominazioneRegione == null ? null : denominazioneRegione,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
    };
}
