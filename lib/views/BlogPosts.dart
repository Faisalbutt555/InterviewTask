import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:interview_task/model/ListModelClass.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview_task/Services/ApiUrls.dart';
import 'package:interview_task/views/Authentication/SignInScreen.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class BlogPosts extends StatefulWidget {
  @override
  _BlogPostsState createState() => _BlogPostsState();
}

class _BlogPostsState extends State<BlogPosts> {
  List<BlogsModel> fetchcategories;

  @override
  void initState() {
    super.initState();
    check();
    getdata();
    //  saveDatatToLocal(fetchcategories);
    // getdata();
  }

  String query = '';
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return getLocaldata();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return getLocaldata();
    }
    return showCustomFlushbar(context, 'Alert', 'Internet is Disconnected');
  }

  getdata() async {
    fetchcategories = await fetchcategoy();
    setState(() {
      saveDatatToLocal(fetchcategories);
    });
  }

  Future<List<BlogsModel>> fetchcategoy() async {
    print("api started");
    final response = await http.get(Uri.parse(
      ApiUrl.BlogsUrl,
    ));
    print("api called");
    print("code will be here${response.statusCode}");
    List jsonResponse = json.decode(response.body.toString());
    print("body is here${response.body.toString()}");
    return jsonResponse.map((data) => new BlogsModel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          bottom: PreferredSize(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    onChanged: (txt) {
                      txt = txt.toLowerCase();
                      setState(() {
                        fetchcategories = fetchcategories.where((title) {
                          var blogtitle = title.slug.toLowerCase();
                          return blogtitle.contains(txt);
                        }).toList();
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Search here',
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(70)),
          leadingWidth: double.minPositive,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Blog Posts',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(05),
            width: MediaQuery.of(context).size.width,
            child: Scrollbar(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fetchcategories?.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(seconds: 00001),
                                    type: PageTransitionType.rightToLeft,
                                    child: SignIn()));
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(05),
                            color: Colors.grey[800],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(04)),
                                child: CachedNetworkImage(
                                  height: 150,
                                  width: double.infinity,
                                  imageUrl: fetchcategories[index]
                                      .jetpackFeaturedMediaUrl,
                                  placeholder: (context, url) => Container(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                          child:
                                              new CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Html(
                                  data: fetchcategories[index].slug,
                                  shrinkWrap: true,
                                  style: {
                                    "body": Style(
                                      maxLines: 2,
                                      fontSize: FontSize(16.0),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  },
                                ),
                              ),
                              Html(
                                data: fetchcategories[index].content.rendered,
                                shrinkWrap: true,
                                style: {
                                  "body": Style(
                                    maxLines: 2,
                                    fontSize: FontSize(12.0),
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
            )));
  }

  saveDatatToLocal(List<BlogsModel> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> local = {};
    data.forEach((element) {
      Map<String, dynamic> d = element.toJson();
      local.addAll({element.id.toString(): json.encode(d)});
    });
    String encodedPosts = json.encode(local);
    sharedPreferences.setString('posts', encodedPosts);
  }

  getLocaldata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String encodedPosts = sharedPreferences.getString('posts') ?? '';

    //Below is code for getting data from Shared Prefrences///While above code is for storing data to shared preferences
    //By the way BAKI KHUDD PAAAAAN YAWAIII
    Map<String, String> datadb = {};
    datadb = json.decode(encodedPosts);
    List<BlogsModel> savedata = [];
    datadb.forEach((key, value) {
      savedata.add(BlogsModel.fromJson(json.decode(value)));
    });
    return savedata;
  }
}
