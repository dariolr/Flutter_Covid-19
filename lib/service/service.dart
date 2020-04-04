import 'dart:convert';

import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/model/pcm.dart';
import 'package:covid19/view/list_ita_regioni.dart';
import 'package:covid19/view/list_usa_states.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

//
final String novelCovid = "https://corona.lmao.ninja/";
final String novelCovidV2 = "https://corona.lmao.ninja/v2/";
final String dpc =
    "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/";
//
Future<Nazionale> getNazionaleLatest() async {
  Nazionale result = Nazionale();
  List<Nazionale> temp = [];
  try {
    Response response =
        await get(dpc + "dpc-covid19-ita-andamento-nazionale-latest.json");
    List data = jsonDecode(response.body);
    temp = data.map((i) => Nazionale.fromJson(i)).toList();
    result = temp.first;
  } catch (e) {
    print(
        "\n>>>>>>GET NAZIONALE ELATEST RROR>>>>>>>\n$e\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  }
  return result;
}

//
Future<List<Nazionale>> getRegionaleLatest() async {
  List<Nazionale> result = [];
  try {
    Response response = await get(dpc + "dpc-covid19-ita-regioni-latest.json");
    List data = jsonDecode(response.body);
    result = data.map((i) => Nazionale.fromJson(i)).toList();
    if (result.length > 1) {
      Nazionale italia =
          Nazionale(denominazioneRegione: ListITARegioniView.tutteLeRegioni);
      result.insert(0, italia);
    }
  } catch (e) {
    print(
        "\n>>>>>>GET REGIONALE ERROR>>>>>>>\n$e\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  }
  return result;
}

//
Future<List<Country>> getCountries() async {
  List<Country> result = [];
  try {
    Response response = await get(novelCovid + "countries");
    List data = jsonDecode(response.body);
    result = data.map((i) => Country.fromJson(i)).toList();
    if (result.length > 1) {
      if (result.first.country != SingleIntReportView.allCountries) {
        Country allCountry = Country(
            country: SingleIntReportView.allCountries,
            cases: 0,
            todayCases: 0,
            deaths: 0,
            todayDeaths: 0,
            recovered: 0,
            active: 0,
            critical: 0);
        for (Country country in result) {
          allCountry.cases += country.cases ?? 0;
          allCountry.todayCases += country.todayCases ?? 0;
          allCountry.deaths += country.deaths ?? 0;
          allCountry.todayDeaths += country.todayDeaths ?? 0;
          allCountry.recovered += country.recovered ?? 0;
          allCountry.active += country.active ?? 0;
          allCountry.critical += country.critical ?? 0;
        }
        result.insert(0, allCountry);
      }
    }
  } catch (e) {
    print(
        "\n>>>>>>GET COUNTRIES ERROR>>>>>>>\n$e\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  }
  return result;
}

//
Future<List<States>> getStates() async {
  List<States> result = [];
  try {
    Response response = await get(novelCovid + "states");
    List data = jsonDecode(response.body);
    result = data.map((i) => States.fromJson(i)).toList();
    if (result.length > 1) {
      States allStates = States(state: ListUSAStatesView.tuttiGliStati);
      result.insert(0, allStates);
    }
  } catch (e) {
    print(
        "\n>>>>>>GET STATES ERROR>>>>>>>\n$e\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  }
  return result;
}

Future<CountryTrend> getCountryHistorical(String countryName) async {
  if (countryName == SingleIntReportView.allCountries) {
    return null;
  }
  try {
    Response response = await get(novelCovidV2 + "historical/" + countryName);
    dynamic data = jsonDecode(response.body);

    Map<String, dynamic> cases = data["timeline"]["cases"];
    Map<String, dynamic> deaths = data["timeline"]["deaths"];
    return new CountryTrend(
      cases: cases.map(_history),
      deaths: deaths.map(_history),
    );
  } catch (e) {
    print(
        "\n>>>>>>GET COUNTRY HISTORICAL ERROR>>>>>>>\n$e\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    return CountryTrend(
      cases: {},
      deaths: {},
    );
  }
}

//
final DateFormat format = new DateFormat("MM/dd/yy");

MapEntry<DateTime, int> _history(String dateString, dynamic count) {
  return MapEntry<DateTime, int>(format.parse(dateString), count.toInt());
}
