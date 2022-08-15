import 'package:q_agency_task/_all.dart';

class FavouritesList extends StatefulWidget {
  const FavouritesList({Key? key}) : super(key: key);

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Favourites",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              if (state.status == FavouriteStateStatus.init || state.status == FavouriteStateStatus.loading) {
                return Loader(
                  width: 100,
                  height: 100,
                  color: context.appTheme.theme.primaryColor,
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.movies.length,
                  itemBuilder: (_, index) {
                    return FavouritesListItem(
                      movieModel: state.movies[index],
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
