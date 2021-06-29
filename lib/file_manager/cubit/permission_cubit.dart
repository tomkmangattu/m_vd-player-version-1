import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final storagePermisssion = Permission.storage;
  PermissionStatus? permissionStatus;
  PermissionCubit() : super(PermissionInitial()) {
    checkForPermission();
  }

  Future<void> checkForPermission() async {
    permissionStatus = await storagePermisssion.status;
    print(permissionStatus.toString());
    if (permissionStatus == PermissionStatus.granted) {
      emit(PermissionAccepted());
    } else {
      emit(PermissionDenied());
    }
  }

  Future<void> requestPermission() async {
    permissionStatus = await storagePermisssion.request();
    if (permissionStatus == PermissionStatus.granted)
      emit(PermissionAccepted());
    else {
      emit(PermissionDeniedAgain());
    }
  }
}
