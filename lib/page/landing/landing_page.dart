part of '../pages.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool? _isDokter = false;

  late Size size;
  double height = 0;
  double width = 0;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 4.0),
            Image.asset(
              "assets/landing.png",
              fit: BoxFit.cover,
              height: 250,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: AppTheme.darkerPrimaryColor,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          "Welcome!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Now it is easier for patients who want to consult with a doctor without having to leave home.",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Choose",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: false,
                              groupValue: _isDokter,
                              onChanged: (dynamic value) => setState(() {
                                _isDokter = value;
                              }),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                            ),
                            const Text(
                              'Patient',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(width: 4.0),
                            Radio(
                              value: true,
                              groupValue: _isDokter,
                              onChanged: (dynamic value) => setState(() {
                                _isDokter = value;
                              }),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                            ),
                            const Text(
                              'Doctor',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: SizedBox(
                            height: height / 16,
                            width: width / 3,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage(isDokter: _isDokter),
                                  ),
                                );
                              },
                              child: const Text(
                                "Continue",
                              ),
                              color: AppTheme.secondaryColor,
                              textColor: Colors.black,
                              disabledColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
