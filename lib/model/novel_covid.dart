import 'package:covid19/model/utils.dart';



class All {
    int cases;
    int deaths;
    int recovered;
    int updated;
    int active;

    All({
        this.cases,
        this.deaths,
        this.recovered,
        this.updated,
        this.active,
    });

    factory All.fromJson(Map<String, dynamic> json) => All(
        cases: json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
        updated: json["updated"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "cases": cases,
        "deaths": deaths,
        "recovered": recovered,
        "updated": updated,
        "active": active,
    };
}

class Country {
    String country;
    CountryInfo countryInfo;
    int cases;
    int todayCases;
    int deaths;
    int todayDeaths;
    int recovered;
    int active;
    dynamic critical;
    dynamic casesPerOneMillion;
    dynamic deathsPerOneMillion;

    Country({
        this.country,
        this.countryInfo,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.active,
        this.critical,
        this.casesPerOneMillion,
        this.deathsPerOneMillion,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        country: json["country"],
        countryInfo: CountryInfo.fromJson(json["countryInfo"]),
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerOneMillion: util.perOneMillionToString(json["casesPerOneMillion"]),
        deathsPerOneMillion: util.perOneMillionToString(json["deathsPerOneMillion"]),
    );

    factory Country.fromStates(States state) => Country(
        cases: state.cases,
        todayCases: state.todayCases,
        deaths: state.deaths,
        todayDeaths: state.todayDeaths,
        recovered: state.cases - state.deaths - state.active,
        active: state.active,
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "countryInfo": countryInfo.toJson(),
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
    };
}

class CountryInfo {
    int id;
    double lat;
    double long;
    String flag;
    String iso3;
    String iso2;

    CountryInfo({
        this.id,
        this.lat,
        this.long,
        this.flag,
        this.iso3,
        this.iso2,
    });

    factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        id: json["_id"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        flag: json["flag"],
        iso3: json["iso3"],
        iso2: json["iso2"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "lat": lat,
        "long": long,
        "flag": flag,
        "iso3": iso3,
        "iso2": iso2,
    };
}

class Historical {
    String country;
    dynamic province;
    Timeline timeline;

    Historical({
        this.country,
        this.province,
        this.timeline,
    });

    factory Historical.fromJson(Map<String, dynamic> json) => Historical(
        country: json["country"],
        province: json["province"],
        timeline: Timeline.fromJson(json["timeline"]),
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "province": province,
        "timeline": timeline.toJson(),
    };
}

class Timeline {
    Map<String, int> cases;
    Map<String, int> deaths;

    Timeline({
        this.cases,
        this.deaths,
    });

    factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        cases: Map.from(json["cases"]).map((k, v) => MapEntry<String, int>(k, v)),
        deaths: Map.from(json["deaths"]).map((k, v) => MapEntry<String, int>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "cases": Map.from(cases).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "deaths": Map.from(deaths).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class States {
    String state;
    int cases;
    int todayCases;
    int deaths;
    int todayDeaths;
    int active;

    States({
        this.state,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.active,
    });

    factory States.fromJson(Map<String, dynamic> json) => States(
        state: json["state"],
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "active": active,
    };
}

class CountryTrend {
  Map<DateTime, int> cases;
  Map<DateTime, int> deaths;
  CountryTrend({this.cases, this.deaths});

    factory CountryTrend.fromJson(Map<String, dynamic> json) => CountryTrend(
        cases: json["cases"],
        deaths: json["deaths"],
    );


}
