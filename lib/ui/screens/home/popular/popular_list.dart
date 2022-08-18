import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:q_agency_task/_all.dart';

class PopularList extends StatefulWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state.status == MoviesStateStatus.error) {
          showInfoMessage(state.message ?? "An unexpected error happen, try again later", context);
        }
        if ((state.status == MoviesStateStatus.loaded || state.status == MoviesStateStatus.error) &&
            _refreshController.isLoading) {
          _refreshController.loadComplete();
        }
      },
      child: SmartRefresher(
        controller: _refreshController,
        onLoading: () => {
          if (context.moviesBloc.state.status != MoviesStateStatus.loadingNewPage)
            {
              context.moviesBloc.add(MoviesGetNextPageEvent()),
            }
        },
        enablePullDown: false,
        enablePullUp: true,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Popular",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state.status == MoviesStateStatus.loading) {
                    return Loader(
                      width: 100,
                      height: 100,
                      color: context.appTheme.theme.primaryColor,
                    );
                  } else if (state.movies.isEmpty) {
                    return const Text(
                      "No movies to show",
                      style: TextStyle(fontSize: 20),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.movies.length,
                      itemBuilder: (_, index) {
                        return PopularListItem(
                          movieModel: state.movies[index],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
