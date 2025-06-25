// To parse this JSON data, do
//
//     final bodyInformation = bodyInformationFromJson(jsonString);

import 'dart:convert';

BodyInformation bodyInformationFromJson(String str) => BodyInformation.fromJson(json.decode(str));

String bodyInformationToJson(BodyInformation data) => json.encode(data.toJson());

class BodyInformation {
    String? idUser;
    List<BodyInformationDetail>? information;

    BodyInformation({
        this.idUser,
        this.information,
    });

    BodyInformation copyWith({
        String? idUser,
        List<BodyInformationDetail>? information,
    }) => 
        BodyInformation(
            idUser: idUser ?? this.idUser,
            information: information ?? this.information,
        );

    factory BodyInformation.fromJson(Map<String, dynamic> json) => BodyInformation(
        idUser: json["idUser"],
        information: json["information"] == null ? [] : List<BodyInformationDetail>.from(json["information"]!.map((x) => BodyInformationDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "information": information == null ? [] : List<dynamic>.from(information!.map((x) => x)),
    };
}

class BodyInformationDetail {
    int? sort;
    String? title;
    String? value;
    Info? info;

    BodyInformationDetail({
        this.sort,
        this.title,
        this.value,
        this.info,
    });

    BodyInformationDetail copyWith({
        int? sort,
        String? title,
        String? value,
        Info? info,
    }) => 
        BodyInformationDetail(
            sort: sort ?? this.sort,
            title: title ?? this.title,
            value: value ?? this.value,
            info: info ?? this.info,
        );

    factory BodyInformationDetail.fromJson(Map<String, dynamic> json) => BodyInformationDetail(
        sort: json["sort"],
        title: json["title"],
        value: json["value"]?.toString(),
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
    );

    Map<String, dynamic> toJson() => {
        "sort": sort,
        "title": title,
        "value": value,
        "info": info?.toJson(),
    };
}

class Info {
    String? formula;
    List<Source>? source;
    String? body;
    String? title;

    Info({
        this.formula,
        this.source,
        this.body,
        this.title,
    });

    Info copyWith({
        String? formula,
        List<Source>? source,
        String? body,
        String? title,
    }) => 
        Info(
            formula: formula ?? this.formula,
            source: source ?? this.source,
            body: body ?? this.body,
            title: title ?? this.title,
        );

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        formula: json["formula"],
        source: json["source"] == null ? [] : List<Source>.from(json["source"]!.map((x) => Source.fromJson(x))),
        body: json["body"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "formula": formula,
        "source": source == null ? [] : List<dynamic>.from(source!.map((x) => x.toJson())),
        "body": body,
        "title": title,
    };
}

class Source {
    String? title;
    String? value;

    Source({
        this.title,
        this.value,
    });

    Source copyWith({
        String? title,
        String? value,
    }) => 
        Source(
            title: title ?? this.title,
            value: value ?? this.value,
        );

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        title: json["title"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
    };
}
