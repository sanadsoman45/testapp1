import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:test_app/core/network_info.dart';
import 'package:test_app/features/passwordscreen/passwordscreenbloc.dart';
import 'package:test_app/features/passwordscreen/passwordscreenevent.dart';
import 'package:test_app/features/passwordscreen/passwordscxreenstate.dart';
import 'package:test_app/injection.dart';

class PasswordScreen extends StatelessWidget {
  final String routeName;
  const PasswordScreen({Key? key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenDimensions =
        size.height > size.width ? size.height : size.width;
    debugPrint(ModalRoute.of(context)?.settings.name);

    final networkInfo = serviceLocator<NetworkInfo>();
    final connectionFuture = networkInfo.initialize();

    return Scaffold(
      body: Material(
        // Wrap the Column with Material widget
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => serviceLocator.get<PasswordBloc>())
          ],
          child: BlocConsumer<PasswordBloc, PasswordState>(
            listener: (context, state) {
              if (context.read<PasswordBloc>().state.errorMessage != "") {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content:
                        Text(context.read<PasswordBloc>().state.errorMessage)));
              }
            },
            builder: (context, state) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200, // Specify the desired height
                    width: 200, // Specify the desired width
                    child: Lottie.asset("assets/images/password.json"),
                  ),
                  Visibility(
                    visible: routeName == 'changepass',
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Set border color here
                        ),
                        borderRadius:
                            BorderRadius.circular(10), // Set border radius here
                      ),
                      height: screenDimensions * 0.1,
                      width: screenDimensions * 0.5,
                      child: TextFormField(
                        onChanged: (value) {
                          context
                              .read<PasswordBloc>()
                              .add(PasswordEvent(password: value));
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Password",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Set border color here
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius here
                    ),
                    height: screenDimensions * 0.1,
                    width: screenDimensions * 0.5,
                    child: TextFormField(
                      onChanged: (value) {
                        context
                            .read<PasswordBloc>()
                            .add(NewPasswordEvent(newPassword: value));
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Password",
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Set border color here
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius here
                    ),
                    height: screenDimensions * 0.1,
                    width: screenDimensions * 0.5,
                    child: TextFormField(
                      onChanged: (value) {
                        context
                            .read<PasswordBloc>()
                            .add(ReNewPasswordEvent(renewPasswd: value));
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Renter New Password",
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<PasswordBloc>().add(PassSubmit(
                            pageName: routeName,
                            emailId: "sanad03052000@gmail.com",
                            newPassword:
                                context.read<PasswordBloc>().state.newPassword,
                            renewPassword: context
                                .read<PasswordBloc>()
                                .state
                                .renewPassword,
                            password:
                                context.read<PasswordBloc>().state.password));
                      },
                      child: Text("Click")),
                  FutureBuilder(
                    future: serviceLocator<NetworkInfo>().checkConnection(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While the future is still resolving
                        return CircularProgressIndicator();
                      } else {
                        // Once the future resolves
                        final isConnected = snapshot.data ?? false;
                        return Text(isConnected ? 'Connected' : 'Disconnected');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
