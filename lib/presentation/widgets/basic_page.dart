import 'dart:async';

import 'package:fintech_app/core/constants/insets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/base.dart';

/// Centered [CircularProgressIndicator] widget.
Widget get _loadingIndicator =>
    const Center(child: CircularProgressIndicator());

/// Function which handles reloading [QueryModel] models.
Future<void> onRefresh(BuildContext context, BaseRepository repository) {
  final Completer<void> completer = Completer<void>();
  repository.refreshData().then((_) {
    if (repository.loadingFailed) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).errorColor,
            content: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: AppInsets.insetsPadding),
                Expanded(
                  child: Text(
                    repository.errorMessage,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 1),
          ),
        );
    }
    completer.complete();
  });
  return completer.future;
}

/// Basic screen.
/// Used when the desired page doesn't have reloading.
class BasicPage extends StatelessWidget {
  final Widget body, fab;
  final PreferredSizeWidget appBar;

  const BasicPage({
    this.body,
    this.fab,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: fab,
    );
  }
}

/// Extension on Basic page which has reloading properties.
/// It uses the [BlankPage] widget inside it.
extension CustomPageX on BasicPage {
  Widget reloadablePage<T extends BaseRepository>({Widget placeholder}) {
    return BasicPage(
      fab: fab,
      body: Consumer<T>(
        builder: (context, model, child) => RefreshIndicator(
          onRefresh: () => onRefresh(context, model),
          child: model.isLoading
              ? placeholder ?? _loadingIndicator
              : model.loadingFailed
                  ? ChangeNotifierProvider.value(
                      value: model,
                      child: ConnectionError<T>(),
                    )
                  : body,
        ),
      ),
    );
  }
}

/// Widget used to display a connection error message.
/// It allows user to reload the page with a simple button.
class ConnectionError<T extends BaseRepository> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Что-то пошло не так',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: AppInsets.insetsPadding / 2),
          Text(
            'При загрузке данных произошла ошибка.\nПовторите попытку позже',
            textScaleFactor: 1.2,
            style: Theme.of(context).textTheme.caption.copyWith(height: 1.3),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppInsets.insetsPadding),
          TextButton(
            onPressed: () async => onRefresh(context, model),
            child: Text(
              'ПОВТОРИТЬ',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
