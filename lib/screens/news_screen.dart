import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_services.dart';
import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/image_not_available_container.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(
        title: const Center(child: Text('News Screen')),
      ),
      body: FutureBuilder<NewsModel?>(
        future: apiServices.getNewsData('in'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final NewsModel newsData = snapshot.data!;
            // print('NEWS DATA: ${newsData}');
            return Theme(
              data: ThemeData(
                highlightColor: Colors.grey.shade300,
              ),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                child: ListView.builder(
                  itemCount: newsData.articles?.length,
                  itemBuilder: (context, index) {
                    Articles? article = snapshot.data!.articles![index];

                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Column(
                          children: [
                            article.urlToImage != null &&
                                article.urlToImage!.isNotEmpty
                                ? Container(
                              width: double.infinity,
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image:
                                    NetworkImage(article.urlToImage!),
                                    fit: BoxFit.fill),
                              ),
                            )
                                : const ImageNAContainer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Text(
                                    article.source!.name!,
                                    style: Styles.containerStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Text(article.title!),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}