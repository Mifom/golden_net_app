abstract class Failure {
}

class BasicFailure extends Failure {
  final String _message;

  BasicFailure(this._message);

  @override 
  String toString() => _message;
}