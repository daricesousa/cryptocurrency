import 'package:cryptocurrency/app/pages/count_page.dart';
import 'package:cryptocurrency/app/pages/currency_page.dart';
import 'package:cryptocurrency/app/pages/favorite_currency_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  var currencyPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currencyPage);
  }

  void setCurrencyPage(int page) {
    setState(() {
      currencyPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currencyPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Todas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favoritas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Conta",
          )
        ],
        onTap: (page) {
          pageController.animateToPage(page,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: setCurrencyPage,
        children: const [
          CurrencyPage(),
          FavoriteCurrencyPage(),
          CountPage(),
        ],
      ),
    );
  }
}
