import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../models/recently_deleted_model.dart';
import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../config/date_time_formats.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';
import '../../../auth_views/login.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';

class RecentlyDeleted extends StatefulWidget {
  static const routeName = '/main.recently.deleted';

  const RecentlyDeleted({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentlyDeleted> createState() => _RecentlyDeletedState();
}

class _RecentlyDeletedState extends State<RecentlyDeleted> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashBoardBloc, DashBoardState>(
          listener: (context, state) {
            if (state is DashBoardFetched) {
              OverlayService.closeAlert();
            }
            if (state is DashBoardLoading) OverlayService.showLoading();
            if (state is DashBoardFailed) OverlayService.closeAlert();

            if (state is DashBoardFetched && !state.user.enabled) {
              Alertify.error(message: 'Your account has been disabled');
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.routeName, (_) => false);
            }
          },
        ),
      ],
      child: Scaffold(
        drawer: SideMenu(),
        appBar: (Responsive.isMobile(context))
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(kdefaultPadding),
                  child: Header(title: 'Recently Deleted', onPressed: () {}),
                ))
            : null,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                const Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              BlocConsumer<DashBoardBloc, DashBoardState>(
                listener: (context, state) {},
                builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return PageContentWidget(
                      columns: [
                        DataColumn(
                          label: Text(
                            "DATE TYPE",
                            style: GoogleFonts.dmSans(
                                color: kSecondaryColor, fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "DELETED AT",
                            style: GoogleFonts.dmSans(
                                color: kSecondaryColor, fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "DESCRIPTION",
                            style: GoogleFonts.dmSans(
                                color: kSecondaryColor, fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Performed by | Action",
                            style: GoogleFonts.dmSans(
                                color: kSecondaryColor, fontSize: 15),
                          ),
                        ),
                      ],
                      row: List.generate(
                        fetched ? state.recentlyDeleted.length : 0,
                        (index) => (recentFileDataRow(
                            fetched ? state.recentlyDeleted[index] : null,
                            context)),
                      ),
                      title: 'Recently Deleted');
                },
              ),
            ],
          ),
        ),
        floatingActionButton: CustomFloatingActionBtn(
          onPressed: () {
            BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
          },
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(RecentlyDeletedModel? notice, context) {
  return DataRow(
    onLongPress: () {},
    cells: [
      DataCell(
        Text(
          notice!.dataType,
          style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
        ),
      ),
      DataCell(Text(
        dateWithTime.format(notice.time!).toLowerCase(),
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        notice.description..toLowerCase(),
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        notice.data,
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
    ],
  );
}
