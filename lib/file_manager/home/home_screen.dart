import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/cubit/localstorage_cubit.dart';
import 'package:m_vd/file_manager/cubit/permission_cubit.dart';
import 'package:m_vd/file_manager/home/folders.dart';
import 'package:m_vd/file_manager/video/screens/video_screen.dart';

class HomeScrren extends StatelessWidget {
  const HomeScrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    final _topPadding = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(gradient: bgmGradient),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PermissionCubit()),
        ],
        child: Builder(builder: (BuildContext context) {
          return BlocListener<PermissionCubit, PermissionState>(
            listenWhen: (previous, current) {
              if (current is PermissionDenied || current is PermissionAccepted)
                return true;
              return false;
            },
            listener: (context, state) {
              if (state is PermissionDenied) {
                _showModelBottomSheet(context, () {
                  context.read<PermissionCubit>().requestPermission();
                });
              } else if (state is PermissionAccepted) {
                context.read<LocalstorageCubit>().getStorageFiles();
              }
            },
            child: Column(
              children: [
                _appBar(_topPadding),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        _storage(
                            name: 'Internal',
                            icon: Icons.phone_android,
                            context: context),
                        _sdCard(),
                        HomeFolders(),
                      ],
                    ),
                  ),
                ),
                // _recentVideo(_height)
              ],
            ),
          );
        }),
      ),
    );
  }

  Align _recentVideo(double _height) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: _height / 14,
        width: double.infinity,
        decoration: BoxDecoration(
          color: navColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(-1, -1),
              blurRadius: 4,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }

  Container _appBar(double _topPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, _topPadding + 6, 8.0, 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: navColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.black45,
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        'm_vd player',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.deepPurpleAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  BlocBuilder<LocalstorageCubit, LocalstorageState> _sdCard() {
    return BlocBuilder<LocalstorageCubit, LocalstorageState>(
      buildWhen: (previous, current) {
        if (current is LocalstorageError &&
            current.error == StorageErrors.sdCardNotPresent) return true;
        return false;
      },
      builder: (context, state) {
        if (state is LocalstorageError &&
            state.error == StorageErrors.sdCardNotPresent)
          return const SizedBox();
        return _storage(
            name: 'External', icon: Icons.sd_card, context: context);
      },
    );
  }

  Padding _storage(
      {required final String name,
      required final IconData icon,
      required final BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => _onInternalOrSdCardPress(name[0] + ':', context),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Text('$name Storage'),
            ),
          ],
        ),
      ),
    );
  }

  void _showModelBottomSheet(BuildContext context, Function onpress) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: navColor,
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Text('We need to acess your gallery'),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onpress();
                },
                child: Text('Grand'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // type I: for internal
  // type E: for external
  void _onInternalOrSdCardPress(final String type, final BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoScreen(
          filterString: type,
        ),
      ),
    );
  }
}
