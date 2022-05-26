import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/video.dart';

const chaveYoutubeAPI = "AIzaSyB5sb7LtLh7dsKlYqRblDI1r2PJwQBIIjU";
const idCanal = "UCE4_joeelEHYvDFnagGtmQg";
const urlBase = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    var url = Uri.parse(urlBase +
        "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$chaveYoutubeAPI"
            "&channelId=$idCanal"
            "&q=$pesquisa");

    http.Response response = await http.get(url);

    var retorno = json.decode(response.body);

    Map<String, dynamic> item = retorno;

    List<Video> videos = [];

    for (var vid in item["items"]) {
      Video v = Video(
        vid["id"]["videoId"],
        vid["snippet"]["title"],
        vid["snippet"]["description"],
        vid["snippet"]["thumbnails"]["high"]["url"],
        vid["snippet"]["channelTitle"],
      );

      videos.add(v);
    }
    return videos;
  }
}
