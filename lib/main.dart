import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_tutorial/cubit/post_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PostCubit(),
        child: const Post(),
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    getPost() {
      context.read<PostCubit>().getPosts();
    }

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          return state.when(
            initial: () => ElevatedButton(
              child: const Text('Get Post'),
              onPressed: () {
                getPost();
              },
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: () => ElevatedButton(
              child: const Text('Tap to retry'),
              onPressed: () {
                getPost();
              },
            ),
            loaded: (post) => ListView.builder(
              itemCount: post.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(post[index].title),
                  subtitle: Text(post[index].body),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
