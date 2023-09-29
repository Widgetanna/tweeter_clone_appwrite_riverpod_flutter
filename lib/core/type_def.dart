import 'package:fpdart/fpdart.dart';
import 'package:tweeter_clone_flutter/core/core.dart';



typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
//on peut laisser soit supprimer
typedef FutureVoid = Future<void>;