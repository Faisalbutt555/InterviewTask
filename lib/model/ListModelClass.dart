import 'dart:convert';

List<BlogsModel> blogsModelFromJson(String str) =>
    List<BlogsModel>.from(json.decode(str).map((x) => BlogsModel.fromJson(x)));
String blogsModelToJson(List<BlogsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogsModel {
  BlogsModel({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.author,
    this.featuredMedia,
    this.commentStatus,
    this.pingStatus,
    this.sticky,
    this.template,
    this.format,
    this.meta,
    this.categories,
    this.tags,
    this.crunchbaseTag,
    this.tcStoriesTax,
    this.tcEcCategory,
    this.tcEvent,
    this.jetpackFeaturedMediaUrl,
    this.shortlink,
    this.rapidData,
    this.premiumContent,
    this.premiumCutoffPercent,
    this.featured,
    this.subtitle,
    this.seoTitle,
    this.seoDescription,
    this.tcCbMapping,
    this.associatedEvent,
    this.event,
    this.authors,
    this.hideFeaturedImage,
    this.links,
  });

  int id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  Status status;
  Type type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int author;
  int featuredMedia;
  CommentStatus commentStatus;
  PingStatus pingStatus;
  bool sticky;
  String template;
  Format format;
  Meta meta;
  List<int> categories;
  List<int> tags;
  List<dynamic> crunchbaseTag;
  List<dynamic> tcStoriesTax;
  List<int> tcEcCategory;
  List<dynamic> tcEvent;
  String jetpackFeaturedMediaUrl;
  String shortlink;
  RapidData rapidData;
  bool premiumContent;
  double premiumCutoffPercent;
  bool featured;
  String subtitle;
  String seoTitle;
  String seoDescription;
  List<dynamic> tcCbMapping;
  dynamic associatedEvent;
  dynamic event;
  List<int> authors;
  bool hideFeaturedImage;
  Links links;

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        dateGmt: DateTime.parse(json["date_gmt"]),
        guid: Guid.fromJson(json["guid"]),
        modified: DateTime.parse(json["modified"]),
        modifiedGmt: DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: statusValues.map[json["status"]],
        type: typeValues.map[json["type"]],
        link: json["link"],
        title: Guid.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        excerpt: Content.fromJson(json["excerpt"]),
        author: json["author"],
        featuredMedia: json["featured_media"],
        commentStatus: commentStatusValues.map[json["comment_status"]],
        pingStatus: pingStatusValues.map[json["ping_status"]],
        sticky: json["sticky"],
        template: json["template"],
        format: formatValues.map[json["format"]],
        meta: Meta.fromJson(json["meta"]),
        categories: List<int>.from(json["categories"].map((x) => x)),
        tags: List<int>.from(json["tags"].map((x) => x)),
        crunchbaseTag: List<dynamic>.from(json["crunchbase_tag"].map((x) => x)),
        tcStoriesTax: List<dynamic>.from(json["tc_stories_tax"].map((x) => x)),
        tcEcCategory: List<int>.from(json["tc_ec_category"].map((x) => x)),
        tcEvent: List<dynamic>.from(json["tc_event"].map((x) => x)),
        jetpackFeaturedMediaUrl: json["jetpack_featured_media_url"],
        shortlink: json["shortlink"],
        rapidData: RapidData.fromJson(json["rapidData"]),
        premiumContent: json["premiumContent"],
        premiumCutoffPercent: json["premiumCutoffPercent"].toDouble(),
        featured: json["featured"],
        subtitle: json["subtitle"],
        seoTitle: json["seoTitle"],
        seoDescription: json["seoDescription"],
        tcCbMapping: List<dynamic>.from(json["tc_cb_mapping"].map((x) => x)),
        associatedEvent: json["associatedEvent"],
        event: json["event"],
        authors: List<int>.from(json["authors"].map((x) => x)),
        hideFeaturedImage: json["hide_featured_image"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "date_gmt": dateGmt.toIso8601String(),
        "guid": guid.toJson(),
        "modified": modified.toIso8601String(),
        "modified_gmt": modifiedGmt.toIso8601String(),
        "slug": slug,
        "status": statusValues.reverse[status],
        "type": typeValues.reverse[type],
        "link": link,
        "title": title.toJson(),
        "content": content.toJson(),
        "excerpt": excerpt.toJson(),
        "author": author,
        "featured_media": featuredMedia,
        "comment_status": commentStatusValues.reverse[commentStatus],
        "ping_status": pingStatusValues.reverse[pingStatus],
        "sticky": sticky,
        "template": template,
        "format": formatValues.reverse[format],
        "meta": meta.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "crunchbase_tag": List<dynamic>.from(crunchbaseTag.map((x) => x)),
        "tc_stories_tax": List<dynamic>.from(tcStoriesTax.map((x) => x)),
        "tc_ec_category": List<dynamic>.from(tcEcCategory.map((x) => x)),
        "tc_event": List<dynamic>.from(tcEvent.map((x) => x)),
        "jetpack_featured_media_url": jetpackFeaturedMediaUrl,
        "shortlink": shortlink,
        "rapidData": rapidData.toJson(),
        "premiumContent": premiumContent,
        "premiumCutoffPercent": premiumCutoffPercent,
        "featured": featured,
        "subtitle": subtitle,
        "seoTitle": seoTitle,
        "seoDescription": seoDescription,
        "tc_cb_mapping": List<dynamic>.from(tcCbMapping.map((x) => x)),
        "associatedEvent": associatedEvent,
        "event": event,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "hide_featured_image": hideFeaturedImage,
        "_links": links.toJson(),
      };
}

enum CommentStatus { OPEN }

final commentStatusValues = EnumValues({"open": CommentStatus.OPEN});

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

enum Format { STANDARD }

final formatValues = EnumValues({"standard": Format.STANDARD});

class Guid {
  Guid({
    this.rendered,
  });

  String rendered;

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.about,
    this.replies,
    this.versionHistory,
    this.predecessorVersion,
    this.authors,
    this.httpsTechcrunchComEdit,
    this.author,
    this.wpFeaturedmedia,
    this.wpAttachment,
    this.wpTerm,
    this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<Author> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<Author> authors;
  List<About> httpsTechcrunchComEdit;
  List<Author> author;
  List<Author> wpFeaturedmedia;
  List<Author> wpAttachment;
  List<WpTerm> wpTerm;
  List<Cury> curies;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        replies:
            List<Author>.from(json["replies"].map((x) => Author.fromJson(x))),
        versionHistory: List<VersionHistory>.from(
            json["version-history"].map((x) => VersionHistory.fromJson(x))),
        predecessorVersion: List<PredecessorVersion>.from(
            json["predecessor-version"]
                .map((x) => PredecessorVersion.fromJson(x))),
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        httpsTechcrunchComEdit: List<About>.from(
            json["https://techcrunch.com/edit"].map((x) => About.fromJson(x))),
        author:
            List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        wpFeaturedmedia: List<Author>.from(
            json["wp:featuredmedia"].map((x) => Author.fromJson(x))),
        wpAttachment: List<Author>.from(
            json["wp:attachment"].map((x) => Author.fromJson(x))),
        wpTerm:
            List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "version-history":
            List<dynamic>.from(versionHistory.map((x) => x.toJson())),
        "predecessor-version":
            List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "https://techcrunch.com/edit":
            List<dynamic>.from(httpsTechcrunchComEdit.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "wp:featuredmedia":
            List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
        "wp:attachment":
            List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Author {
  Author({
    this.embeddable,
    this.href,
  });

  bool embeddable;
  String href;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable == null ? null : embeddable,
        "href": href,
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  Name name;
  Href href;
  bool templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: nameValues.map[json["name"]],
        href: hrefValues.map[json["href"]],
        templated: json["templated"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "href": hrefValues.reverse[href],
        "templated": templated,
      };
}

enum Href { HTTPS_API_W_ORG_REL }

final hrefValues =
    EnumValues({"https://api.w.org/{rel}": Href.HTTPS_API_W_ORG_REL});

enum Name { WP }

final nameValues = EnumValues({"wp": Name.WP});

class PredecessorVersion {
  PredecessorVersion({
    this.id,
    this.href,
  });

  int id;
  String href;

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) =>
      PredecessorVersion(
        id: json["id"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "href": href,
      };
}

class VersionHistory {
  VersionHistory({
    this.count,
    this.href,
  });

  int count;
  String href;

  factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
        count: json["count"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "href": href,
      };
}

class WpTerm {
  WpTerm({
    this.taxonomy,
    this.embeddable,
    this.href,
  });

  Taxonomy taxonomy;
  bool embeddable;
  String href;

  factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        taxonomy: taxonomyValues.map[json["taxonomy"]],
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "taxonomy": taxonomyValues.reverse[taxonomy],
        "embeddable": embeddable,
        "href": href,
      };
}

enum Taxonomy {
  CATEGORY,
  POST_TAG,
  TC_CB_TAG_TAXONOMY,
  TC_STORIES_TAX,
  TC_EC_CATEGORY,
  TC_EVENT
}

final taxonomyValues = EnumValues({
  "category": Taxonomy.CATEGORY,
  "post_tag": Taxonomy.POST_TAG,
  "_tc_cb_tag_taxonomy": Taxonomy.TC_CB_TAG_TAXONOMY,
  "tc_ec_category": Taxonomy.TC_EC_CATEGORY,
  "tc_event": Taxonomy.TC_EVENT,
  "tc_stories_tax": Taxonomy.TC_STORIES_TAX
});

class Meta {
  Meta({
    this.outcome,
    this.status,
    this.crunchbaseTag,
    this.ampStatus,
    this.relegenceEntities,
    this.relegenceSubjects,
    this.carmotUuid,
  });

  String outcome;
  String status;
  int crunchbaseTag;
  String ampStatus;
  List<dynamic> relegenceEntities;
  List<dynamic> relegenceSubjects;
  String carmotUuid;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        outcome: json["outcome"],
        status: json["status"],
        crunchbaseTag: json["crunchbase_tag"],
        ampStatus: json["amp_status"],
        relegenceEntities:
            List<dynamic>.from(json["relegenceEntities"].map((x) => x)),
        relegenceSubjects:
            List<dynamic>.from(json["relegenceSubjects"].map((x) => x)),
        carmotUuid: json["carmot_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "outcome": outcome,
        "status": status,
        "crunchbase_tag": crunchbaseTag,
        "amp_status": ampStatus,
        "relegenceEntities":
            List<dynamic>.from(relegenceEntities.map((x) => x)),
        "relegenceSubjects":
            List<dynamic>.from(relegenceSubjects.map((x) => x)),
        "carmot_uuid": carmotUuid,
      };
}

enum PingStatus { CLOSED }

final pingStatusValues = EnumValues({"closed": PingStatus.CLOSED});

class RapidData {
  RapidData({
    this.pt,
    this.pct,
  });

  String pt;
  String pct;

  factory RapidData.fromJson(Map<String, dynamic> json) => RapidData(
        pt: json["pt"],
        pct: json["pct"],
      );

  Map<String, dynamic> toJson() => {
        "pt": pt,
        "pct": pct,
      };
}

enum Status { PUBLISH }

final statusValues = EnumValues({"publish": Status.PUBLISH});

enum Type { POST }

final typeValues = EnumValues({"post": Type.POST});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
