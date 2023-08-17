import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:horta593app/exceptions/form_exceptions.dart';
import 'package:horta593app/services/profile_service.dart';

import '../../../model/location_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitialState()) {
    on<LocationRequestEvent>((event, emit) async {
      emit(LocationLoadingState());
      try {
        final location = await ProfileService.getMeLocation();
        if (location.exists()) {
          emit(LocationSuccesState(location));
        } else {
          emit(LocationEmptyState());
        }
      } on FormGeneralException catch (e) {
        emit(LocationErrorState(e));
      } catch (e) {
        emit(LocationErrorState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    });

    on<UpdatedLocationUserEvent>((event, emit) async {
      emit(LocationUpdatingState());
      try {
        await ProfileService.changeLocation(event.newposicion, event.addr);
        emit(LocationUpdatedSuccesState(event.newposicion));
      } on FormGeneralException catch (e) {
        emit(LocationErrorState(e));
      } catch (e) {
        emit(LocationErrorState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    });
  }

  jsonDecode(body) {}
}
