import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:news_app_desktop_web/models/article.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  const NewsItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;

    return Card(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                imageErrorBuilder: (ctx, err, stack) {
                  return const Icon(
                    material.Icons.image,
                    color: material.Colors.grey,
                  );
                },
                fit: BoxFit.cover,
                image: article.urlToImage ?? '',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Text(
                article.title,
                style: typography.bodyLarge?.apply(fontSizeFactor: 0.8),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8).copyWith(bottom: 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    article.captionText(),
                    style: typography.caption?.apply(fontSizeFactor: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropDownButton(
                  title: const Icon(FluentIcons.share),
                  items: [
                    DropDownButtonItem(
                      title: const Text('Open in Browser'),
                      leading: const Icon(FluentIcons.edge_logo),
                      onTap: () {},
                    ),
                    DropDownButtonItem(
                      title: const Text('Send via email'),
                      leading: const Icon(FluentIcons.send),
                      onTap: () {},
                    ),
                    DropDownButtonItem(
                      title: const Text('Copy URL'),
                      leading: const Icon(FluentIcons.copy),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
