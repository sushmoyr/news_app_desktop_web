import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app_desktop_web/models/article_category.dart';
import 'package:news_app_desktop_web/models/news_page.dart';
import 'package:news_app_desktop_web/widgets/news_list.dart';
import 'package:window_manager/window_manager.dart';
import "dart:io";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitle('News App');
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
      await windowManager.setBackgroundColor(Colors.transparent);
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(755, 545));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
      await windowManager.setPreventClose(true);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'News app',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        accentColor: Colors.orange,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        accentColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final viewKey = GlobalKey();
  int _index = 0;

  final List<NewsPage> pages = const [
    NewsPage(
      title: 'Top Headlines',
      iconData: FluentIcons.news,
      category: ArticleCategory.general,
    ),
    NewsPage(
      title: 'Business',
      iconData: FluentIcons.business_center_logo,
      category: ArticleCategory.business,
    ),
    NewsPage(
      title: 'Technology',
      iconData: FluentIcons.laptop_secure,
      category: ArticleCategory.technology,
    ),
    NewsPage(
      title: 'Entertainment',
      iconData: FluentIcons.my_movies_t_v,
      category: ArticleCategory.entertainment,
    ),
    NewsPage(
      title: 'Sports',
      iconData: FluentIcons.more_sports,
      category: ArticleCategory.sports,
    ),
    NewsPage(
      title: 'Science',
      iconData: FluentIcons.communications,
      category: ArticleCategory.science,
    ),
    NewsPage(
      title: 'Health',
      iconData: FluentIcons.health,
      category: ArticleCategory.health,
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
        selected: _index,
        onChanged: (index) => setState(() {
          _index = index;
        }),
        displayMode: PaneDisplayMode.compact,
        items: pages
            .map<NavigationPaneItem>(
              (e) => PaneItem(
                icon: Icon(e.iconData),
                title: Text(e.title),
              ),
            )
            .toList(),
      ),
      content: NavigationBody.builder(
        index: _index,
        itemBuilder: (ctx, i) {
          return NewsListPage(newsPage: pages[i]);
        },
      ),
    );
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm Close'),
            content: const Text('Are you sure want to close the window?'),
            actions: [
              FilledButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              FilledButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
