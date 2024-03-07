part of 'fetch_quotes_bloc.dart';

@immutable
abstract class FetchQuotesEvent {}


//fetch quotes event,it is called when user lands on exercise page associated with categories
class StartFetchingQuotesEvent extends FetchQuotesEvent{}
