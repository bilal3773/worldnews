import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:world_news/helper/data.dart';
import 'package:world_news/helper/widgets.dart';
import 'package:world_news/models/categorie_model.dart';
import 'package:world_news/models/list_item.dart';
import 'package:world_news/views/categorie_news.dart';
import '../helper/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  News news = News();
  bool _loading;
  var newslist;

  // code for country dropdownitems
  List<ListItem> _dropdownItems = [
    ListItem("in", "India"),
    ListItem("ae", "UAE"),
    ListItem("ar", "Argentina"),
    ListItem("at", "Austria"),
    ListItem("be", "Belgium"),
    ListItem("ca", "canada"),
    ListItem("co", "columbia"),
    ListItem("za", "South Africa"),
    ListItem("nz", "New zealand")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem selectedItem;

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
  //end dropdown item code

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews(String country) async {
    News news = News();
    await news.getNews(country);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    selectedItem = _dropdownMenuItems[0].value;
    categories = getCategories();
    getNews(selectedItem.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "World",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: [
          // dropdown item for selecting country
          // Align(
          //     alignment: Alignment.topRight,
          //     child:


               Container(
                 height:20.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.0),
                //     color: Colors.white10,
                //     border: Border.all(width: 0.0)),
                // child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value;
                          getNews(selectedItem.value);
                          // print(_selectedItem.value);
                          // apiKey(_selectedItem.value.toString());
                        });
                      }),
                ),
              
          // drop down button
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                     
                      SizedBox(height:10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                                country: selectedItem.value,
                              );
                            }),
                      ),

                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;
  final String country;

  CategoryCard({this.imageAssetUrl, this.categoryName, this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                    newsCategory: categoryName.toLowerCase(),
                    country: country)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
