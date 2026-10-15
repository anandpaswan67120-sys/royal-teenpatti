import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const RoyalApp());

class RoyalApp extends StatelessWidget {
  const RoyalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF070B14),
      ),
      home: const CasinoLobby(),
    );
  }
}

class CasinoLobby extends StatefulWidget {
  const CasinoLobby({super.key});
  @override
  State<CasinoLobby> createState() => _CasinoLobbyState();
}

class _CasinoLobbyState extends State<CasinoLobby> {
  int chips = 5000;

  void addCashDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("⚡ Real UPI Instant Gateway", style: TextStyle(color: Colors.amber, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Deposit Amount:", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [100, 500, 1000].map((amt) => ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
                onPressed: () {
                  setState(() => chips += amt);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("₹$amt added via UPI!")));
                },
                child: Text("+₹$amt", style: const TextStyle(color: Colors.greenAccent)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F19),
        title: Row(
          children: [
            const CircleAvatar(radius: 14, backgroundColor: Colors.amber, child: Text("👑", style: TextStyle(fontSize: 14))),
            const SizedBox(width: 8),
            const Text("Player Anand", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: addCashDialog,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.amber)),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text("₹$chips", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 6),
                  const Icon(Icons.add_circle, color: Colors.green, size: 16),
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _gameBanner("🃏 TEEN PATTI (5-Player Table)", "Realistic Live Casino Oval Table with Bots", Colors.redAccent, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TeenPattiTable()));
          }),
          const SizedBox(height: 10),
          _gameBanner("⚡ ANDAR BAHAR", "Live Joker Match Card Dealing", Colors.teal, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AndarBaharTable()));
          }),
          const SizedBox(height: 10),
          _gameBanner("🐉 DRAGON VS TIGER", "Real Time 1-Card Clash Battle", Colors.orangeAccent, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const DragonTigerTable()));
          }),
        ],
      ),
    );
  }

  Widget _gameBanner(String title, String desc, Color col, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: col, width: 2),
        ),
        child: Row(
          children: [
            Icon(Icons.casino, size: 36, color: col),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: col)),
                  Text(desc, style: const TextStyle(fontSize: 11, color: Colors.white60)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

// ---------------- 1. REALISTIC TEEN PATTI ----------------
class TeenPattiTable extends StatefulWidget {
  const TeenPattiTable({super.key});
  @override
  State<TeenPattiTable> createState() => _TeenPattiTableState();
}

class _TeenPattiTableState extends State<TeenPattiTable> {
  int pot = 100;
  bool isSeen = false;
  String turn = "Aapki baari hai!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("5-Player Teen Patti Table"), backgroundColor: const Color(0xFF064E3B)),
      body: Container(
        color: const Color(0xFF022C22),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("🧔 Rohit (₹2400)", style: TextStyle(fontSize: 12)),
                Text("👩 Pooja (₹1900)", style: TextStyle(fontSize: 12)),
                Text("🧑 Rahul (₹3100)", style: TextStyle(fontSize: 12)),
              ],
            ),
            const Spacer(),
            Center(
              child: Container(
                width: 250,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF047857),
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.amber, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("TABLE POT", style: TextStyle(color: Colors.white70, fontSize: 10)),
                    Text("₹$pot", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber)),
                    Text(turn, style: const TextStyle(fontSize: 10, color: Colors.white60)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _cardBox(isSeen ? "A♠" : "🂠"),
                _cardBox(isSeen ? "K♥" : "🂠"),
                _cardBox(isSeen ? "Q♦" : "🂠"),
              ],
            ),
            TextButton(
              onPressed: () => setState(() => isSeen = !isSeen),
              child: Text(isSeen ? "BLIND (Hide Cards)" : "SEE CARDS (Patti Dekhein)", style: const TextStyle(color: Colors.amber)),
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
                      pot += 40;
                      turn = "Chaal Match hui!";
                    });
                  },
                  child: const Text("CHAAL ₹20"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                        backgroundColor: const Color(0xFF0F172A),
                        title: const Text("🏆 YOU WON!"),
                        content: Text("Aapne ₹$pot ka pot jeet liya!"),
                        actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("OK"))],
                      ),
                    );
                  },
                  child: const Text("SHOW"),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _cardBox(String txt) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 48,
      height: 68,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      alignment: Alignment.center,
      child: Text(txt, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: txt.contains("♥") || txt.contains("♦") ? Colors.red : Colors.black)),
    );
  }
}

// ---------------- 2. REALISTIC ANDAR BAHAR ----------------
class AndarBaharTable extends StatefulWidget {
  const AndarBaharTable({super.key});
  @override
  State<AndarBaharTable> createState() => _AndarBaharTableState();
}

class _AndarBaharTableState extends State<AndarBaharTable> {
  String status = "Andar ya Bahar choose karein!";
  List<String> andar = [];
  List<String> bahar = [];
  bool busy = false;

  void play(String side) {
    if (busy) return;
    setState(() {
      busy = true;
      andar.clear();
      bahar.clear();
      status = "Tash ke patte bat rahe hain...";
    });

    int count = 0;
    Timer.periodic(const Duration(milliseconds: 500), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (count % 2 == 0) {
          andar.add("K♦");
        } else {
          bahar.add("7♠");
        }
      });
      if (count >= 5) {
        t.cancel();
        setState(() {
          busy = false;
          status = "Match finished! $side jeet gaya!";
        });
      }
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Andar Bahar Live"), backgroundColor: const Color(0xFF042F2C)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text("JOKER: K♠", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 8),
            Text(status, style: const TextStyle(fontSize: 13, color: Colors.white70)),
            const Spacer(),
            Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Text("ANDAR: ", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                  ...andar.map((c) => Container(margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.all(4), color: Colors.white, child: Text(c, style: const TextStyle(color: Colors.red)))),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Text("BAHAR: ", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                  ...bahar.map((c) => Container(margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.all(4), color: Colors.white, child: Text(c, style: const TextStyle(color: Colors.black)))),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: busy ? null : () => play("Andar"), style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent), child: const Text("ANDAR")),
                ElevatedButton(onPressed: busy ? null : () => play("Bahar"), style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange), child: const Text("BAHAR")),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------- 3. DRAGON VS TIGER ----------------
class DragonTigerTable extends StatefulWidget {
  const DragonTigerTable({super.key});
  @override
  State<DragonTigerTable> createState() => _DragonTigerTableState();
}

class _DragonTigerTableState extends State<DragonTigerTable> {
  String d = "?";
  String t = "?";
  String res = "Dragon ya Tiger par tap karein";

  void fight(String side) {
    setState(() {
      int dN = Random().nextInt(13) + 1;
      int tN = Random().nextInt(13) + 1;
      d = "$dN";
      t = "$tN";
      if ((dN > tN && side == "Dragon") || (tN > dN && side == "Tiger")) {
        res = "🔥 $side Jeet Gaya!";
      } else {
        res = "❌ $side Haar gaya!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dragon vs Tiger"), backgroundColor: Colors.brown[900]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(res, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _card("DRAGON", d, Colors.red),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("VS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                _card("TIGER", t, Colors.amber),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => fight("Dragon"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("DRAGON")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: () => fight("Tiger"), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black), child: const Text("TIGER")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String val, Color c) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: c, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: 85,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: c, width: 2)),
          alignment: Alignment.center,
          child: Text(val, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
    );
  }
}
