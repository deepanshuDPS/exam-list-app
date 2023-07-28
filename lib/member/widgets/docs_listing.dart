import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:exam_list/member/extras/view_image.dart';
import 'package:exam_list/responseModels/login/documents_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/image_handling.dart';

class DocsListing extends StatelessWidget {
  final Data? docData;
  final Function downloadDoc;

  const DocsListing(
      {Key? key, required this.docData, required this.downloadDoc})
      : super(key: key);

  Widget _docActionButton(
      BuildContext context, String text, IconData icon, Function onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            primary: Theme.of(context).colorScheme.secondary),
        onPressed: () => onTap(),
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  icon,
                  size: 16,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isImage = (docData?.mimeType ?? "").contains('image');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: isImage
                          ? cachedImageWithDimens(docData?.docUrl ?? "N/A",
                              double.infinity, 200, BoxFit.cover,
                              placeholder:
                                  'assets/images/img_doc_placeholder.png')
                          : Image.asset(
                              'assets/images/img_doc_placeholder.png',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        (docData?.docType ?? "N/A"),
                        style: AppStyles.robotoBold().copyWith(
                            fontSize: 18,
                            color:
                                Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _docActionButton(
                            context,
                            docData?.isDownloaded == true
                                ? 'Downloaded'
                                : 'Download',
                            docData?.isDownloaded == true
                                ? Icons.download_done_outlined
                                : Icons.download, () async {
                          if (docData?.isDownloaded == true) {
                            await OpenFilex.open(docData?.filePath ?? '');
                          } else {
                            downloadDoc(docData?.docUrl ?? '');
                          }
                        }),
                        _docActionButton(
                            context, 'View', Icons.arrow_forward_ios_outlined,
                            () async {
                          if (isImage) {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return ViewImageSheet(
                                      imageUrl: docData?.docUrl ?? '');
                                },
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                backgroundColor: Colors.black26);
                          } else {
                            if (docData?.isDownloaded == true) {
                              await OpenFilex.open(docData?.filePath ?? '');
                            } else {
                              toLink(docData?.docUrl ?? '');
                            }
                          }
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
