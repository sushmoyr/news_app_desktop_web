import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:news_app_desktop_web/models/article.dart';
import 'package:news_app_desktop_web/models/news_page.dart';
import 'package:news_app_desktop_web/services/news_api.dart';
import 'package:news_app_desktop_web/widgets/news_item.dart';

class NewsListPage extends StatefulWidget {
  final NewsPage newsPage;

  const NewsListPage({Key? key, required this.newsPage}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<Article>> articles;
  final NewsApi newsApi = NewsApi();

  @override
  void initState() {
    super.initState();
    articles = newsApi.fetchArticles(widget.newsPage.category);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(widget.newsPage.title),
      ),
      content: FutureBuilder(
        future: articles,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _widgetToBuild(snapshot.data!);
          } else if (snapshot.hasError) {
            return SizedBox.expand(
              child: Column(
                children: [
                  Spacer(),
                  Text(snapshot.error.toString()),
                  SizedBox(
                    height: 30,
                  ),
                  FilledButton(
                    child: Icon(FluentIcons.refresh),
                    onPressed: () {
                      setState(() {
                        articles =
                            newsApi.fetchArticles(widget.newsPage.category);
                      });
                    },
                  ),
                  Spacer(),
                ],
              ),
            );
          } else {
            return SizedBox.expand(
                child:
                    Center(child: const material.CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  _widgetToBuild(List<Article> articles) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 270,
          mainAxisExtent: 300,
          mainAxisSpacing: 30,
          crossAxisSpacing: 16,
        ),
        padding: const EdgeInsets.all(16),
        itemBuilder: (ctx, idx) => NewsItem(
          article: articles[idx],
        ),
        itemCount: articles.length,
      );
}
