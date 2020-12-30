import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/bloc/favoritos_bloc.dart';
import 'package:mesa_news/models/news_detalhe_model.dart';
import 'file:///D:/Documents/Desenvolvimento/FlutterProjects/MesaNews/lib/screens/news/detalhes_news_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsTile extends StatelessWidget {
  final NewsDetalheModel news;

  NewsTile(this.news);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoritosBloc>(context);
    DateTime dataPublicacao = DateTime.parse(news.published_at);
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetalhesNewsScreen(news)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    news.image_url,
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<Map<String, NewsDetalheModel>>(
                    stream: bloc.outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                          icon: Icon(
                            snapshot.data.containsKey(news.title)
                                ? Icons.star
                                : Icons.star_border,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            bloc.toggleFavorite(news);
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Text(
                    timeago.format(dataPublicacao, locale: 'pt_BR'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Text(
                news.title,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news.description,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
