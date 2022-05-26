import 'package:audioplayers/audioplayers.dart';

class ReproduzirSons {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache player = AudioCache(prefix: "assets/audios/");

  bool audioIniciado = false;

  executarParar(String item) async {
    audioPlayer = await player.play(item + ".mp3");
  }
}
