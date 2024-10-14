import 'dart:convert';

class PlacesResponse {
    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    PlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    final String id;
    final String type;
    final List<String> placeType;
    final Properties properties;
    final String text;
    final String placeName;
    final List<double> center;
    final Geometry geometry;
    final List<Context> context;
    final List<double>? bbox;

    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.properties,
        required this.text,
        required this.placeName,
        required this.center,
        required this.geometry,
        required this.context,
        this.bbox,
    });

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
        bbox: json["bbox"] == null ? [] : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toMap(),
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
    };
}

class Context {
    final String id;
    final String mapboxId;
    final String text;
    final String? wikidata;
    final String? shortCode;

    Context({
        required this.id,
        required this.mapboxId,
        required this.text,
        this.wikidata,
        this.shortCode,
    });

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        text: json["text"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text": text,
        "wikidata": wikidata,
        "short_code": shortCode,
    };
}

class Geometry {
    final String type;
    final List<double> coordinates;

    Geometry({
        required this.type,
        required this.coordinates,
    });

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    final String? foursquare;
    final bool? landmark;
    final String? address;
    final String? category;
    final String? maki;
    final String? mapboxId;
    final String? wikidata;

    Properties({
        this.foursquare,
        this.landmark,
        this.address,
        this.category,
        this.maki,
        this.mapboxId,
        this.wikidata,
    });

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        maki: json["maki"],
        mapboxId: json["mapbox_id"],
        wikidata: json["wikidata"],
    );

    Map<String, dynamic> toMap() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "maki": maki,
        "mapbox_id": mapboxId,
        "wikidata": wikidata,
    };
}
