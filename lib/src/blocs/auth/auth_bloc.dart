import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => _validateAuthInput(event, emit));
  }
}

Future<void> _validateAuthInput(AuthEvent event, emit) async {
  String userName = 'desafio';
  String password = 'flutterbloc';
  
  if (event is Login) {
    if (event.userName.isEmpty || event.password.isEmpty) {
      emit(AuthError());
    } else if(event.userName != userName || event.password != password) {
      emit(AuthIncorrectCredentials());
    } else {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3), () {
        emit(AuthLoaded(event.userName));
      });
    }
  }
}
