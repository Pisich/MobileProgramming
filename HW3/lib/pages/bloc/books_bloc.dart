import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:equatable/equatable.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  List<dynamic> _resultList = [];
  BooksBloc() : super(BooksInitial()) {
    on<BooksSearchEvent>(_findBook);
  }

  List<dynamic> get getResultList => _resultList;
  Future<FutureOr<void>> _findBook(BooksSearchEvent event, emit) async {
    emit(BooksLoadingState());

    var res = await _findBooksFromTitle(event.query);
    for (int i = 0; i < res.length; i++) {
      if (res[i]["volumeInfo"]["imageLinks"] == null) continue;
      String desc =
          "Description is not available. Navigate to the source page to read a description.";
      String date = "Published date not available";
      String title = "Title not available";
      String author = "Author not available";
      String pages = "Page count not available";

      if (res[i]["volumeInfo"]["description"] != null)
        desc = res[i]["volumeInfo"]["description"];
      if (res[i]["volumeInfo"]["title"] != null)
        title = res[i]["volumeInfo"]["title"];
      if (res[i]["volumeInfo"]["publishedDate"] != null)
        date = res[i]["volumeInfo"]["publishedDate"];
      if (res[i]["volumeInfo"]["authors"] != null) {
        if (res[i]["volumeInfo"]["authors"] is List)
          author = res[i]["volumeInfo"]["authors"][0];
        else
          author = res[i]["volumeInfo"]["authors"];
      }
      if (res[i]["volumeInfo"]["pageCount"] != null)
        pages = res[i]["volumeInfo"]["pageCount"].toString();

      if (desc.length > 150) desc = desc.substring(0, 350) + "...";
      _resultList.add({
        "title": title,
        "author": author,
        "date": date,
        "pageCount": pages,
        "image": res[i]["volumeInfo"]["imageLinks"]["thumbnail"],
        "preview": res[i]["volumeInfo"]["previewLink"],
        "description": desc
      });
    }
    emit(BooksResultState());
  }

  Future<List<dynamic>> _findBooksFromTitle(String search_query) async {
    Uri url = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=${search_query}");
    var _requestApi = await get(url);
    return json.decode(_requestApi.body)["items"];
  }
}
