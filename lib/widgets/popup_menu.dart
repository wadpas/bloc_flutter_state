import 'package:bloc_flutter_state/actions/gallery_events.dart';
import 'package:bloc_flutter_state/bloc/gallery_block.dart';
import 'package:bloc_flutter_state/dialogs/delete_account_dialog.dart';
import 'package:bloc_flutter_state/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuActions { logout, deleteAccount }

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuActions>(
      onSelected: (value) async {
        switch (value) {
          case MenuActions.logout:
            final shouldLogOut = await showLogOutDialog(context);
            if (shouldLogOut) {
              context.read<GalleryBloc>().add(
                    const LogOut(),
                  );
            }
            break;
          case MenuActions.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              context.read<GalleryBloc>().add(
                    const DeleteAccount(),
                  );
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuActions>(
            value: MenuActions.logout,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuActions>(
            value: MenuActions.deleteAccount,
            child: Text('Delete Account'),
          ),
        ];
      },
    );
  }
}
