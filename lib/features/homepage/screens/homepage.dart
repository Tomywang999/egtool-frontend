import 'package:egtool/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:egtool/features/aicorrection/screens/ai_correction.dart';
import 'package:egtool/features/aihelper/ai_helper/ai_helper.dart';
import 'package:egtool/features/auth/services/auth_service.dart';

class homepage extends StatefulWidget {
  static const String routeName = '/homepage';

  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  AuthService authService = AuthService();
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    //const home(),
    const AiCorrectionScreen(),
    const AIHelperScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Image.asset('images/logo.png',
                    height: 60), // replace with your logo asset
                //_buildNavItem(0, 'Home'),
                _buildNavItem(0, 'AI Correction'),
                _buildNavItem(1, 'AI Helper'),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () => authService.signOutUser(context),
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: GlobalVariables.TextWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) =>
                              GlobalVariables.Selected,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          Expanded(
            child: _tabs[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
          child: Text(title),
          onPressed: () => _onItemTapped(index),
        ),
        Container(
          height: 2,
          width: 60,
          color: _selectedIndex == index
              ? GlobalVariables.Selected
              : Colors.transparent,
        ),
      ],
    );
  }
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
