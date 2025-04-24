import 'package:equatable/equatable.dart';

import '../../../utils/enums/request_status_bloc.dart';

class InfoBlocStatus extends Equatable{
  final RequestStatusBloc requestStatus;
  final String message;
  final int stateCode;

  const InfoBlocStatus({
    this.requestStatus = RequestStatusBloc.initial,
    this.message = "",
    this.stateCode = -1,
  });

  @override
  List<Object> get props => [
    requestStatus,
    message,
    stateCode,
  ];
}

