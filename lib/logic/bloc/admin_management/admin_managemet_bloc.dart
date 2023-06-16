import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/auth_code_model.dart';
import '../../../models/user_model.dart';
import '../../db/db.dart';
import '../../local_storage_service.dart/local_storage.dart';

part 'admin_managemet_event.dart';
part 'admin_managemet_state.dart';

class AdminManagemetBloc
    extends Bloc<AdminManagemetEvent, AdminManagemetState> {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  AdminManagemetBloc({required this.auth, required this.storage})
      : super(AdminManagemetInitial()) {
    getAdminCode();
    alterAdminCode();
  }
  alterAdminCode() {
    on<AlterCodeEvent>((event, emit) async {
      try {
        emit(AdminManagemetLoading());
        await DB(auth: auth).alterAdminCode(event.adminCodes);
        emit(AdminManagemetAltered());
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  getAdminCode() {
    on<GetCodeEvent>((event, emit) async {
      try {
        emit(AdminManagemetLoading());
        var code = await DB(auth: auth).getAdminCode();
        LocalStorageService().getsaveToDisk('ADMIN_CODES',code!.toJson());
        emit(AdminManagemetLoaded(code));
        log('Codes: ${code.adminCode}');
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }
}
