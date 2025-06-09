import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";

import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";
import "package:geocoding/geocoding.dart" as geo;

import "../widgets/cep_input.dart";


class HomePage extends StatefulWidget 
{
  const HomePage({ super.key });

  @override
  State createState() 
  {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> 
{
  final TextEditingController _cepInputController = TextEditingController();
  final MapController _mapController = MapController();

  LatLng _mapCenter = LatLng(-15.7942, -47.8825);
  final double _mapSelectedZoom = 14.0;

  _HomePageState();

  void _buscaCep() async
  {
    // Pega o texto do input
    String cep = _cepInputController.text;

    // Pega os dados de endereço através de requisição http
    Uri uri = Uri.parse("https://brasilapi.com.br/api/cep/v2/$cep/");
    http.Response response = await http.get(uri, headers: { "Content-Type": "application/json" });
    var addressData = json.decode(response.body);

    // Atualiza a posição no mapa
    LatLng coordinates = await _pegaCoordenadas(addressData);
    setState(() {
      _mapCenter = coordinates;
    });
    _mapController.move(_mapCenter, _mapSelectedZoom);
  }

  Future<LatLng> _pegaCoordenadas(dynamic addressData) async
  {
    var addressCoordinates = addressData["location"]["coordinates"];

    // Se coordenadas já estão na resposta da api
    if (addressCoordinates["latitude"] != null || addressCoordinates["longitude"] != null) 
    {
      double latitude = double.parse(addressCoordinates["latitude"].toString());
      double longitude = double.parse(addressCoordinates["longitude"].toString());

      LatLng coordinates = LatLng(latitude, longitude);
      return coordinates;
    }

    // Monta String de endereço
    String bairro = addressData["neighborhood"] ?? "";
    String cidade = addressData["city"] ?? "";
    String estado = addressData["state"] ?? "";
    String address = "$bairro, $cidade, $estado, Brasil";

    // Pesquisa as coordenadas do endereço usando geocoding
    geo.Location? location = (await geo.locationFromAddress(address)).firstOrNull;
    if (location == null) throw Exception("Geocoding não conseguiu encontrar nenhuma localização!");

    return LatLng(location.latitude, location.longitude);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CEP para Mapa", 
          style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade800,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CEPInput(Icons.search, _buscaCep, _cepInputController), 
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _mapCenter,
                initialZoom: 4.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "ddm_av05",
                ),
                MarkerLayer(
                  rotate: true,
                  markers: [
                    Marker(point: _mapCenter, child: Icon(Icons.location_on), rotate: true)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}