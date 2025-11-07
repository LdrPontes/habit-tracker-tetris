import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:blockin/app/shared/domain/errors/app_exceptions.dart';
import 'package:blockin/core/localization/localizations.dart';

class Result<T> extends Equatable {
  const Result._();

  const factory Result.idle() = Idle;
  const factory Result.success({T? data}) = Success;
  const factory Result.error({
    String? code,
    String? message,
    Exception? exception,
  }) = Error;
  const factory Result.loading() = Loading;

  void when({
    VoidCallback? idle,
    void Function(T? data)? success,
    void Function(String? code, String? message, Exception? exception)? error,
    VoidCallback? loading,
  }) {
    if (this is Loading) {
      loading?.call();
    } else if (this is Success) {
      success?.call((this as Success).data);
    } else if (this is Error) {
      final data = this as Error;
      error?.call(data.code, data.message, data.exception);
    } else if (this is Idle) {
      idle?.call();
    }
  }

  @override
  List<Object?> get props => [
    if (this is Success) (this as Success).data,
    if (this is Error) (this as Error).code,
    if (this is Error) (this as Error).message,
    if (this is Error) (this as Error).exception,
  ];
}

class Idle<T> extends Result<T> {
  const Idle() : super._();
}

class Success<T> extends Result<T> {
  final T? data;
  const Success({this.data}) : super._();

  @override
  List<Object?> get props => [data];
}

class Error<T> extends Result<T> {
  final String? code;
  final String? message;
  final Exception? exception;

  const Error({this.code, this.message, this.exception}) : super._();

  @override
  List<Object?> get props => [code, message, exception];
}

class Loading<T> extends Result<T> {
  const Loading() : super._();
}

class PaginatedResult<T> extends Equatable {
  final int? page;
  final int? totalPages;
  final int? totalItems;

  const PaginatedResult({this.page, this.totalPages, this.totalItems});

  @override
  List<Object?> get props => [page, totalPages, totalItems];
}

extension ErrorHandler on Error {
  String getMessage(BuildContext context, {String? defaultErrorMessage}) {
    if (exception is AppException) {
      final localizations = AppLocalizations.of(context);
      if (localizations != null) {
        return (exception as AppException).getLocalizedMessage(localizations);
      }
      // Fallback if localizations are not available
      return message ?? defaultErrorMessage ?? 'An unknown error occurred';
    }
    return message ?? defaultErrorMessage ?? 'An unknown error occurred';
  }
}
