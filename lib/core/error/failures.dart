abstract class Failures {
  final String message;
  Failures(this.message);
}

class SomeError extends Failures {
  SomeError(super.message);
}
