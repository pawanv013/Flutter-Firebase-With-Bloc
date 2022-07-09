class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileFormValidState extends ProfileState {}

class ProfileSavelState extends ProfileState {
  late String saveSuccessMessage;
  ProfileSavelState(this.saveSuccessMessage);
}

class ProfileLoadingState extends ProfileState {}

class ProfileImageSetState extends ProfileState {}

class ProfileSaveErrorState extends ProfileState {
  late String saveErrorMessage;
  ProfileSaveErrorState(this.saveErrorMessage);
}
