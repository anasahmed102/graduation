import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/widgets/loading_widget.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/presentation/search_page/pages/new_search_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: NewSeearchPage(
                data: state.realEstate,
              ));
        } else if (state is LoadedPostsState) {
          return NewSeearchPage(
            data: state.realEstate,
          );
        } else {
          return const LoadingWidget();
        }
      },
      listener: (context, state) {},
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshAllPostEvent());
  }
}
