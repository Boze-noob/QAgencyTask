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
    return BlocListener<MovieDetailsBloc, MovieDetailsState>(
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          showInfoMessage(state.message, context);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                AppAssets.arrowBack,
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
            child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, state) {
                if (state.status == MovieDetailsStateStatus.loading) {
                  return Loader(
                    width: 100,
                    height: 100,
                    color: context.appTheme.theme.primaryColor,
                  );
                }
                return Stack(
                  children: [
                    _Image(imageUrl: state.movieDetailsModel.posterPath),
                    const _BasicDetails(),
                  ],
                );
              },
            ),
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

    return InteractiveViewer(
      child: CachedNetworkImage(
        imageUrl: imageUrl.toNetworkImageUrl(),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        width: context.screenWidth,
        height: _height,
        errorWidget: (context, url, err) => Image.asset(
          AppAssets.logo,
        ),
        placeholder: (context, url) => Image.asset(AppAssets.logo),
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
            children: [
              BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, movieDetailsState) {
                  return BlocListener<FavouriteBloc, FavouriteState>(
                    listener: (context, state) {
                      if (state.status == FavouriteStateStatus.added) {
                        context.favouriteBloc.add(FavouriteGetAllEvent());
                      } else if (state.status == FavouriteStateStatus.error) {
                        showInfoMessage(state.message ?? "Error happen, please try again!", context);
                      } else if (state.status == FavouriteStateStatus.removed) {
                        context.favouriteBloc.add(FavouriteGetAllEvent());
                      }
                    },
                    child: BlocBuilder<FavouriteBloc, FavouriteState>(
                      builder: (context, favouriteState) {
                        return _TitleAndFavouriteIcon(
                          favourites: favouriteState.movies,
                          movieDetailsModel: movieDetailsState.movieDetailsModel,
                        );
                      },
                    ),
                  );
                },
              ),
              const _Rate(),
              const _Genres(),
              const _Description(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleAndFavouriteIcon extends StatefulWidget {
  final List<MovieModel> favourites;
  final MovieDetailsModel movieDetailsModel;

  const _TitleAndFavouriteIcon({Key? key, required this.favourites, required this.movieDetailsModel}) : super(key: key);

  @override
  State<_TitleAndFavouriteIcon> createState() => _TitleWithActionBtnState();
}

class _TitleWithActionBtnState extends State<_TitleAndFavouriteIcon> {
  bool _isSelected = false;
  bool _glowAnimation = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.favourites.any((movie) => movie.id == widget.movieDetailsModel.id) ? true : false;
  }

  Timer scheduleTimeout([int milliseconds = 1000]) => Timer(Duration(milliseconds: milliseconds), handleTimeout);

  void handleTimeout() {
    setState(() {
      _isSelected = !_isSelected;
      _glowAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.movieDetailsModel.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            onPressed: () => {
              scheduleTimeout(),
              setState(() {
                _glowAnimation = true;
              }),
              if (!_isSelected)
                {
                  context.favouriteBloc.add(FavouriteAddEvent(movieModel: widget.movieDetailsModel.toMovieModel())),
                }
              else
                {
                  context.favouriteBloc.add(FavouriteRemoveEvent(movieId: widget.movieDetailsModel.id)),
                },
            },
            icon: AvatarGlow(
                glowColor: const Color(0xFFB60533),
                animate: _glowAnimation,
                endRadius: 150,
                child: Image.asset(_getIcon())),
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }

  String _getIcon() {
    if (_glowAnimation) {
      return AppAssets.favouriteFill;
    } else if (_isSelected) {
      return AppAssets.favouriteSelected;
    } else {
      return AppAssets.favouriteUnselected;
    }
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
        BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            return Text("${state.movieDetailsModel.voteAverage.roundTo(1)} / 10 IMDb");
          },
        )
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
            Expanded(
              child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, state) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.movieDetailsModel.genres.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: GenreCard(
                        title: state.movieDetailsModel.genres[index],
                        edgeInsets: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      ),
                    ),
                  );
                },
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
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Description",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            return Text(
              state.movieDetailsModel.overview,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            );
          },
        ),
      ],
    );
  }
}
