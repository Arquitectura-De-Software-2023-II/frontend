import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypetcare/components/article_card_item.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';
import 'package:mypetcare/models/article.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';

const String json = """
[
    {
        "source": "Hipertextual",
        "author": "Azucena Martín",
        "title": "Cuidado con sobrealimentar a tu gato: las graves consecuencias más allá de engordarle",
        "description": "¿Quién no ha intentado alguna vez ganarse el cariño de otra persona a través del estómago? Demostrar el amor a través de la comida es algo de lo más habitual. Pero no solo con humanos. También con nuestros amigos peludos, tanto perros como gatos. Sin embargo,…",
        "url": "http://hipertextual.com/2023/11/peligros-sobrealimentacion-gatos",
        "urlToImage": "https://imgs.hipertextual.com/wp-content/uploads/2023/11/laura-chouette-YpoczNsZYts-unsplash-scaled.jpg",
        "publishedAt": "2023-11-06T13:35:07Z",
        "content": "¿Quién no ha intentado alguna vez ganarse el cariño de otra persona a través del estómago? Demostrar el amor a través de la comida es algo de lo más habitual. Pero no solo con humanos. También con nu…"
    },
    {
        "source": "Hipertextual",
        "author": "Azucena Martín",
        "title": "Un nuevo chip para decir adiós al termómetro rectal en los gatos y mejorar su calidad de vida",
        "description": "Hay parámetros de salud muy sencillos de medir en humanos, pero que en animales de compañía, como los gatos, pueden ser toda una odisea. Generalmente la temperatura se les toma por vía rectal y esto es algo que les resulta muy incómodo, por lo que muestran es…",
        "url": "http://hipertextual.com/2023/10/chip-temperatura-gatos",
        "urlToImage": "https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2023/10/paul-hanaoka-C0zDWAPFT9A-unsplash-scaled.jpg?fit=2560%2C1707&quality=50&strip=all&ssl=1",
        "publishedAt": "2023-10-12T08:01:00Z",
        "content": "Hay parámetros de salud muy sencillos de medir en humanos, pero que en animales de companía, como los gatos, pueden ser toda una odisea. Generalmente la temperatura se les toma por vía rectal y esto …"
    },
    {
        "source": "Espinof.com",
        "author": "Randy Meeks",
        "title": "Qué fue de Linda Blair, la niña que quería ser veterinaria hasta que 'El Exorcista' se puso en su camino... pero nunca olvidó a los perretes",
        "description": "Hay actores a los que no les queda otra que vivir en un mismo papel el resto de su vida, por más que intenten mostrar que son algo más. Macaulay Culkin y Kevin McCallister, Adam West y Batman, Anthony Perkins y Norman Bates... Y, por supuesto, Linda Blair y R…",
        "url": "https://www.espinof.com/actores-y-actrices/que-fue-linda-blair-nina-que-queria-ser-veterinaria-que-exorcista-se-puso-su-camino-nunca-olvido-a-perretes",
        "urlToImage": "https://i.blogs.es/899e96/exorcista/840_560.jpeg",
        "publishedAt": "2023-10-15T18:01:51Z",
        "content": "Hay actores a los que no les queda otra que vivir en un mismo papel el resto de su vida, por más que intenten mostrar que son algo más. Macaulay Culkin y Kevin McCallister, Adam West y Batman, Anthon…"
    },
    {
        "source": "Espinof.com",
        "author": "Randy Meeks",
        "title": "Qué fue de Linda Blair, la niña que quería ser veterinaria hasta que 'El Exorcista' se puso en su camino... pero nunca olvidó a los perretes",
        "description": "Hay actores a los que no les queda otra que vivir en un mismo papel el resto de su vida, por más que intenten mostrar que son algo más. Macaulay Culkin y Kevin McCallister, Adam West y Batman, Anthony Perkins y Norman Bates... Y, por supuesto, Linda Blair y R…",
        "url": "https://www.espinof.com/actores-y-actrices/que-fue-linda-blair-nina-que-queria-ser-veterinaria-que-exorcista-se-puso-su-camino-nunca-olvido-a-perretes",
        "urlToImage": "https://i.blogs.es/899e96/exorcista/840_560.jpeg",
        "publishedAt": "2023-10-15T18:01:51Z",
        "content": "Hay actores a los que no les queda otra que vivir en un mismo papel el resto de su vida, por más que intenten mostrar que son algo más. Macaulay Culkin y Kevin McCallister, Adam West y Batman, Anthon…"
    },
    {
        "source": "Espinof.com",
        "author": "Randy Meeks",
        "title": "Qué fue de Linda Blair, la niña que quería ser veterinaria hasta que 'El Exorcista' se puso en su camino... pero nunca olvidó a los perretes",
        "description": "Hay actores a los que no les queda otra que vivir en un mismo papel el resto de su vida, por más que intenten mostrar que son algo más. Macaulay Culkin y Kevin McCallister, Adam West y Batman, Anthony Perkins y Norman Bates... Y, por supuesto, Linda Blair y R…",
        "url": "https://www.espinof.com/actores-y-actrices/que-fue-linda-blair-nina-que-queria-ser-veterinaria-que-exorcista-se-puso-su-camino-nunca-olvido-a-perretes",
        "urlToImage": "https://i.blogs.es/899e96/exorcista/840_560.jpeg",
        "publishedAt": "2023-10-15T18:01:51Z",
        "content": "Hay actores a los que no les queda otra que vivir en un mismo papel el resto de su vida, por más que intenten mostrar que son algo más. Macaulay Culkin y Kevin McCallister, Adam West y Batman, Anthon…"
    }
]
""";

