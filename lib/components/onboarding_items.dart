import 'package:uts_mobprog_kelompok_2/models/onboarding.dart';

class OnboardingItems{
  List<Onboarding> items = [
    Onboarding(
        title: "Selamat datang di Utiwi",
        descriptions: "Aplikasi yang bikin hidup kamu lebih mudah dan nyaman. Siap bantu kebutuhan perjalananmu, kapan pun, dan dimana pun.",
        image: "assets/images/onboarding/onboarding1.png"),

    Onboarding(
        title: "Transportasi",
        descriptions: "Siap anterin kamu jalan, biar lebih gampang, tinggal klik-klik doang.",
        image: "assets/images/onboarding/onboarding2.png"),

    Onboarding(
        title: "Pembayaran Tunai",
        descriptions: "Pembayaran tunai akan mempermudah kamu untuk membayar langsung kepada pengemudi.",
        image: "assets/images/onboarding/onboarding3.png"),
  ];
 }