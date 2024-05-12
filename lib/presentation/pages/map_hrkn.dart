import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/favorites/favorites_bloc.dart';
import 'package:real_estaye_app/injection.dart';
import 'package:real_estaye_app/presentation/pages/map.dart';

class MapHrkn extends StatefulWidget {
  const MapHrkn({super.key});

  @override
  State<MapHrkn> createState() => _MapHrknState();
}

class _MapHrknState extends State<MapHrkn> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadedPostsState) {
          return MapPage(
            data: state.realEstate,
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {},
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<FavoritesBloc>(context).add(RefreshAllFavoritesEvent());
  }

  @override
  void initState() {
    getIt<PostsBloc>().add(GetMapEvent());
    super.initState();
  }
}