class WatchNews extends StatefulWidget {
  const WatchNews({Key? key}) : super(key: key);

  @override
  State<WatchNews> createState() => WatchNewsState();
}

class WatchNewsState extends State<WatchNews> {
  List<Article> articles = [];
  late Future<ApiResponse> futureResponse;

  @override
  void initState() {
    super.initState();

    futureResponse = fetchFromApi(
        RequestOptions(method: HttpMethods.get, path: '/api/news/es'));

    // futureResponse = _obtainJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        leading: Image.asset('lib/assets/mypetcare.png'),
        backgroundColor: Color.fromARGB(128, 0, 213, 255),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.principal);
                    },
                    label: const Text('Principal'),
                    icon: const Icon(Icons.home),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.newsEn);
                    },
                    label: const Text('English'),
                    icon: const Icon(Icons.language),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.maps);
                    },
                    label: const Text('Ir al mapa'),
                    icon: const Icon(Icons.map_rounded),
                  ),
                  SizedBox(
                    width: 90,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<ApiResponse>(
                future: futureResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final ApiResponse apiResponse = snapshot.data!;
                    if (apiResponse.statusCode == 200) {
                      final List<dynamic> body = jsonDecode(apiResponse.body);
                      articles = body
                          .map((dynamic item) => Article.fromJson(item))
                          .toList();
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return ArticleCard(article: articles[index]);
                          },
                        ),
                      );
                    } else {
                      return Text('Error al obtener los datos');
                    }
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.principal);
                    },
                    label: const Text('Principal'),
                    icon: const Icon(Icons.home),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.newsEn);
                    },
                    label: const Text('en'),
                    icon: const Icon(Icons.language),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.maps);
                    },
                    label: const Text('Ir al mapa'),
                    icon: const Icon(Icons.map_rounded),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<ApiResponse>(
                future: futureResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final ApiResponse apiResponse = snapshot.data!;
                    if (apiResponse.statusCode == 200) {
                      final List<dynamic> body = jsonDecode(apiResponse.body);
                      articles = body
                          .map((dynamic item) => Article.fromJson(item))
                          .toList();
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return ArticleCard(article: articles[index]);
                          },
                        ),
                      );
                    } else {
                      return Text('Error al obtener los datos');
                    }
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          );
        }
      }),
    );
  }
}

Future<ApiResponse> _obtainJSON() {
  // Simulación de un Future que resuelve con un String después de cierto tiempo
  return Future.delayed(
      Duration(seconds: 1), () => ApiResponse(statusCode: 200, body: json));
}
