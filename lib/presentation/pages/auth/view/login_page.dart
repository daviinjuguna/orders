import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:order_app/injection/injection.dart';
import 'package:order_app/presentation/presentation.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ThemeData get theme => Theme.of(context);
  TextTheme get textTheme => Theme.of(context).textTheme;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case FormzSubmissionStatus.inProgress:
            context.loadingSnackbar();
            break;
          case FormzSubmissionStatus.success:
            context.hideSnackBar();
            break;
          case FormzSubmissionStatus.failure:
            context.errorSnackbar(state.error);
            break;
          default:
        }
      },
      child: Scaffold(
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              Text(
                "Welcome back",
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: context.read<AuthCubit>().emailChanged,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return state.email.isNotValid
                          ? "Email is not valid"
                          : null;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    onChanged: context.read<AuthCubit>().passwordChanged,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return state.password.isNotValid
                          ? "Password must be at least 6 characters"
                          : null;
                    },
                  );
                },
              ),

              const SizedBox(height: 20),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    previous.loginValid != current.loginValid,
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: theme.colorScheme.onPrimary,
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    onPressed: state.loginValid
                        ? context.read<AuthCubit>().login
                        : null,
                    child: const Text("Login"),
                  );
                },
              ),
              //already did this
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New to this experience?'),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return TextButton(
                        onPressed: state.status ==
                                FormzSubmissionStatus.inProgress
                            ? null
                            : () {
                                context.router.navigate(const RegisterRoute());
                              },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text('Register'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
