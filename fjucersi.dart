main() {
  uradi();
}

void uradi() async {
  task1();
  String rezultat2 = await task2();
  task3(rezultat2);
}

void task1() {
  print('zadatak 1');
}

Future task2() async {
  String vracka;
  Duration trajanje = Duration(seconds: 3);
  print('pocetak 2');
  await Future.delayed(trajanje);
  print('zadatak 2');
  return vracka = 'vracka sa 2';
}

void task3(text) {
  print('zadatak 3 i vidi sta je ovjde $text');
}
