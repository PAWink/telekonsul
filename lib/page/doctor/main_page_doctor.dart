part of '../pages.dart';

class MainPageDoctor extends StatefulWidget {
  const MainPageDoctor({Key? key}) : super(key: key);
  @override
  _MainPageDoctorState createState() => _MainPageDoctorState();
}

class _MainPageDoctorState extends State<MainPageDoctor> {
  late Size size;
  double height = 0;
  double width = 0;

  Doctor? currentUser;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        size = MediaQuery.of(context).size;
        height = size.height;
        width = size.width;
        currentUser = context.read<DoctorProvider>().doctor!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hello, ${currentUser?.name ?? 'Loading...'}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 24),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      backgroundImage: currentUser?.profileUrl != "" &&
                              currentUser?.profileUrl != null
                          ? NetworkImage(currentUser?.profileUrl ??
                              'https://t3.ftcdn.net/jpg/03/01/90/80/360_F_301908021_RjCnnJ6IBq1iuJ1rATp0vhqH4Q4l0LcH.jpg')
                          : null,
                      child: currentUser?.profileUrl != "" &&
                              currentUser?.profileUrl != null
                          ? null
                          : const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    'assets/login.png',
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Call with friend",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<QueueProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (value.listQueue.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Don\'t sharing car today"),
                      );
                    }

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.listQueue.length,
                        itemBuilder: (context, index) {
                          final item = value.listQueue[index];

                          return _queueCard(item);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Manage",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddConsultationSchedule(),
                        ),
                      );
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    title: const Text("Add Sharing car"),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const ListConsultationSchedule(),
                        ),
                      );
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.darkerPrimaryColor,
                      child: Icon(Icons.date_range, color: Colors.white),
                    ),
                    title: const Text("Your post"),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ListPasien(),
                        ),
                      );
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                      child: Icon(Icons.assignment_ind, color: Colors.white),
                    ),
                    title: const Text("Who want to go with you"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _patientCard(UserModel item) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey,
                  backgroundImage: item.profileUrl != ""
                      ? NetworkImage(item.profileUrl!)
                      : null,
                  child: item.profileUrl != ""
                      ? null
                      : const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${item.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _queueCard(Queue item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0, right: 5),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey,
            backgroundImage: item.transactionData!.createdBy!.profileUrl != ""
                ? NetworkImage(item.transactionData!.createdBy!.profileUrl!)
                : null,
            child: item.transactionData!.createdBy!.profileUrl != ""
                ? null
                : const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name ${item.transactionData!.createdBy!.name}",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Price \B${NumberFormat("#,###").format(item.transactionData!.consultationSchedule!.price)}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "${item.transactionData!.consultationSchedule!.startAt!.format(context)} - ${item.transactionData!.consultationSchedule!.endAt!.format(context)}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConsultationPage(
                      queue: item,
                    ),
                  ),
                );
              },
              color: AppTheme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text("Call"),
            ),
          ],
        ),
      ],
    );
  }
}
