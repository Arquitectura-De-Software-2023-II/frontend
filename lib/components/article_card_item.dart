import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mypetcare/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Center(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Card(
              margin: const EdgeInsets.only(
                  right: 90, left: 90, bottom: 10, top: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: FaIcon(Icons.newspaper),
                  title: Text(article.title),
                  subtitle: Text(article.source),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        article.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      article.publishedAt.substring(0, 10),
                      maxLines: 1,
                    )),
                    ElevatedButton.icon(
                      icon: Icon(Icons.navigation),
                      label: Text('visitar'),
                      onPressed: () {
                        try {
                          _launchURL(article.url);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    const SizedBox(width: 3),
                  ],
                )
              ]));
        } else {
          return Card(
              margin: const EdgeInsets.only(
                  right: 10, left: 10, bottom: 10, top: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: FaIcon(Icons.newspaper),
                  title: Text(article.title),
                  subtitle: Text(article.source),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          article.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      article.publishedAt.substring(0, 10),
                      maxLines: 1,
                    )),
                    ElevatedButton.icon(
                      icon: Icon(Icons.navigation),
                      label: Text(''),
                      onPressed: () {
                        try {
                          _launchURL(article.url);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    const SizedBox(width: 3),
                  ],
                )
              ]));
        }
      },
    ));
  }
}

// Función para abrir la URL en un navegador externo
_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    print('No se pudo abrir la URL $url');
  }
}
