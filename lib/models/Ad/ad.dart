class Ad {
  int listId;
  String firstPublicationDate;
  String expirationDate;
  String indexDate;
  String status;
  String categoryId;
  String categoryName;
  String subject;
  String body;
  String adType;
  String url;
  List<int> price;
  Null priceCalendar;
  Images images;
  List<Attributes> attributes;
  Location location;
  Owner owner;
  Options options;
  bool hasPhone;

  Ad(
      {this.listId,
      this.firstPublicationDate,
      this.expirationDate,
      this.indexDate,
      this.status,
      this.categoryId,
      this.categoryName,
      this.subject,
      this.body,
      this.adType,
      this.url,
      this.price,
      this.priceCalendar,
      this.images,
      this.attributes,
      this.location,
      this.owner,
      this.options,
      this.hasPhone});

  Ad.fromJson(Map<String, dynamic> json) {
    listId = json['list_id'];
    firstPublicationDate = json['first_publication_date'];
    expirationDate = json['expiration_date'];
    indexDate = json['index_date'];
    status = json['status'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subject = json['subject'];
    body = json['body'];
    adType = json['ad_type'];
    url = json['url'];
    if (json['price'] != null) {
      price = json['price'].cast<int>();
    }
    priceCalendar = json['price_calendar'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
    hasPhone = json['has_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list_id'] = this.listId;
    data['first_publication_date'] = this.firstPublicationDate;
    data['expiration_date'] = this.expirationDate;
    data['index_date'] = this.indexDate;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['subject'] = this.subject;
    data['body'] = this.body;
    data['ad_type'] = this.adType;
    data['url'] = this.url;
    data['price'] = this.price;
    data['price_calendar'] = this.priceCalendar;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options.toJson();
    }
    data['has_phone'] = this.hasPhone;
    return data;
  }
}

class Images {
  String thumbUrl;
  String smallUrl;
  int nbImages;
  List<String> urls;
  List<String> urlsThumb;
  List<String> urlsLarge;

  Images(
      {this.thumbUrl,
      this.smallUrl,
      this.nbImages,
      this.urls,
      this.urlsThumb,
      this.urlsLarge});

  Images.fromJson(Map<String, dynamic> json) {
    thumbUrl = json['thumb_url'];
    smallUrl = json['small_url'];
    nbImages = json['nb_images'];
    if (json['urls'] != null) {
      urls = json['urls'].cast<String>();
    }
    if (json['urls_thumb'] != null) {
      urlsThumb = json['urls_thumb'].cast<String>();
    }
    if (json['urls_large'] != null) {
      urlsLarge = json['urls_large'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb_url'] = this.thumbUrl;
    data['small_url'] = this.smallUrl;
    data['nb_images'] = this.nbImages;
    data['urls'] = this.urls;
    data['urls_thumb'] = this.urlsThumb;
    data['urls_large'] = this.urlsLarge;
    return data;
  }
}

class Attributes {
  String key;
  String value;
  List<String> values;
  String keyLabel;
  String valueLabel;
  bool generic;

  Attributes(
      {this.key,
      this.value,
      this.values,
      this.keyLabel,
      this.valueLabel,
      this.generic});

  Attributes.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    if (json['values'] != null) {
      values = json['values'].cast<String>();
    }
    keyLabel = json['key_label'];
    valueLabel = json['value_label'];
    generic = json['generic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['values'] = this.values;
    data['key_label'] = this.keyLabel;
    data['value_label'] = this.valueLabel;
    data['generic'] = this.generic;
    return data;
  }
}

class Location {
  String countryId;
  String regionId;
  String regionName;
  String departmentId;
  String departmentName;
  String cityLabel;
  String city;
  String zipcode;
  double lat;
  double lng;
  String source;
  String provider;
  bool isShape;
  Feature feature;

  Location(
      {this.countryId,
      this.regionId,
      this.regionName,
      this.departmentId,
      this.departmentName,
      this.cityLabel,
      this.city,
      this.zipcode,
      this.lat,
      this.lng,
      this.source,
      this.provider,
      this.isShape,
      this.feature});

  Location.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    regionId = json['region_id'];
    regionName = json['region_name'];
    departmentId = json['department_id'];
    departmentName = json['department_name'];
    cityLabel = json['city_label'];
    city = json['city'];
    zipcode = json['zipcode'];
    lat = json['lat'];
    lng = json['lng'];
    source = json['source'];
    provider = json['provider'];
    isShape = json['is_shape'];
    feature =
        json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['region_id'] = this.regionId;
    data['region_name'] = this.regionName;
    data['department_id'] = this.departmentId;
    data['department_name'] = this.departmentName;
    data['city_label'] = this.cityLabel;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['source'] = this.source;
    data['provider'] = this.provider;
    data['is_shape'] = this.isShape;
    if (this.feature != null) {
      data['feature'] = this.feature.toJson();
    }
    return data;
  }
}

class Feature {
  String type;
  Geometry geometry;
  Null properties;

  Feature({this.type, this.geometry, this.properties});

  Feature.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    properties = json['properties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['properties'] = this.properties;
    return data;
  }
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = json['coordinates'].cast<double>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Owner {
  String storeId;
  String userId;
  String type;
  String name;
  bool noSalesmen;

  Owner({this.storeId, this.userId, this.type, this.name, this.noSalesmen});

  Owner.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    noSalesmen = json['no_salesmen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['no_salesmen'] = this.noSalesmen;
    return data;
  }
}

class Options {
  bool hasOption;
  bool booster;
  bool photosup;
  bool urgent;
  bool gallery;
  bool subToplist;

  Options(
      {this.hasOption,
      this.booster,
      this.photosup,
      this.urgent,
      this.gallery,
      this.subToplist});

  Options.fromJson(Map<String, dynamic> json) {
    hasOption = json['has_option'];
    booster = json['booster'];
    photosup = json['photosup'];
    urgent = json['urgent'];
    gallery = json['gallery'];
    subToplist = json['sub_toplist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_option'] = this.hasOption;
    data['booster'] = this.booster;
    data['photosup'] = this.photosup;
    data['urgent'] = this.urgent;
    data['gallery'] = this.gallery;
    data['sub_toplist'] = this.subToplist;
    return data;
  }
}
