CLASS lhc_zr_n_api_view DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_n_api_view RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_n_api_view RESULT result.

    METHODS autopost FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~autopost RESULT result.

    METHODS getdata FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~getdata RESULT result.

    METHODS grncreate FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~grncreate RESULT result.

    METHODS pocreate FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~pocreate RESULT result.

ENDCLASS.

CLASS lhc_zr_n_api_view IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD autopost.
  ENDMETHOD.

  METHOD getdata.
  ENDMETHOD.

  METHOD grncreate.
  ENDMETHOD.

  METHOD pocreate.
  ENDMETHOD.

ENDCLASS.
