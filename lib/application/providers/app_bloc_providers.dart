import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nativus_pos_desktop/application/injector.dart';
import 'package:nativus_pos_desktop/features/products/presentation/blocs/products_bloc.dart';
import 'package:nativus_pos_desktop/features/tables/presentation/blocs/tables_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProductsBloc>()),
        BlocProvider(create: (_) => sl<TablesBloc>()),
      ],
      child: child,
    );
  }
}
