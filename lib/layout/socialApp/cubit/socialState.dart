abstract class SocialState {}

class InitalSocialState extends SocialState {}

class SocialLoadingState extends SocialState {}

class SocialSucessState extends SocialState {}

class SocialErrorState extends SocialState {
  final String error;

  SocialErrorState(this.error);
}
class SocialPostsLoadingState extends SocialState {}

class SocialPostsSucessState extends SocialState {}

class SocialPostsErrorState extends SocialState {
  final String error;

  SocialPostsErrorState(this.error);
}

class ChangeBottomNavState extends SocialState {}

class CreatePostsState extends SocialState {}

class SocialGetprofileImageState extends SocialState {}

class SocialErrorprofileImageState extends SocialState {}

class SocialPutprofileImageState extends SocialState {}

class SocialPutErrorprofileImageState extends SocialState {}

class SocialGetcoverImageState extends SocialState {}

class SocialErrorcoverImageState extends SocialState {}

class SocialPutcoverImageState extends SocialState {}

class SocialPutErrorcoverImageState extends SocialState {}

class SocialUpdateLoadingState extends SocialState {}

class SocialUpdateErrorState extends SocialState {}

class SocialGetImagePostSucessState extends SocialState {}

class SocialGetImagePostErrorState extends SocialState {}

class SocialRemoveImagePostErrorState extends SocialState {}

class SocialCreatePostSucessState extends SocialState {}

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}
class SocialLikeSucessState extends SocialState {}

class SocialLikeErrorState extends SocialState {
  final String error;

  SocialLikeErrorState(this.error);
}
class SocialCommentSucessState extends SocialState {}

class SocialCommentErrorState extends SocialState {
  final String error;

  SocialCommentErrorState(this.error);
}
class SocialAllUsersLoadingState extends SocialState {}

class SocialAllUsersSucessState extends SocialState {}

class SocialAllUsersErrorState extends SocialState {
  final String error;

  SocialAllUsersErrorState(this.error);
}
class SocialSendMessageSuccessState extends SocialState {}

class  SocialSendMessageErrorState extends SocialState {}
class  SocialGetMessageSuccessState extends SocialState {}

class  SocialGetMessageErrorState extends SocialState {}