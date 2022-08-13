import 'package:flutter/material.dart';
import 'package:q_agency_task/_all.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0.0,
        title: GestureDetector(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset(
              "assets/icons/arrow_back.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Stack(
            children: [_Image(imageUrl: "https://picsum.photos/250?image=9"), _BasicDetails()],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  String imageUrl;

  _Image({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = context.screenHeight / 2.4;

    return SizedBox(
      height: _height,
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
        width: context.screenWidth,
      ),
    );
  }
}

class _BasicDetails extends StatelessWidget {
  const _BasicDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = context.screenHeight / 1.6;
    double _topPadding = context.screenHeight / 2.55;

    return Positioned(
      top: _topPadding,
      child: Container(
        width: context.screenWidth,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: context.appTheme.theme.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: const [_TitleWithActionBtn(), _Rate(), _Genres(), _Description()],
          ),
        ),
      ),
    );
  }
}

class _TitleWithActionBtn extends StatefulWidget {
  const _TitleWithActionBtn({Key? key}) : super(key: key);

  @override
  State<_TitleWithActionBtn> createState() => _TitleWithActionBtnState();
}

class _TitleWithActionBtnState extends State<_TitleWithActionBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Batman the dark knight rises",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () => {},
            icon: Image.asset(
              "assets/icons/favourite_unselected.png",
            ),
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }
}

class _Rate extends StatelessWidget {
  const _Rate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: context.appTheme.theme.colorScheme.secondary,
        ),
        Text("8.4 / 10 IMDb")
      ],
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        padding: EdgeInsets.zero,
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: GenreCard(
                  title: "Comedy",
                  edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: 40,
        ),
        Text(
          "Description",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
