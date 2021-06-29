part of 'localstorage_cubit.dart';

abstract class LocalstorageState extends Equatable {
  const LocalstorageState();

  @override
  List<Object> get props => [];
}

class LocalstorageInitial extends LocalstorageState {}

class InternalLoaded extends LocalstorageState {}

class SdCardAndInternalLoaded extends LocalstorageState {}

class SdCardOnlyLoaded extends LocalstorageState {}

class InternalOnlyLoaded extends LocalstorageState {}

class LocalstorageError extends LocalstorageState {
  final StorageErrors error;
  LocalstorageError({required this.error});
}
