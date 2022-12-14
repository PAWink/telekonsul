part of '../pages.dart';

class ListTransactionUser extends StatefulWidget {
  const ListTransactionUser({Key? key}) : super(key: key);
  @override
  _ListTransactionUserState createState() => _ListTransactionUserState();
}

class _ListTransactionUserState extends State<ListTransactionUser> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  final List<TransactionModel> _searchResult = [];

  bool _isEmpty = false;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TransactionProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (value.listTransaction.isEmpty) {
              return const Center(
                child: Text("You don\'t have any transaction"),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    "List Transaction",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  _isEmpty
                      ? const Center(
                          child: Text("Search result empty"),
                        )
                      : Expanded(
                          child: _searchResult.isNotEmpty &&
                                  _controller.text.isNotEmpty
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    final item =
                                        _searchResult.toSet().toList()[index];

                                    return _transactionCard(item);
                                  },
                                  itemCount: _searchResult.toSet().length,
                                  shrinkWrap: true,
                                )
                              : ListView.builder(
                                  itemCount: value.listTransaction.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final item = value.listTransaction[index];

                                    return _transactionCard(item);
                                  },
                                ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _transactionCard(TransactionModel item) {
    return Card(
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TransactionDetail(transaction: item),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Transaction ID #${item.docId}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      DateFormat("dd MMMM yyyy").format(item.createdAt),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total : ",
                  ),
                  Text(
                    "\B${NumberFormat("#,###").format(item.consultationSchedule!.price)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status : ",
                  ),
                  StatusText(text: item.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
