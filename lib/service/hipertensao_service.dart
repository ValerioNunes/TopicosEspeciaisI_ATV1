import 'package:topicos1atv1/model/pressao_arterial.dart';
import 'package:topicos1atv1/model/quadro_pressao_arterial.dart';

class HipertensaoService{

  static bool _compararNiveis(PressaoArterial pressaoArterial,int  Maxmin , int Maxmax, int Minmin, int Minmax){

    if((Maxmax > 0) && (Minmax > 0))
      return ((pressaoArterial.maxima >= Maxmin &&  pressaoArterial.maxima <= Maxmax) && (pressaoArterial.minima >= Minmin &&  pressaoArterial.minima <= Minmin));
    if(Maxmax < 0 && Minmax > 0 )
      return ((pressaoArterial.maxima >= Maxmin) && (pressaoArterial.minima >= Minmin &&  pressaoArterial.minima <= Minmin));
    if(Maxmax < 0 && Minmax < 0 )
      return ((pressaoArterial.maxima >= Maxmin) && (pressaoArterial.minima >= Minmin ));

    return false;
  }
  
  static QuadroPressaoArterial getQuadroParaPressaoArterial(PressaoArterial pressaoArterial){

    if(_compararNiveis(pressaoArterial, 100, 129, 60, 84))
      return QuadroPressaoArterial.Pressao_Normal;
    if(_compararNiveis(pressaoArterial, 130, 139, 85, 89))
      return QuadroPressaoArterial.Limitrofe;
    if(_compararNiveis(pressaoArterial, 140, -1, 90, -1))
      return QuadroPressaoArterial.Alta;

    return QuadroPressaoArterial.ForaDeRange;
  }

}