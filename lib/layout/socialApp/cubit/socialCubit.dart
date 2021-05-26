import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/models/Posts.dart';
import 'package:sociaapp/models/message.dart';
import 'package:sociaapp/models/registermodel.dart';
import 'package:sociaapp/shared/components/constraint.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(InitalSocialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeIndex(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(CreatePostsState());
    } else {
      currentIndex = index;

      emit(ChangeBottomNavState());
    }
  }

  RegisterModel model;
  void getUser() {
    emit(SocialLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      model = RegisterModel.fromJson(value.data());

      emit(SocialSucessState());
    }).catchError((error) {
      print(error);
      emit(SocialErrorState(error));
    });
  }

  File profileImage;
  final picker = ImagePicker();
  Future<void> getprofileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    emit(SocialGetprofileImageState());
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      putprofileImage();
    } else {
      print('No image selected.');
      emit(SocialErrorprofileImageState());
    }
  }

  File coverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      putcoverImage();

      emit(SocialGetcoverImageState());
    } else {
      print('No image selected.');
      emit(SocialErrorcoverImageState());
    }
  }

  void putprofileImage() {
    emit(SocialPutprofileImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(image: value);
      }).catchError((error) {
        print(error);
        emit(SocialPutErrorprofileImageState());
      });
    }).catchError((error) {
      print(error);
    });
  }

  void putcoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(cover: value);
        emit(SocialPutcoverImageState());
      }).catchError((error) {
        print(error);
        emit(SocialPutErrorcoverImageState());
      });
    }).catchError((error) {
      print(error);
    });
  }

  Future updateUser(
      {String name,
      String bio,
      String phone,
      String cover,
      String image}) async {
    emit(SocialUpdateLoadingState());
    RegisterModel model2 = RegisterModel(
      userName: name ?? model.userName,
      email: model.email,
      phone: phone ?? model.phone,
      uid: uid,
      bio: bio ?? model.bio,
      cover: cover ?? model.cover,
      image: image ?? model.image,
      isemailverified: false,
    );
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .update(model2.toMap())
        .then((value) {
      getUser();
    }).catchError((onError) {
      emit(SocialUpdateErrorState());
    });
  }

  // posts//
  void removefile() {
    imagePost = null;
    emit(SocialRemoveImagePostErrorState());
  }

  File imagePost;

  Future<void> getImagePost() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePost = File(pickedFile.path);

      emit(SocialGetImagePostSucessState());
    } else {
      print('No image selected.');
      emit(SocialGetImagePostErrorState());
    }
  }

  void putImagePost({
    String date,
    String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(imagePost.path).pathSegments.last}')
        .putFile(imagePost)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPosts(date: date, imagePost: value, text: text);
        emit(SocialPutcoverImageState());
      }).catchError((error) {
        print(error);
        emit(SocialPutErrorcoverImageState());
      });
    }).catchError((error) {
      print(error);
    });
  }

  void createPosts({
    String date,
    String imagePost,
    String text,
  }) {
    emit(SocialCreatePostLoadingState());
    PostsModel model2 = PostsModel(
      userName: model.userName,
      image: model.image,
      uid: uid,
      date: date,
      text: text,
      imagepost: imagePost ?? '',
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(model2.toMap())
        .then((value) {
      emit(SocialCreatePostSucessState());
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostsModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialPostsLoadingState());
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes'). get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostsModel.fromJson(element.data()));
          element.reference.collection('Comment').get().then((value) {
            comments.add(value.docs.length);
          });
        }).catchError((error) {
          print(error);
          emit(SocialPostsErrorState(error));
        });
      });

      emit(SocialPostsSucessState());
    }).catchError((error) {
      print(error);
      emit(SocialPostsErrorState(error));
    });
  }

  void likePost({String path}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(path)
        .collection('Likes')
        .doc(model.uid)
        .set({
      'like': true,
    }).then((value) {

      emit(SocialLikeSucessState());
    }).catchError((error) {
      emit(SocialLikeErrorState(error.toString()));
    });
  }

  void CommentPost({String path}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(path)
        .collection('Comment')
        .doc(uid)
        .set({
      'Comment': true,
    }).then((value) {
      emit(SocialCommentSucessState());
    }).catchError((error) {
      emit(SocialCommentErrorState(error.toString()));
    });
  }

  List<RegisterModel> users = [];
  void getUsers() {
    emit(SocialAllUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['Uid'] != model.uid)
            users.add(RegisterModel.fromJson(element.data()));
        });

        emit(SocialAllUsersSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({String data, String receiveId, String text}) {
    MessageModel mesage = MessageModel(
      dataTime: data,
      senderId: model.uid,
      receiveId: receiveId,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .collection('Chats')
        .doc(receiveId)
        .collection('Messages')
        .add(mesage.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    //
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiveId)
        .collection('Chats')
        .doc(model.uid)
        .collection('Messages')
        .add(mesage.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessage({@required String receiveId}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .collection('Chats')
        .doc(receiveId)
        .collection('Messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
