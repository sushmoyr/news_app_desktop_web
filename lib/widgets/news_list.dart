import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app_desktop_web/models/news_page.dart';
import 'package:news_app_desktop_web/widgets/news_item.dart';

class NewsListPage extends StatefulWidget {
  final NewsPage newsPage;

  const NewsListPage({Key? key, required this.newsPage}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(widget.newsPage.title),
      ),
      content: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 270,
          mainAxisExtent: 300,
          mainAxisSpacing: 30,
          crossAxisSpacing: 16,
        ),
        padding: const EdgeInsets.all(16),
        itemBuilder: (ctx, idx) => NewsItem(),
      ),
    );
  }
}
