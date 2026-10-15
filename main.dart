import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0F172A)),
      home: const LoginView(),
    );
  }
}

class Store {
  static String user = "Anand";
  static String avatar = "🦁";
  static int dep = 1000;
  static int win = 500;
  static int get total => dep + win;
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final nameC = TextEditingController(text: "Anand");
  final icons = ["🦁", "👑", "😎", "🐯"];
  String sel = "🦁";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.casino, size: 70, color: Colors.amber),
              const SizedBox(height: 10),
              const Text("VIP CASINO LOGIN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: icons.map((e) => GestureDetector(
                  onTap: () => setState(() => sel = e),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: sel == e ? Colors.amber : Colors.black45),
                    child: Text(e, style: const TextStyle(fontSize: 26)),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 20),
              TextField(controller: nameC, decoration: const InputDecoration(labelText: "Player Nickname", filled: true)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(45)),
                onPressed: () {
                  Store.user = nameC.text;
                  Store.avatar = sel;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LobbyView()));
                },
                child: const Text("ENTER CASINO", style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LobbyView extends StatefulWidget {
  const LobbyView({super.key});
  @override
  State<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends State<LobbyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: Row(
          children: [
            Text(Store.avatar, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(Store.user, style: const TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          Center(child: Text("₹${Store.total}  ", style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold))),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: Colors.amber),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletView())).then((_) => setState(() {})),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card("🃏 Realistic Teen Patti", "5 Player Table with AI Bots", Colors.redAccent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TeenPattiView())).then((_) => setState(() {}))),
          _card("🐉 Dragon vs Tiger", "Instant 1 Card War", Colors.orangeAccent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DragonView())).then((_) => setState(() {}))),
          _card("⚡ Andar Bahar", "Classic 50-50 Joker Match", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AndarView())).then((_) => setState(() {}))),
          _card("💰 Add Cash & Withdraw", "Instant UPI Deposit/Withdraw", Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletView())).then((_) => setState(() {}))),
        ],
      ),
    );
  }

  Widget _card(String t, String s, Color c, VoidCallback f) {
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: c)),
        subtitle: Text(s, style: const TextStyle(color: Colors.white60)),
        trailing: const Icon(Icons.play_circle_fill, color: Colors.amber, size: 30),
        onTap: f,
      ),
    );
  }
}

class TeenPattiView extends StatefulWidget {
  const TeenPattiView({super.key});
  @override
  State<TeenPattiView> createState() => _TeenPattiViewState();
}

class _TeenPattiViewState extends State<TeenPattiView> {
  final deck = ["A♠", "K♥", "Q♦", "J♣", "10♠", "9♥", "A♦", "K♠", "Q♥"];
  bool seen = false;
  int pot = 100;
  String turn = "Aapki chaal hai!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("5-Player Teen Patti Table"), backgroundColor: const Color(0xFF1E293B)),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("🧔 Rohit (₹2500)"),
              Text("👩 Sneha (₹1800)"),
              Text("🧑 Rahul (₹3000)"),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 270,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFF065F46),
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: Colors.amber, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("POT AMOUNT", style: TextStyle(color: Colors.white70)),
                    Text("₹$pot", style: const TextStyle(fontSize: 32, color: Colors.amber, fontWeight: FontWeight.bold)),
                    Text(turn, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1E293B),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _patti(seen ? "A♠" : "🂠"),
                    _patti(seen ? "K♥" : "🂠"),
                    _patti(seen ? "Q♦" : "🂠"),
                  ],
                ),
                TextButton(
                  onPressed: () => setState(() => seen = !seen),
                  child: Text(seen ? "HIDE CARDS" : "SEE CARDS (Patti Dekhein)", style: const TextStyle(color: Colors.amber)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("PACK"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        setState(() {
                          Store.dep -= 20;
                          pot += 40;
                          turn = "Bots ne chaal match ki!";
                        });
                      },
                      child: const Text("CHAAL (₹20)"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      onPressed: () {
                        setState(() {
                          Store.win += pot;
                          pot = 0;
                          turn = "Aap Jeet Gaye!";
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aap Jeet Gaye! Pot Winning me add hua.")));
                      },
                      child: const Text("SHOW"),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _patti(String c) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 50,
      height: 70,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      alignment: Alignment.center,
      child: Text(c, style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}

class DragonView extends StatefulWidget {
  const DragonView({super.key});
  @override
  State<DragonView> createState() => _DragonViewState();
}

class _DragonViewState extends State<DragonView> {
  String msg = "Bet lagayein";
  void play(String s) {
    setState(() {
      Store.dep -= 50;
      if (Random().nextBool()) {
        Store.win += 100;
        msg = "$s Jeet gaya! ₹100 add hue.";
      } else {
        msg = "$s Haar gaya!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dragon vs Tiger"), backgroundColor: const Color(0xFF1E293B)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(msg, style: const TextStyle(fontSize: 18, color: Colors.amber)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () => play("Dragon"), child: const Text("DRAGON (₹50)")),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black), onPressed: () => play("Tiger"), child: const Text("TIGER (₹50)")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AndarView extends StatefulWidget {
  const AndarView({super.key});
  @override
  State<AndarView> createState() => _AndarViewState();
}

class _AndarViewState extends State<AndarView> {
  String msg = "Choose Andar ya Bahar";
  void play(String s) {
    setState(() {
      Store.dep -= 50;
      if (Random().nextBool()) {
        Store.win += 100;
        msg = "$s Jeet gaya! ₹100 add hue.";
      } else {
        msg = "$s Haar gaya!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Andar Bahar"), backgroundColor: const Color(0xFF1E293B)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Joker: K♠", style: TextStyle(fontSize: 26, color: Colors.amber, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text(msg, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: () => play("Andar"), child: const Text("ANDAR (₹50)")),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange), onPressed: () => play("BAHAR (₹50)"), child: const Text("BAHAR (₹50)")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WalletView extends StatefulWidget {
  const WalletView({super.key});
  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final upi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet & Payment"), backgroundColor: const Color(0xFF1E293B)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deposit Cash: ₹${Store.dep}", style: const TextStyle(fontSize: 18, color: Colors.amber)),
            Text("Winning Cash: ₹${Store.win}", style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size.fromHeight(45)),
              onPressed: () {
                setState(() => Store.dep += 500);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("₹500 added via UPI!")));
              },
              child: const Text("Add ₹500 via UPI"),
            ),
            const SizedBox(height: 20),
            TextField(controller: upi, decoration: const InputDecoration(labelText: "UPI ID (GPay/PhonePe)", filled: true)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(45)),
              onPressed: () {
                if (Store.win >= 200 && upi.text.isNotEmpty) {
                  setState(() => Store.win -= 200);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("₹200 withdrawal placed!")));
                }
              },
              child: const Text("Withdraw ₹200 to UPI"),
            ),
          ],
        ),
      ),
    );
  }
}
