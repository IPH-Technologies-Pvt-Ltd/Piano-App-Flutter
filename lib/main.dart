import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Piano(),
    );
  }
}

class PianoKey extends StatelessWidget {
  final String soundName;
  final VoidCallback onPressed;

  const PianoKey({super.key, required this.soundName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        soundName,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

enum KeyColor { WHITE, BLACK }

class PianoKey2 extends StatelessWidget {
  final KeyColor color;
  final double width;
  final int midiNote;

  const PianoKey2.white({
    required this.width,
    required this.midiNote,
  }) : this.color = KeyColor.WHITE;

  const PianoKey2.black({
    required this.width,
    required this.midiNote,
  }) : this.color = KeyColor.BLACK;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color == KeyColor.WHITE ? Colors.white : Colors.black,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
    );
  }
}

class Piano extends StatefulWidget {
  const Piano({Key? key}) : super(key: key);

  @override
  _PianoState createState() => _PianoState();
}

class _PianoState extends State<Piano> {
  final octaveNumber = 3;

  get octaveStartingNote => (octaveNumber * 12) % 128;

  List notes = [
    'piano.wav',
    'piano2.wav',
    'note1.wav',
    'note2.wav',
    'note3.wav',
    'note4.wav',
    'note5.wav',
    'note6.wav',
    'note7.wav',
  ];

  Future<void> playSound(int key) async {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/${notes[key]}"),
    );
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final whiteKeySize = constraints.maxWidth / 7;
        final blackKeySize = whiteKeySize / 2;
        return Stack(
          children: [
            _buildWhiteKeys(whiteKeySize),
            _buildBlackKeys(constraints.maxHeight, blackKeySize, whiteKeySize),
          ],
        );
      },
    );
  }

  _buildWhiteKeys(double whiteKeySize) {
    return Row(
      children: [
        GestureDetector(
          onTap: ()=> playSound(0),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote,
          ),
        ),
        GestureDetector(
          onTap: ()=> playSound(2),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote + 2,
          ),
        ),
        GestureDetector(
          onTap: ()=> playSound(3),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote + 4,
          ),
        ),
        GestureDetector(
          onTap: ()=> playSound(4),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote + 5,
          ),
        ),
        GestureDetector(
          onTap: ()=> playSound(5),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote + 7,
          ),
        ),
        GestureDetector(
          onTap: ()=> playSound(6),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote + 9,
          ),
        ),
        GestureDetector(
          onTap: ()=>playSound(7),
          child: PianoKey2.white(
            width: whiteKeySize,
            midiNote: octaveStartingNote + 11,
          ),
        )
      ],
    );
  }

  _buildBlackKeys(
      double pianoHeight, double blackKeySize, double whiteKeySize) {
    return SizedBox(
      height: pianoHeight * 0.55,
      child: Row(
        children: [
          SizedBox(
            width: whiteKeySize - blackKeySize / 2,
          ),
          PianoKey2.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 1,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey2.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 3,
          ),
          SizedBox(
            width: whiteKeySize,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey2.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 6,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey2.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 8,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey2.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 10,
          ),
        ],
      ),
    );
  }
}

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 400,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: 600,
                  color: Colors.white,
                  child: Image.asset('assets/birthday.png',fit: BoxFit.cover,),
                ),
                Container(
                  height: 1,
                  width: 600,
                  color: Colors.grey,
                ),
                Container(
                  height: 350,
                  width: 600,
                  color: Colors.white,
                  ),
              ],
            ),
            const Positioned(
              top: 100,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.orange,
                    foregroundImage: NetworkImage('https://images.pexels.com/photos/997512/pexels-photo-997512.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("NISHA PATEL",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("FLUTTER DEVELOPER",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 35,
                  ),
                  Text("Today is her birthday say congrats",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
