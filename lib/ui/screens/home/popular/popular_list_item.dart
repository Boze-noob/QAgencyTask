import 'package:flutter/material.dart';
import '../../../../_all.dart';

class PopularListItem extends StatefulWidget {
  final MovieModel movieModel;

  const PopularListItem({Key? key, required this.movieModel}) : super(key: key);

  @override
  State<PopularListItem> createState() => _PopularListItemState();
}

class _PopularListItemState extends State<PopularListItem> {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MovieDetailsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          context.movieDetailsBloc
              .add(MovieDetailsGetEvent(genres: widget.movieModel.genres, movieId: widget.movieModel.id));
          Navigator.push(
            context,
            _createRoute(),
          );
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
                  return _FavouriteIcon(
                    movieModel: widget.movieModel,
                    favourites: state.movies,
                  );
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
                "${movieModel.voteAverage} / 10 IMDb",
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
                        title: movieModel.genres[index].value,
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
  final MovieModel movieModel;
  final List<MovieModel> favourites;

  const _FavouriteIcon({Key? key, required this.movieModel, required this.favourites}) : super(key: key);

  @override
  State<_FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<_FavouriteIcon> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.favourites.any((movie) => movie.id == widget.movieModel.id) ? true : false;
    return SizedBox(
      width: 24,
      child: Align(
        alignment: Alignment.topRight,
        child: BlocListener<FavouriteBloc, FavouriteState>(
          listener: (context, state) {
            if (state.status == FavouriteStateStatus.added) {
              context.favouriteBloc.add(FavouriteGetAllEvent());
            } else if (state.status == FavouriteStateStatus.error) {
              showInfoMessage(state.message ?? "Error happen, please try again!", context);
            } else if (state.status == FavouriteStateStatus.removed) {
              context.favouriteBloc.add(FavouriteGetAllEvent());
            }
          },
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
              }),
            },
            icon: Image.asset(_isSelected == true
                ? "assets/icons/favourite_selected_fill.png"
                : "assets/icons/favourite_unselected.png"),
          ),
        ),
      ),
    );
  }
}
