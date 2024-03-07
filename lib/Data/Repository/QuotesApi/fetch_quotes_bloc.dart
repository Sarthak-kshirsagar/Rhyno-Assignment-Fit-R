import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'fetch_quotes_event.dart';
part 'fetch_quotes_state.dart';

//bloc to fetch the quotes from api

class FetchQuotesBloc extends Bloc<FetchQuotesEvent, FetchQuotesState> {
  FetchQuotesBloc() : super(FetchQuotesInitial()) {
    on<StartFetchingQuotesEvent>(_fetchQuotes);
  }

  //fetches the quotes fromapi and return the list of fetched quotes
  Future<List<Map<String, dynamic>>> fetchQuotes() async {
    final response =
    await http.get(Uri.parse("https://dummyjson.com/quotes"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> quotesData = data['quotes'];
      final _quotes = List<Map<String, dynamic>>.from(quotesData);
      print(_quotes);
      return _quotes;
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  //list of fetched quotes is passed to state being emitted
  FutureOr<void> _fetchQuotes(StartFetchingQuotesEvent event, Emitter<FetchQuotesState> emit) async{
    print("event called");
      try{
        final quotes = await fetchQuotes(); // Call the fetchQuotes method
        emit(SuccessfullyFetchedQuotesState(quotes: quotes));

      }catch(e){
        emit(FailedFetchedQuotesState());
      }
  }
}
