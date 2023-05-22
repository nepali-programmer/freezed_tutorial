import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

import '../model/post.dart';

part 'post_state.dart';
part 'post_cubit.freezed.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState.initial());

  getPosts() async {
    try {
      emit(const PostState.loading());
      Dio dio = Dio();
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        List<Post> post = response.data.map<Post>((e) {
          return Post.fromJson(e);
        }).toList();
        emit(PostState.loaded(post));
      } else {
        emit(const PostState.error());
      }
    } catch (e) {
      emit(const PostState.error());
    }
  }
}
