import 'package:bloc_practice/features/post/persentation/bloc/post_bloc.dart';
import 'package:bloc_practice/features/post/persentation/bloc/post_event.dart';
import 'package:bloc_practice/features/post/persentation/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});
  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post List")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return CircularProgressIndicator();
          } else if (state is PostLoadedState) {
            return ListView.builder(
              itemCount: state.post.length,
              itemBuilder: (context, index) {
                final post = state.post[index];
                return ListTile(title: Text(post.title));
              },
            );
          } else if (state is PostErrorState) {
            return Text(state.error);
          }
          return Center(
            child: TextButton(
              onPressed: () {
                context.read<PostBloc>().add(PostFetchEvent());
              },
              child: Text("Load"),
            ),
          );
        },
      ),
    );
  }
}
