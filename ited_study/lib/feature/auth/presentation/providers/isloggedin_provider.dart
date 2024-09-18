// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../core/providers/providers.dart';
// import '../../domain/usecases/isloggedin_usecase.dart';

// enum IsLoggedInStatus { initial, loggedIn, loggedOut }

// class IsLoggedInState {
//   final IsLoggedInStatus status;
//   IsLoggedInState({this.status = IsLoggedInStatus.loggedOut});
//   IsLoggedInState copyWith({IsLoggedInStatus? status}) {
//     return IsLoggedInState(status: status ?? this.status);
//   }
// }

// class IsLoggedInNotifier extends StateNotifier<IsLoggedInState> {
//   final IsLoggedInUsecase isLoggedInUsecase;

//   IsLoggedInNotifier(this.isLoggedInUsecase) : super(IsLoggedInState()) {
//     checkLoginStatus();
//   }

//   Future<void> checkLoginStatus() async {
//     try {
//       final isLoggedIn = await isLoggedInUsecase();
//       state = state.copyWith(
//         status:
//             isLoggedIn ? IsLoggedInStatus.loggedIn : IsLoggedInStatus.loggedOut,
//       );
//     } catch (e) {
//       state = state.copyWith(status: IsLoggedInStatus.loggedOut);
//     }
//   }
// }

// final isLoggedInNotifierProvider =
//     StateNotifierProvider<IsLoggedInNotifier, IsLoggedInState>((ref) {
//   return IsLoggedInNotifier(ref.read(isLoggedInUsecaseProvider));
// });
