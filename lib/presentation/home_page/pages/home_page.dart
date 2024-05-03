import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/proerty_widget.dart';

class HomePageClean extends StatefulWidget {
  const HomePageClean({super.key});

  @override
  State<HomePageClean> createState() => _HomePageCleanState();
}

class _HomePageCleanState extends State<HomePageClean> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PropertWidget(
                realEstae: state.realEstate,
              ));
        } else if (state is LoadedPostsState) {
          return PropertWidget(
            realEstae: state.realEstate,
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {},
    );

  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshAllPostEvent());
  }
}
