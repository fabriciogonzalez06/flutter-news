import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsprovider/src/models/cateogy_model.dart';
import 'package:newsprovider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS='https://newsapi.org/v2';
final API_KEY='dba30f9b047c4dcfba6ccaf6ab406a0c';

class NewsService with ChangeNotifier{

  List<Article> headLines=[];
  String _selectedCategory='business';

   List<Category> categories=[
    Category(FontAwesomeIcons.building,'business'),
    Category(FontAwesomeIcons.tv,'entertainment'),
    Category(FontAwesomeIcons.addressCard,'general'),
    Category(FontAwesomeIcons.headSideVirus,'health'),
    Category(FontAwesomeIcons.vials,'science'),
    Category(FontAwesomeIcons.volleyballBall,'sports'),
    Category(FontAwesomeIcons.memory,'technology'),
  ];

  Map<String,List<Article>> categoryArticles={};

  NewsService(){
    this.getTopHeadlines();

    this.categories.forEach((item){
      this.categoryArticles[item.name] = new List();
    });
  }


  String get selectedCategory=>this._selectedCategory;
  set selectedCategory(String valor){
    this._selectedCategory=valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> getArticlesCategorySelected() => this.categoryArticles[this._selectedCategory];

  getArticlesByCategory(String category)async{

    if(this.categoryArticles[category].length>0){
      return this.categoryArticles[category];
    }

    final url='$_URL_NEWS/top-headlines?country=us&apiKey=$API_KEY&category=$category';
    final resp= await http.get(url);

   final newsResponse=  newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    
    notifyListeners();
  }

  getTopHeadlines()async{
    final url='$_URL_NEWS/top-headlines?country=us&apiKey=$API_KEY';
    final resp= await http.get(url);

   final newsResponse=  newsResponseFromJson(resp.body);

    this.headLines.addAll(newsResponse.articles);
    notifyListeners();

  }

}