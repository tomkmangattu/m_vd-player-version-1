import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_option/either_option.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/data/folder%20class.dart';
import 'package:m_vd/file_manager/data/storage_data.dart';
import 'package:m_vd/file_manager/video/cubit/thumbnail_cubit.dart';

part 'localstorage_state.dart';

class LocalstorageCubit extends Cubit<LocalstorageState> {
  final StorageData _storageData = StorageData();
  late final Folders internalFolders;
  late final Folders externalFolders;

  final ThumbnailCubit thumbnailCubit;

  LocalstorageCubit({
    required this.thumbnailCubit,
  }) : super(LocalstorageInitial());

  Future getStorageFiles() async {
    await _getInternalStf();
    await _getSdCardStf();
  }

  Future<void> _getSdCardStf() async {
    final Either<FoldersError, Folders> result =
        await _storageData.getSdCardStorgInfo();
    externalFolders = result.fold((FoldersError foldersError) {
      _onSdCardLoadingError(foldersError.storageErrors);
      return Folders(videoFolders: {}, audioFolders: {});
    }, (folders) {
      return folders;
    });
    if (result.isRight) {
      _onSdCardLoaded();
    }
  }

  void _onSdCardLoadingError(final StorageErrors error) {
    if (state is InternalLoaded) {
      emit(InternalOnlyLoaded());
      thumbnailCubit.initialise(infolders: internalFolders.videoFolders);
    } else if (state is LocalstorageError) {
      LocalstorageError(error: error);
    }
  }

  void _onSdCardLoaded() {
    if (state is InternalLoaded) {
      emit(SdCardAndInternalLoaded());
      thumbnailCubit.initialise(
          infolders: internalFolders.videoFolders,
          exfolders: externalFolders.videoFolders);
    } else if (state is LocalstorageError) {
      emit(SdCardOnlyLoaded());
      thumbnailCubit.initialise(exfolders: externalFolders.videoFolders);
    }
  }

  Future<void> _getInternalStf() async {
    final Either<FoldersError, Folders> result =
        await _storageData.getInternelStorgInfo();
    internalFolders = result.fold((FoldersError foldersError) {
      emit(LocalstorageError(error: foldersError.storageErrors));
      return Folders(videoFolders: {}, audioFolders: {});
    }, (folders) {
      emit(InternalLoaded());
      return folders;
    });
  }
}
