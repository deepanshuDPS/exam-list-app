import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:provider/provider.dart';

class DownloadsScreen extends StatelessWidget {
  static const routeName = 'download-screen';

  const DownloadsScreen({Key? key}) : super(key: key);

  Widget _downloadItem(String name, String path) {
    return InkWell(
      onTap: () async {
        await OpenFilex.open(path);
      },
      child: CardBackground(
        paddingTop: 0,
        containerMargin: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/img_rect_phw.png', height: 80,),
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black
              ),),
            ),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: 'Downloads',
      isYellow: true,
      child: BaseImageContainer(
        opacity: 0.5,
        child: SingleChildScrollView(
          child: Consumer<DownloadProvider>(
              child: Container(), builder: (ctx, downloads, ch) {
            return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: downloads.listOfFiles.length,
                shrinkWrap: true,
                // You won't see infinite size error
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 200),
                itemBuilder: (BuildContext context, int index) {
                  return _downloadItem(
                      downloads.listOfFiles[index].absolute.path
                          .split('/')
                          .last,
                      downloads.listOfFiles[index].absolute.path
                  );
                });
          }),
        ),
      ),
    );
  }
}
