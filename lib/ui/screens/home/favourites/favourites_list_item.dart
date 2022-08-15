import 'package:flutter/material.dart';
import '../../../../_all.dart';

class FavouritesListItem extends StatefulWidget {
  final MovieModel movieModel;
  const FavouritesListItem({Key? key, required this.movieModel}) : super(key: key);

  @override
  State<FavouritesListItem> createState() => _FavouritesListItemState();
}

class _FavouritesListItemState extends State<FavouritesListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            MovieImage(
              imageUrl: widget.movieModel.posterPath.toNetworkImageUrl(),
            ),
            Expanded(
                child: _Details(
              movieModel: widget.movieModel,
            )),
            const Align(alignment: Alignment.topRight, child: _FavouriteIcon())
          ],
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final MovieModel movieModel;
  const _Details({Key? key, required this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieModel.originalTitle,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
              Text(
                "${movieModel.voteAverage.roundTo(1)} / 10 IMDb",
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
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
                  itemCount: movieModel.genres.length,
                  itemBuilder: (_, index) {
                    return GenreCard(
                      title: movieModel.genres[index],
                      edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class _FavouriteIcon extends StatefulWidget {
  const _FavouriteIcon({Key? key}) : super(key: key);

  @override
  State<_FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<_FavouriteIcon> {
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          alignment: Alignment.topRight,
          color: Colors.red,
          iconSize: 24,
          padding: EdgeInsets.zero,
          onPressed: () => {
            setState(() {
              _isSelected = !_isSelected;
            })
          },
          icon: Image.asset(_isSelected == true
              ? "assets/icons/favourite_selected_fill.png"
              : "assets/icons/favourite_unselected.png"),
        ),
      ),
    );
  }
}
