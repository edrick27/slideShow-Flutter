import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {

  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;  


  SlideShow({
    @required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = Colors.red,
    this.colorSecundario = Colors.black45,
    this.bulletPrimario = 20.0,
    this.bulletSecundario = 12.0
  });

   @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => _SliderModel(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Builder( 
              builder: (BuildContext context){

                final sliderModel = Provider.of<_SliderModel>(context, listen: false);
                sliderModel.colorPrimario = this.colorPrimario;
                sliderModel.colorSecundario = this.colorSecundario;
                sliderModel.bulletPrimario = this.bulletPrimario;
                sliderModel.bulletSecundario = this.bulletSecundario;


                return CreateStructure(puntosArriba: puntosArriba, slides: slides);
              }
            )
          ),
        ),
      ),
    );

  }
}

class CreateStructure extends StatelessWidget {
  
  const CreateStructure({
    @required this.puntosArriba,
    @required this.slides,
  });

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if(this.puntosArriba) _dots(this.slides.length),
        Expanded(
          child: _Slides(this.slides)
        ),
        if(!this.puntosArriba) _dots(this.slides.length),
      ],
    );
  }
}


class _dots extends StatelessWidget {

  int count = 0;

  _dots(this.count);
  

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.blue[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(count, (i) => _dot(i))
      )
    );
  }

}

class _dot extends StatelessWidget {

  final int index;

  _dot( this.index);

  @override
  Widget build(BuildContext context) {

    final slideShowModel =  Provider.of<_SliderModel>(context);
    Color color;
    double tamano;

    if (slideShowModel.currentPage >= index - 0.5 && slideShowModel.currentPage < index + 0.5) {
      color = slideShowModel.colorPrimario;
      tamano = slideShowModel.bulletPrimario;
    } else {
       color = slideShowModel.colorSecundario;
       tamano = slideShowModel.bulletSecundario;
    }
  
    return AnimatedContainer(
      duration: Duration(microseconds: 500),
      width:  tamano,
      height: tamano,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      )
    );
  
  }
    
}

class _Slides extends StatefulWidget {

   List<Widget> slides;

  _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {

  final _pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    _pageViewController.addListener((){
      Provider.of<_SliderModel>(context, listen: false).currentPage = _pageViewController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
       child: PageView(
         controller: _pageViewController,
         children: widget.slides.map((slide) => _slide(slide)).toList()
       )
    );
  }
}

class _slide extends StatelessWidget {

  final Widget slide;
  
  _slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide
    );
  }
}

class _SliderModel with ChangeNotifier {
  
  double _currentPage = 0;
  Color _colorPrimario;
  Color _colorSecundario;
  double _bulletPrimario;
  double _bulletSecundario;

  double get bulletPrimario => _bulletPrimario;

  set bulletPrimario(double value) {
    _bulletPrimario = value; 
  }

  double get bulletSecundario => _bulletSecundario;

  set bulletSecundario(double value) {
    _bulletSecundario = value; 
  }

  double get currentPage => this._currentPage;

  Color get colorPrimario => this._colorPrimario;

  set colorPrimario(Color color) {
    this._colorPrimario = color;
  }
  
  Color get colorSecundario => this._colorSecundario;

  set colorSecundario(Color color) {
    this._colorSecundario = color;
  }

  set currentPage( double currentPage) {

    this._currentPage = currentPage;

    notifyListeners();

  }

}