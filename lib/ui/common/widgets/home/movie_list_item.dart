import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/bloc/movie/movie_bloc.dart';
import 'package:personal/core/app_routes.dart';
import 'package:personal/ui/common/widgets/home/movie_box_item.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key, required this.state}) : super(key: key);
  final MovieState state;

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  late MovieState state;

  @override
  void initState() {
    super.initState();
    state = widget.state;
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
            crossAxisCount: 2),
        itemCount: state.hasReachedMax
            ? state.movies!.length
            : state.movies!.length + 1,
        controller: _scrollController,
        addAutomaticKeepAlives: true,
        restorationId: "some id",
        itemBuilder: (BuildContext context, int index) {
          if (index >= state.movies!.length) {
            return _buildBottom();
          }

          return MovieBoxItem(
            movie: state.movies![index],
            onItemClick: () {
              Navigator.of(context).pushNamed(AppRoutes.DETAIL_PAGE,
                  arguments: state.movies![index]);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<MoviesBloc>().add(const FetchMoviesEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _onRefresh() async {
    if (_isBottom) context.read<MoviesBloc>().add(const RefreshEvent());
  }

  Widget _buildBottom() {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
