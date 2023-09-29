class Failure {
  final String message;
  //si on veut debugger
  final StackTrace stackTrace;
  //positional constructor
  const Failure(
    this.message,
    this.stackTrace,
    );
}