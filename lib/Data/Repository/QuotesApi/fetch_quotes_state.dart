part of 'fetch_quotes_bloc.dart';

@immutable
abstract class FetchQuotesState {}

class FetchQuotesInitial extends FetchQuotesState {}

class SuccessfullyFetchedQuotesState extends FetchQuotesState{
  List<Map<String,dynamic>> quotes = [];
  SuccessfullyFetchedQuotesState({required this.quotes});
}

class FailedFetchedQuotesState extends FetchQuotesState{}

