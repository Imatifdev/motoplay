import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

// State
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoadingState();

      try {
        // Simulate authentication process
        await Future.delayed(Duration(seconds: 2));

        // Check credentials (replace with your authentication logic)
        if (event.email == 'user@example.com' && event.password == 'password') {
          yield AuthLoggedInState();
        } else {
          yield AuthErrorState('Invalid credentials');
        }
      } catch (e) {
        yield AuthErrorState('An error occurred');
      }
    }
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedInState) {
              // Navigate to the next screen upon successful login
              // Navigator.pushReplacementNamed(context, '/home');
            }
          },
          builder: (context, state) {
            if (state is AuthInitialState || state is AuthLoadingState) {
              return _buildLoginForm(context);
            } else if (state is AuthErrorState) {
              return _buildLoginForm(context, errorMessage: state.error);
            } else {
              return Container(); // Handle other states if necessary
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, {String errorMessage = ''}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          if (errorMessage.isNotEmpty)
            Text(errorMessage, style: TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _passwordController.text;
              context.read<AuthBloc>().add(LoginEvent(email, password));
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
