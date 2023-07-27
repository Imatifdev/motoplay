import 'package:flutter/material.dart';

import '../utils/mycolors.dart';

class DMCA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: blue,
          title: Text(
            "Configuracion",
            style: TextStyle(fontSize: 32),
          ),
          iconTheme: IconThemeData(color: Colors.grey.shade200),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ExpandableTile(
                title: 'Enlaces de videos',
                content:
                    'Los enlaces que figuran en esta página web han sido encontrados en páginas de la índole de Youtube, Dlive.tv, Vimeo.com, Digiload.co, Mystream.to, Uqload.com, Fembed.com, Tu.tv, Openload.co, Bigfile.to, Streamcloud.eu, allmyvideos.net, 1fichier.com, streamin.to, hugefiles.net, powvideo.net, uptobox.com, flashx.tv, ul.to, hqq.tv, mp4upload.com, yourupload.com, nowvideo.sx, etc. Y desconocemos si los mismos tienen contratos de cesión de derechos sobre estos videos para reproducirlos, alojarlos o permitir su descarga.',
              ),
              ExpandableTile(
                title: 'Marcas y logos',
                content:
                    'Todas las marcas aquí mencionadas y logos están registrados por sus legítimos propietarios y solamente se emplean en referencia a las mismas y con un fin de cita o comentario, de acuerdo con el articulo 32 LPI.',
              ),
              ExpandableTile(
                title: 'Responsabilidad de uso indebido',
                content:
                    'No nos hacemos responsables del uso indebido que puedas hacer del contenido de nuestra aplicación.',
              ),
              ExpandableTile(
                title: 'Responsabilidad por ilícito uso de información',
                content:
                    'En ningún caso o circunstancia se podrá responsabilizar directamente o indirectamente al propietario ni a los colaboradores del ilícito uso de la información contenida en MotoPlay.',
              ),
              ExpandableTile(
                title: 'Responsabilidad por incorrecto uso de información',
                content:
                    'Así mismo tampoco se nos podrá responsabilizar directamente o indirectamente de incorrecto uso o mala interpretación que se haga de la información y servicios incluidos. Igualmente quedara fuera de nuestra responsabilidad el material al que usted pueda acceder desde nuestros enlaces.',
              ),
              ExpandableTile(
                title: 'Prohibición en países',
                content:
                    'Si en tu país, este tipo de página está prohibido, tú y solo tú eres el responsable de la entrada a MotoPlay.',
              ),
              ExpandableTile(
                title: 'Aceptación de condiciones',
                content:
                    'Si decides permanecer en nuestra aplicación, quiere decir que has leído, comprendido y aceptas las condiciones de esta página.',
              ),
              ExpandableTile(
                title: 'Contenido de libre distribución',
                content:
                    'Todo el contenido ha sido exclusivamente sacado de sitios públicos de Internet, por lo que este material es considerado de libre distribución. En ningún artículo legal se menciona la prohibición de material libre por lo que esta página no infringe en ningún caso la ley. Si alguien tiene alguna duda o problema al respecto, no dude en ponerse en contacto con nosotros.',
              ),
              ExpandableTile(
                title: 'Cumplimiento de derechos de propiedad intelectual',
                content:
                    'Todo la información y programas aquí recogidos van destinados al efectivo cumplimiento de los derechos recogidos en el artículo 31 RD/1/1996 por el que se aprueba el texto refundido de la Ley de la Propiedad Intelectual (LPI) en especial referencia al artículo 31.2 LPI, y en concordancia con lo expresado en el artículo 100.2 de esta misma ley.',
              ),
              ExpandableTile(
                title: 'Derecho de veto y prohibición de uso',
                content:
                    'Nos reservamos el derecho de vetar la entrada a cualquier sujeto a nuestra página aplicación y a su vez se reserva el derecho de prohibir el uso de cualquier programa y/o información, en concordancia con los derechos de autor otorgados por el artículo 14 LPI.',
              ),
              ExpandableTile(
                title: 'Aviso de acceso a contenido externo',
                content:
                    'La visita o acceso a esta página web, que es de carácter privado y no público, exige la aceptación del presente aviso. En esta web se podrá acceder a contenidos publicados por Youtube, Dlive.tv, Vimeo.com, Tu.tv, Openload.co, Bigfile.to, Streamcloud.eu, allmyvideos.net, 1fichier.com, streamin.to, hugefiles.net, powvideo.net, uptobox.com, cuevana3.io, flashx.tv, ul.to, hqq.tv, mp4upload.com, yourupload.com, nowvideo.sx, etc. El único material que existe en la web son enlaces ha dicho contenido, facilitando únicamente su visionado. Los propietarios de Youtube, Digiload.co, Mystream.to, Uqload.com, Tu.tv, Openload.co, Bigfile.to, Streamcloud.eu, allmyvideos.net, 1fichier.com, streamin.to, hugefiles.net, powvideo.net, uptobox.com, flashx.tv, ul.to, hqq.tv, mp4upload.com, yourupload.com, nowvideo.sx, etc. son plenamente responsables de los contenidos que publiquen. Por consiguiente, MotoPlay ni aprueba, ni hace suyos los productos, servicios, contenidos, información, datos, opiniones archivos y cualquier clase de material existente en Youtube, Dlive.tv, Vimeo.com, Digiload.co, Mystream.to, Uqload.com, Tu.tv, Openload.co, Bigfile.to, Streamcloud.eu, allmyvideos.net, 1fichier.com, streamin.to, hugefiles.net, powvideo.net, uptobox.com, flashx.tv, ul.to, hqq.tv, mp4upload.com, yourupload.com, nowvideo.sx, etc. y no controla ni se hace responsable de la calidad, licitud, fiabilidad y utilidad de la información, contenidos y servicios existentes en Youtube, Tu.tv, Openload.co, Bigfile.to, Streamcloud.eu, allmyvideos.net, 1fichier.com, streamin.to, hugefiles.net, powvideo.net, uptobox.com, flashx.tv, ul.to, hqq.tv, mp4upload.com, yourupload.com, nowvideo.sx, etc.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableTile extends StatefulWidget {
  final String title;
  final String content;

  ExpandableTile({required this.title, required this.content});

  @override
  _ExpandableTileState createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.content),
          ),
        ],
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        initiallyExpanded: isExpanded,
      ),
    );
  }
}
