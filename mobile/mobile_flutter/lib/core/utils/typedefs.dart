import 'package:dartz/dartz.dart';

import '../exception/api_exeption.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
