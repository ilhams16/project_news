import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_news/application/news_page.dart';
import 'package:project_news/data/fav_news.dart';
import 'package:project_news/data/get_news.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late TextEditingController _search = TextEditingController();
  late String keyword = 'business';
  bool fav = false;
  List favs = [];
  late Box box;

  @override
  void initState() {
    box = Hive.box("favoriteBox");
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News BSI"),
          centerTitle: true,
          bottom: TabBar(tabs: const <Widget>[
            Text(
              "Home",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Favorite",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 18),
            ),
          ], controller: _tabController),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            FutureBuilder(
                future: GetNews().fetchNews(keyword: "business"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                        child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        children: List.generate(snapshot.data!.length, (index) {
                          favs.add(fav);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewsPage(
                                        url: snapshot.data![index].url,
                                      )));
                            },
                            child: Card(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          '${snapshot.data![index].title}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                        IconButton(
                                            onPressed: () {
                                              favs[index] = !favs[index];
                                              if (favs[index] == true) {
                                                setState(() {
                                                  box.add(FavoriteNews(
                                                    snapshot.data![index].title,
                                                    snapshot.data![index].url,
                                                    snapshot.data![index]
                                                        .description,
                                                    snapshot
                                                        .data![index].imgUrl,
                                                    snapshot.data![index].media,
                                                    snapshot
                                                        .data![index].publish,
                                                    favs[index],
                                                  ));
                                                });
                                              } else {
                                                setState(() {
                                                  box.deleteAt(index);
                                                });
                                              }
                                            },
                                            icon: (favs[index] == true)
                                                ? const Icon(Icons.favorite)
                                                : const Icon(
                                                    Icons.favorite_outline))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.network(
                                    snapshot.data![index].imgUrl.toString(),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                        '${snapshot.data![index].description}'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Media : ${snapshot.data![index].media}'),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              'Published at ${snapshot.data![index].publish!.substring(0, 10)} ${snapshot.data![index].publish!.substring(11, 16)}'),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ));
                  }
                  return const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator(), Text("Loading...")],
                  ));
                }),
            ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, box, widget) {
                  if (box.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada berita favorit"),
                    );
                  } else {
                    return SingleChildScrollView(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          children: List.generate(box.values.toList().length,
                              (index) {
                            return Card(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          '${box.getAt(index).title}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                        IconButton(
                                            onPressed: () {
                                              box.deleteAt(index);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.network(
                                    box.getAt(index).imgUrl.toString(),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child:
                                        Text('${box.getAt(index).description}'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Media : ${box.getAt(index).media}'),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              '${'Published at ' + box.getAt(index).publish!.substring(0, 10)} ' +
                                                  box
                                                      .getAt(index)
                                                      .publish!
                                                      .substring(11, 16)),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ));
                  }
                }),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // child: Row(
                  //   children: [
                  child: TextFormField(
                    controller: _search,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Search"),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.search),
                  //   iconSize: 10,
                  // )
                  // ],
                  // )
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        keyword = _search.text.toLowerCase();
                      });
                    },
                    child: Text("Search")),
                FutureBuilder(
                    future: GetNews().fetchNews(keyword: keyword),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                            child: Container(
                          height: 500,
                          child: ListView(
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              favs.add(fav);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NewsPage(
                                            url: snapshot.data![index].url,
                                          )));
                                },
                                child: Card(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                              '${snapshot.data![index].title}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )),
                                            IconButton(
                                                onPressed: () {
                                                  favs[index] = !favs[index];
                                                  if (favs[index] == true) {
                                                    setState(() {
                                                      box.add(FavoriteNews(
                                                        snapshot
                                                            .data![index].title,
                                                        snapshot
                                                            .data![index].url,
                                                        snapshot.data![index]
                                                            .description,
                                                        snapshot.data![index]
                                                            .imgUrl,
                                                        snapshot
                                                            .data![index].media,
                                                        snapshot.data![index]
                                                            .publish,
                                                        favs[index],
                                                      ));
                                                    });
                                                  } else {
                                                    setState(() {
                                                      box.deleteAt(index);
                                                    });
                                                  }
                                                },
                                                icon: (favs[index] == true)
                                                    ? const Icon(Icons.favorite)
                                                    : const Icon(
                                                        Icons.favorite_outline))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Image.network(
                                        snapshot.data![index].imgUrl.toString(),
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            '${snapshot.data![index].description}'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Media : ${snapshot.data![index].media}'),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  'Published at ${snapshot.data![index].publish!.substring(0, 10)} ${snapshot.data![index].publish!.substring(11, 16)}'),
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ));
                      }
                      return const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Loading...")
                        ],
                      ));
                    })
              ],
            )
          ],
        ));
  }
}
