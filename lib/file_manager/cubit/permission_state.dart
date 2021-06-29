part of 'permission_cubit.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

class PermissionInitial extends PermissionState {}

class PermissionDenied extends PermissionState {}

class PermissionAccepted extends PermissionState {}

class PermissionDeniedAgain extends PermissionState {}
