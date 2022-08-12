import 'package:flutter/material.dart';
import '../../../../_all.dart';

class PopularListItem extends StatefulWidget {
  const PopularListItem({Key? key}) : super(key: key);

  @override
  State<PopularListItem> createState() => _PopularListItemState();
}

class _PopularListItemState extends State<PopularListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: const [MovieImage(), Expanded(child: Details()), ActionIcon()],
        ),
      ),
    );
  }
}

class MovieImage extends StatelessWidget {
  const MovieImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://picsum.photos/250?image=9",
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Green Book",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.star,
                color: context.appTheme.theme.colorScheme.secondary,
              ),
              const SizedBox(
                width: 5.33,
              ),
              const Text(
                "8.2 / 10 IMDb",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: SizedBox(
              height: 21,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return const GenreCard();
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class ActionIcon extends StatefulWidget {
  const ActionIcon({Key? key}) : super(key: key);

  @override
  State<ActionIcon> createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: IconButton(
        iconSize: 24,
        onPressed: () => {
          setState(() {
            _isSelected = !_isSelected;
          })
        },
        icon: Image.asset(
            _isSelected == true ? "assets/icons/favourite_selected_fill.png" : "assets/icons/favourite_unselected.png"),
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  const GenreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: const [
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              "Comedy",
              style: TextStyle(fontSize: 11),
            ),
          ),
        )
      ],
    );
  }
}
