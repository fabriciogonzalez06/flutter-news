import 'package:flutter/material.dart';
import 'package:newsprovider/src/models/cateogy_model.dart';
import 'package:newsprovider/src/services/news_service.dart';
import 'package:newsprovider/src/theme/tema.dart';
import 'package:newsprovider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     
    final newsService= Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(child: ListaNoticias(newsService.getArticlesCategorySelected()),)

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
          width: double.infinity,
          height: 80.0,
       
          child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final cName=categories[index].name;

          return Container(
            // width: 110.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categories[index]),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;


  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
 final newsService= Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
       final newsService= Provider.of<NewsService>(context,listen: false);
       newsService.selectedCategory=category.name;

      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory==category.name) ? miTema.accentColor: Colors.black54,
        ),
      ),
    );
  }
}
