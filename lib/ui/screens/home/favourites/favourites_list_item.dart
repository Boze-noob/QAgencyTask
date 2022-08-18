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
      child: GestureDetector(
        onTap: () {
          context.movieDetailsBloc
              .add(MovieDetailsGetEvent(genres: widget.movieModel.genres, movieId: widget.movieModel.id));
          Navigator.push(context, NavigationScaleTransition(widget: const MovieDetailsScreen()));
        },
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
              BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, state) {
                  return Align(
                      alignment: Alignment.topRight,
                      child: _FavouriteIcon(
                        movieModel: widget.movieModel,
                      ));
                },
              )
            ],
          ),
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
            movieModel.title,
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
                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: GenreCard(
                        title: movieModel.genres[index],
                        edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
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
  MovieModel movieModel;

  _FavouriteIcon({Key? key, required this.movieModel}) : super(key: key);

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
            if (!_isSelected)
              {
                context.favouriteBloc.add(FavouriteAddEvent(movieModel: widget.movieModel)),
              }
            else
              {
                context.favouriteBloc.add(FavouriteRemoveEvent(movieId: widget.movieModel.id)),
              },
            setState(() {
              _isSelected = !_isSelected;
            })
          },
          icon: Image.asset(_isSelected == true ? AppAssets.favouriteSelected : AppAssets.favouriteUnselected),
        ),
      ),
    );
  }
}
