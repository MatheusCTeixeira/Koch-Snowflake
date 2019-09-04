
import "dart:core";
import "dart:math";

class Vector2D<T extends num> {
  T _x, _y;
  Vector2D(this._x, this._y);

  T get x => _x;
  T get y => _y;

  double get magnitude {
    return sqrt(_x * _x + _y * _y);
  }

  Vector2D<double> operator * (double scale){
    return Vector2D(_x * scale, _y * scale);
  }

  Vector2D<T> operator -(Vector2D other) {
    return Vector2D(_x - other._x, _y - other._y);
  }

  Vector2D<T> operator +(Vector2D other) {
    return Vector2D(_x + other._x, _y + other._y);
  }

  bool equals(Vector2D<double> other) {
    return _x == other._x && _y == other._y;
  }

  String toString(){
    var x = (_x as double).toStringAsFixed(2);
    var y = (_y as double).toStringAsFixed(2);
    return "($x, $y)";
  }

}

Vector2D<double> uVector(Vector2D<double> p0, Vector2D<double> pf) {
  var vector = pf - p0;
  var uy = (vector.y)/vector.magnitude;
  var ux = (vector.x)/vector.magnitude;
  var u = Vector2D<double>(uy, -ux);
  // if (u._y < 0) u = u * -1;
  return u * -1;
}

List<Vector2D<double>> buildKoch({int lvl, double width}) {
  var points = [Vector2D<double>(0,0), Vector2D<double>(width, 0)];

  List<Vector2D<double>> temp = [];
  for (int j = 0; j < lvl; ++j) {
    for (int i = 0; i < points.length - 1; ++i) {
      var p0 = points[i]; // ponto inicial
      var pf = points[i + 1]; // ponto final

      // Calcula o comprimento das semi-retas para os próximos geradores.
      // Neste caso, um terço da distância entre p0 e pf.
      var L = (pf - p0).magnitude/3;

      // Para cada semi-reta da iteração anterior, é inserido 3 novos pontos:
      // m1, m3 (que estão na semi-reta de p0 à pf) e m2 (que está ortogonal
      // a p0 e pf à uma distância de L*sqrt(3)/2).

      // ponto intermediário 1
      var m1 = p0 + (pf - p0)*(1/3);

      // ponto intermediário 2
      var pMed = p0 + (pf - p0)*(1/2);
      var uVec = uVector(p0, pf); // vetor unitário a p0 e pf.
      var m2 = pMed + uVec * (L * sqrt(3)/2);

      // ponto intermediário 3
      var m3 = p0 + (pf - p0)*(2/3);

      temp.addAll([p0, m1, m2, m3]);
    }

    // O ponto final só precisa ser adicionado uma vez. Nos seguimentos interme-
    // diários o ponto final de um é igual ao ponto inicial do sucessor.
    temp.add(points.last);

    points.clear(); // Remove os offsets da iteração anterior.
    points.addAll(temp);  // Adiciona os offsets da versão atual.
    temp.clear(); // Prepara para a nova iteração, se houver.
  }

  return points;
}

