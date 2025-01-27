import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/task_app/features/authentication/controller/state/auth_state_provider.dart';
import 'package:task_app/task_app/features/authentication/view/sign_in.dart';
import 'package:task_app/task_app/features/authentication/view/sign_up.dart';
import 'package:task_app/task_app/features/authentication/view/splash.dart';
import 'package:task_app/task_app/features/authentication/view/welcome.dart';
import 'package:task_app/task_app/features/projects/view/projects_view.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: Splash.path,
  routes: [
    GoRoute(path: Splash.path, builder: (context, state) => Splash()),
    GoRoute(path: WelcomeView.path, builder: (context, state) => WelcomeView()),
    GoRoute(path: SignInView.path, builder: (context, state) => SignInView()),
    GoRoute(path: SignUpView.path, builder: (context, state) => SignUpView()),
    GoRoute(
        path: ProjectsView.path, builder: (context, state) => ProjectsView()),
  ],
  redirect: (context, state) {
    final authStateProvider = context.watch<AuthStateProvider>();
    final hasOnboarded = authStateProvider.hasOnboarded;
    final isSignedIn = authStateProvider.isSignedIn;

    //If the user has never used the app and the current screen is not the Welcome screen,
    // navigate to the Welcome screen and onboard the user.
    if (!hasOnboarded && state.path != WelcomeView.path) {
            print('onboard $hasOnboarded');
      return WelcomeView.path;
    }

    //If the user have previously used the app but is not currently signed in,
    // and the current screen is not the Sign in screen,
    // navigate to the Sign in screen.
    if (hasOnboarded && !isSignedIn && state.path != SignInView.path) {
      print('isSigned is $isSignedIn');
      return SignInView.path;
    }
    //if the user is signed in but the current screen is not he Home screen
    //navigate to the home screen.
    if (isSignedIn && state.path != ProjectsView.path) {
            print('home $isSignedIn');
      return ProjectsView.path;
    }
    return null;
  },
);
