name: Build APK

on:
  workflow_dispatch:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.6'
          channel: 'stable'

      - name: Generate App Source Code
        run: |
          flutter create --platforms=android myapp
          cat << 'EOF' > myapp/lib/main.dart
          import 'dart:async';
          import 'dart:math';
          import 'package:flutter/material.dart';

          void main() => runApp(const CasinoApp());

          class CasinoApp extends StatelessWidget {
            const CasinoApp({super.key});
            @override
            Widget build(BuildContext context) {
              return MaterialApp(
                title: 'Royal Teen Patti',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: const Color(0xFF0F172A),
                ),
                home: const HomeScreen(),
              );
            }
          }

          class GameState {
            static double balance = 1500.0;
            static double winning = 500.0;
          }

          class HomeScreen extends StatefulWidget {
            const HomeScreen({super.key});
            @override
            State<HomeScreen> createState() => _HomeScreenState();
          }

          class _HomeScreenState extends State<HomeScreen> {
            @override
            Widget build(BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xFF1E293B),
                  title: const Text("Royal Casino Club", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  actions: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text("₹${(GameState.balance + GameState.winning).toInt()}", style: const TextStyle(fontSize: 18, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                body: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _menuCard("🃏 Royal Teen Patti", "5 Players Table | Live Bots", Colors.amber, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TeenPattiScreen())).then((_) => setState(() {}));
                    }),
                    _menuCard("🐉 Dragon vs Tiger", "Instant 1 Card Showdown", Colors.redAccent, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const DragonTigerScreen())).then((_) => setState(() {}));
                    }),
                    _menuCard("⚡ Andar Bahar", "Classic 50-50 Match", Colors.teal, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AndarBaharScreen())).then((_) => setState(() {}));
                    }),
                    _menuCard("💰 My Wallet (Deposit/Withdraw)", "Add Cash & UPI Withdrawal", Colors.green, () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())).then((_) => setState(() {}));
                    }),
                  ],
                ),
              );
            }

            Widget _menuCard(String title, String subtitle, Color color, VoidCallback onTap) {
              return Card(
                color: const Color(0xFF1E293B),
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
                  subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber),
                  onTap: onTap,
                ),
              );
            }
          }

          class TeenPattiScreen extends StatefulWidget {
            const TeenPattiScreen({super.key});
            @override
            State<TeenPattiScreen> createState() => _TeenPattiScreenState();
          }

          class _TeenPattiScreenState extends State<TeenPattiScreen> {
            final List<String> deck = ["A♠", "K♥", "Q♦", "J♣", "10♠", "9♥", "A♦", "K♠", "Q♥"];
            bool seen = false;
            double pot = 100;
            String msg = "Aapki chaal hai!";

            @override
            Widget build(BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: const Text("Teen Patti Live Table"), backgroundColor: const Color(0xFF1E293B)),
                body: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("🧔 Rohit (₹2500)"),
                        Text("👩 Sneha (₹1800)"),
                        Text("🧑 Rahul (₹3000)"),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 260,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFF065F46),
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(color: Colors.amber, width: 3),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("POT AMOUNT"),
                              Text("₹${pot.toInt()}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
                              Text(msg, style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
                              _cardBox(seen ? deck[0] : "🂠"),
                              _cardBox(seen ? deck[1] : "🂠"),
                              _cardBox(seen ? deck[2] : "🂠"),
                            ],
                          ),
                          TextButton(
                            onPressed: () => setState(() => seen = !seen),
                            child: Text(seen ? "Hide Cards" : "SEE CARDS", style: const TextStyle(color: Colors.amber)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("PACK")),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    GameState.balance -= 20;
                                    pot += 40;
                                    msg = "Bots ne chaal match ki!";
                                  });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: const Text("CHAAL (₹20)"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    GameState.winning += pot;
                                    pot = 0;
                                    msg = "Aap jeet gaye!";
                                  });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
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

            Widget _cardBox(String txt) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 50,
                height: 70,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text(txt, style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold)),
              );
            }
          }

          class DragonTigerScreen extends StatefulWidget {
            const DragonTigerScreen({super.key});
            @override
            State<DragonTigerScreen> createState() => _DragonTigerScreenState();
          }

          class _DragonTigerScreenState extends State<DragonTigerScreen> {
            String res = "Bet lagayein!";
            void bet(String side) {
              setState(() {
                GameState.balance -= 50;
                if (Random().nextBool()) {
                  GameState.winning += 100;
                  res = "$side Jeet gaya! ₹100 add hue.";
                } else {
                  res = "$side Haar gaya!";
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
                      Text(res, style: const TextStyle(fontSize: 20, color: Colors.amberAccent)),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: () => bet("Dragon"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("DRAGON (₹50)")),
                          ElevatedButton(onPressed: () => bet("Tiger"), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black), child: const Text("TIGER (₹50)")),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }

          class AndarBaharScreen extends StatefulWidget {
            const AndarBaharScreen({super.key});
            @override
            State<AndarBaharScreen> createState() => _AndarBaharScreenState();
          }

          class _AndarBaharScreenState extends State<AndarBaharScreen> {
            String res = "Andar ya Bahar choose karein!";
            void bet(String side) {
              setState(() {
                GameState.balance -= 50;
                if (Random().nextBool()) {
                  GameState.winning += 100;
                  res = "$side Jeet gaya! ₹100 add hue.";
                } else {
                  res = "$side Haar gaya!";
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
                      const Text("Joker Card: K♠", style: TextStyle(fontSize: 24, color: Colors.amber)),
                      const SizedBox(height: 15),
                      Text(res, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: () => bet("Andar"), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text("ANDAR (₹50)")),
                          ElevatedButton(onPressed: () => bet("Bahar"), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text("BAHAR (₹50)")),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }

          class WalletScreen extends StatelessWidget {
            const WalletScreen({super.key});
            @override
            Widget build(BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: const Text("Wallet & Payment"), backgroundColor: const Color(0xFF1E293B)),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Deposit Chips: ₹${GameState.balance.toInt()}", style: const TextStyle(fontSize: 18, color: Colors.amber)),
                      Text("Winning Cash: ₹${GameState.winning.toInt()}", style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          GameState.balance += 500;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("₹500 added successfully via UPI!")));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 45)),
                        child: const Text("Add ₹500 via UPI"),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          if (GameState.winning >= 200) {
                            GameState.winning -= 200;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("₹200 withdrawal placed to UPI!")));
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 45)),
                        child: const Text("Withdraw ₹200 to UPI"),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          EOF

      - name: Build Android APK
        run: |
          cd myapp
          flutter build apk --debug

      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: Royal-TeenPatti-APK
          path: myapp/build/app/outputs/flutter-apk/app-debug.apk
