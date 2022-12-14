import 'package:q_agency_task/_all.dart';

class MovieImage extends StatelessWidget {
  String imageUrl = "";

  MovieImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 100,
      height: 100,
      errorWidget: (context, url, err) => Image.asset(
        AppAssets.logo,
      ),
      placeholder: (context, url) => Image.asset(
        AppAssets.logo,
      ),
    );
  }
}
