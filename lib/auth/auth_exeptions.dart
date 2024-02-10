class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}
class InvalidCreditionalsAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}
class EmailAlreadyInUseAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}

class GenericAuthException implements Exception {}

class UserNotLoggedInException implements Exception {}

class UserPermissionDeniedException implements Exception {}

class QuotaExceededException implements Exception {}

class GenericFirestoreException implements Exception {}
