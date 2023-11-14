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
        "source": "Gizmodo.com",
        "author": "Ed Cara",
        "title": "Woman Gets New Cat—and Months of Diarrhea, in Possible Medical First",
        "description": "A womans newly adopted cat may have brought her an unwelcome gift: a bacterial germ that caused her months of diarrhea. In a new case report this month, doctors say that the woman’s bout of recurrent Clostridioides difficile could have been fueled by her cat…",
        "url": "https://gizmodo.com/cat-to-human-transmission-of-c-diff-bacteria-infection-1850977693",
        "urlToImage": "https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/3d370461b33ae07799f184380ee41e2f.jpg",
        "publishedAt": "2023-10-31T20:30:00Z",
        "content": "A womans newly adopted cat may have brought her an unwelcome gift: a bacterial germ that caused her months of diarrhea. In a new case report this month, doctors say that the womans bout of recurrent …"
    },
    {
        "source": "Business Insider",
        "author": "Polly Thompson",
        "title": "Vaccine hesitancy is a problem for dogs too, study finds",
        "description": "Some dog owners are concerned about the risks of getting their animals vaccinated, according to a new study published in the journal Vaccine.",
        "url": "https://www.businessinsider.com/dog-owners-vaccine-hesitancy-problem-research-journal-2023-10",
        "urlToImage": "https://i.insider.com/652aa0856561dd877e7ad10f?width=1200&format=jpeg",
        "publishedAt": "2023-10-15T10:11:19Z",
        "content": "A dog is vaccinated at a drive-through clinic in California during the pandemic.Mario Tama/Getty ImagesHesitancy among dog owners means some pets are not being vaccinated, new research foun…"
    },
    {
        "source": "Business Insider",
        "author": "Robin Madell",
        "title": "I moved to Denver and regretted it because it was freezing, expensive, and hard to make friends. I'm much happier now living in Spain.",
        "description": "He moved to Denver, Colorado, and didn't like it, so he went to Spain. Eric Michiels says he thinks of the US as a place where you live to work and he didn't want that anymore.",
        "url": "https://www.businessinsider.com/moved-to-denver-colorado-and-regretted-it-2023-11",
        "urlToImage": "https://i.insider.com/64e904bebc26b40019903b1e?width=1200&format=jpeg",
        "publishedAt": "2023-11-01T13:43:24Z",
        "content": "Eric Michiels in Spain.Eric Michiels.Eric Michiels moved from Atlanta to Denver in 2021.</li<li>He was excited about more opportunities to be in nature, but hated the unpredictable weat…"
    },
    {
        "source": "Business Insider",
        "author": "Brendan Griffiths,Sarah Saril",
        "title": "150+ last-minute October Prime Day deals that end tonight",
        "description": "Our team of experts has been curating this list of top deals all day. Now's your last chance to score them.",
        "url": "https://www.businessinsider.com/guides/deals/october-prime-day-deals-ending-tonight-2023-10-11",
        "urlToImage": "https://i.insider.com/65270e9a68f1d46f52af3eb8?width=1200&format=jpeg",
        "publishedAt": "2023-10-12T02:33:35Z",
        "content": "When you buy through our links, Insider may earn an affiliate commission. Learn morePrime Day ends in only a few hours, but we're still hard at work finding the best deals on products we recommend.…"
    },
    {
        "source": "ReadWrite",
        "author": "Brad Anderson",
        "title": "The Ultimate Convenience: Pet Necessities Delivered for Busy Owners",
        "description": "Youre never too busy to spend some quality time with your pet. And you certainly donThe post The Ultimate Convenience: Pet Necessities Delivered for Busy Owners appeared first on ReadWrite.",
        "url": "https://readwrite.com/the-pet-necessities/",
        "urlToImage": "https://readwrite.com/wp-content/uploads/2023/11/boy-feeding-dog-pet-necessities-scaled.jpg",
        "publishedAt": "2023-11-07T02:58:18Z",
        "content": "Youre busy, but youre never too busy to spend some quality time with your pet. And you certainly dont want buying your pet necessities to get in the way.hankfully, we live in an on-demand world wh…"
    },
    {
        "source": "Time",
        "author": "David Ramli / Bloomberg",
        "title": "How Dog Hair Is Making a Resurgence as a Sustainable Textile",
        "description": "Depending on the breed, dog hair can be hardier than camel hair—one of the toughest commonly farmed animal fibers—and better than wool in almost every way.",
        "url": "https://time.com/6330351/dog-hair-sustainable-textile-fabric/",
        "urlToImage": "https://api.time.com/wp-content/uploads/2023/11/dog-hair-fabric-textile.jpg?quality=85",
        "publishedAt": "2023-11-01T07:00:00Z",
        "content": "In the summer of 2021, Ugo Apuzzo and Floriano Bollettini spent months crisscrossing Italy in search for what they believed was the perfect fabric. Each day, as part of their program at École des Hau…"
    },
    {
        "source": "Cheezburger.com",
        "author": "bradpdickson, bradpdickson",
        "title": "'AITA for asking her to cover this bill?': Girlfriend poisons dog with grapes, her boyfriend won't split the bill",
        "description": "Pets make for great company and comfort, but nothing about them is cheap—especially when they get into and eat something they weren't supposed which prompts an emergency trip to the vet. Similarly, it's important to remember that your pet has a different biol…",
        "url": "https://cheezburger.com/22896645/aita-for-asking-her-to-cover-this-bill-girlfriend-poisons-dog-with-grapes-her-boyfriend-wont-split",
        "urlToImage": "https://i.chzbgr.com/thumb1200/22896645/h021DD0E5/pets-ex-girlfriend-relationship-drama-girlfriends-relationships-girlfriend-pet-dating-22896645",
        "publishedAt": "2023-11-03T16:00:00Z",
        "content": "This guy's girlfriend, unfortunately, discovered that their recently adopted dog loved eating grapes, feeding him copious amounts of his newfound favorite treat. When her boyfriend arrived home, he w…"
    },
    {
        "source": "Yanko Design",
        "author": "Srishti Mitra",
        "title": "The Ultimate Pet Protection System Is Designed To Keep Your Pets Comfy, Cozy and Secure",
        "description": "The Ultimate Pet Protection System Is Designed To Keep Your Pets Comfy, Cozy and SecureFor most of us, our pets arent simply pets! Theyre our children and babies we consider our own blood. We take care of them the...",
        "url": "https://www.yankodesign.com/2023/10/19/the-ultimate-pet-protection-system-is-designed-to-keep-your-pets-comfy-cozy-and-secure/",
        "urlToImage": "https://www.yankodesign.com/images/design_news/2023/10/maeve-pet-protection-system/maeve_pet_protection_system_yanko_design_04.jpg",
        "publishedAt": "2023-10-19T17:20:47Z",
        "content": "For most of us, our pets arent simply pets! Theyre our children and babies we consider our own blood. We take care of them the way we would take care of our own kids, and leave no stone unturned to…"
    },
    {
        "source": "GameSpot",
        "author": "Cameron Koch",
        "title": "WoW Players Raise 1.5 Million For Ukraine Relief Efforts By Adopting Virtual Pets",
        "description": "World of Warcraft players raised 1.5 million for Ukrainian relief efforts from late July to late August, developer Blizzard has announced.Blizzard offered a 20 WoW pet bundle for a limited time to raise the funds, with players unlocking Sunny the Golden Ret…",
        "url": "https://www.gamespot.com/articles/wow-players-raise-1-5-million-for-ukraine-relief-efforts-by-adopting-virtual-pets/1100-6518337/",
        "urlToImage": "https://www.gamespot.com/a/uploads/screen_kubrick/1647/16470614/4204148-wowplayersraise%241.5millionforukraine.jpg",
        "publishedAt": "2023-10-11T18:39:00Z",
        "content": "World of Warcraft players raised 1.5 million for Ukrainian relief efforts from late July to late August, developer Blizzard has announced.Blizzard offered a 20 WoW pet bundle for a limited time t…"
    },
    {
        "source": "Mental Floss",
        "author": "Alexia Kontolemos",
        "title": "Why Wont My Cat Use the Litter Box?",
        "description": "A certified cat trainer suggests reasons why a cat wont use its litter box—and offers some possible solutions.",
        "url": "https://www.mentalfloss.com/posts/cat-not-using-litter-box",
        "urlToImage": "https://images2.minutemediacdn.com/image/upload/c_crop,w_4200,h_2362,x_0,y_174/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/images/voltaxMediaLibrary/mmsport/mentalfloss/01heqzwkr2aygnmzp0bh.jpg",
        "publishedAt": "2023-11-10T20:00:00Z",
        "content": "Cats are creatures of habit, and frequenting a litter box is an important part of their daily lives that usually involves minimal training. Cats have a really strong desire to go and dig and bury in …"
    }
]
""";

class WatchNewsEn extends StatefulWidget {
  const WatchNewsEn({Key? key}) : super(key: key);

  @override
  State<WatchNewsEn> createState() => WatchNewsEnState();
}

class WatchNewsEnState extends State<WatchNewsEn> {
  List<Article> articles = [];
  late Future<ApiResponse> futureResponse;

  @override
  void initState() {
    super.initState();

    futureResponse = fetchFromApi(
        RequestOptions(method: HttpMethods.get, path: '/api/news/en'));

    // futureResponse = _obtainJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetNews'),
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
                    label: const Text('Home'),
                    icon: const Icon(Icons.home),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.news);
                    },
                    label: const Text('Español'),
                    icon: const Icon(Icons.language),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.maps);
                    },
                    label: const Text('Go map'),
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
                    label: const Text('Home'),
                    icon: const Icon(Icons.home),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.news);
                    },
                    label: const Text('es'),
                    icon: const Icon(Icons.language),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.maps);
                    },
                    label: const Text('Go map'),
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
