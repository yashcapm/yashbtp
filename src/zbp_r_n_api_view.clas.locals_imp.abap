CLASS lhc_zr_n_api_view DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.

    DATA : ls_api   LIKE LINE OF zbp_r_n_api_view=>it_api,
           ls_kunnr LIKE LINE OF zbp_r_n_api_view=>it_kunnr.

METHODS:
      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check.


  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_n_api_view RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_n_api_view RESULT result. " create

    METHODS autopost FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~autopost RESULT result.

    METHODS getdata FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~getdata RESULT result.

    METHODS grncreate FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~grncreate RESULT result.

    METHODS pocreate FOR MODIFY
      IMPORTING keys FOR ACTION zr_n_api_view~pocreate RESULT result.


  CONSTANTS:
      base_url     TYPE string VALUE 'https://lmiapi.estonetech.in/api/SAP_Integration/LMISapPurchaseOrder?Order_Id=308635',
      content_type TYPE string VALUE 'Content-type',
      json_content TYPE string VALUE 'application/json; charset=UTF-8'.

ENDCLASS.

CLASS lhc_zr_n_api_view IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD autopost.
  ENDMETHOD.

  METHOD getdata.
      SELECT * FROM zc_api_auto
     WHERE ebeln IS INITIAL
    INTO TABLE @DATA(it_api).

    loop at it_api INTO data(wa_api).
     MOVE-CORRESPONDING wa_api to ls_api.
     APPEND ls_api to zbp_r_n_api_view=>it_api.
     clear:ls_api.
    ENDLOOP.


    DATA:it_tab TYPE STANDARD TABLE OF ztt_api_master,
         wa_tab TYPE ztt_api_master.
*   <<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>
    DATA(url) = |{ base_url }|.
    TRY.
        DATA(client) = create_client( url ).
      CATCH cx_static_check.
        "handle exception
    ENDTRY.
    TRY.
        DATA(response) = client->execute( if_web_http_client=>get )->get_text(  ).
      CATCH cx_web_http_client_error cx_web_message_error.
        "handle exception
    ENDTRY.


    DATA : lv_str1  TYPE string,
           lv_str2  TYPE string,
           lv_str3  TYPE string,
           lv_str4  TYPE string,
           lv_str5  TYPE string,
           lv_str6  TYPE string,
           lv_str7  TYPE string,
           lv_str8  TYPE string,
           lv_str9  TYPE string,
           lv_str10 TYPE string.



    SPLIT  response AT '},' INTO  lv_str1  lv_str2 lv_str3 lv_str4 lv_str5
                                           lv_str6  lv_str7 lv_str8 lv_str9 lv_str10.
    CLEAR:lv_str5,lv_str6,lv_str7.
    SPLIT lv_str4 AT ':"' INTO lv_str5 lv_str6.
    IF lv_str6 IS NOT INITIAL.
      DATA(zkunnr) = lv_str6+0(10).
    ELSE.
      zkunnr = '0020000000'.
    ENDIF.
    ls_kunnr-kunnr = zkunnr.
    APPEND ls_kunnr TO zbp_r_n_api_view=>it_kunnr.
    CLEAR:ls_kunnr.
*      <<<<<<<<<<<<<<<>>>>>>>>>>>>
    CLEAR:lv_str5,lv_str6,lv_str7.
    SPLIT lv_str2 AT ':"' INTO lv_str5 lv_str6.
    IF lv_str6 IS NOT INITIAL.
*        DATA(zkunnr2) = lv_str6+0(10).
*      ELSE.
      zkunnr = '0020000000'.
    ENDIF.
    ls_kunnr-kunnr = zkunnr.
    APPEND ls_kunnr TO zbp_r_n_api_view=>it_kunnr.
    CLEAR:ls_kunnr.
*      <<<<<<<<<<<<<<<>>>>>>>>>>>>>>>
    CLEAR:lv_str5,lv_str6,lv_str7.
    SPLIT lv_str3 AT ':"' INTO lv_str5 lv_str6.
    IF lv_str6 IS NOT INITIAL.
      zkunnr = lv_str6+0(10).
    ELSE.
      zkunnr = '0020000000'.
    ENDIF.
    ls_kunnr-kunnr = zkunnr.
    APPEND ls_kunnr TO zbp_r_n_api_view=>it_kunnr.
    CLEAR:ls_kunnr.




  ENDMETHOD.

  METHOD grncreate.
  ENDMETHOD.

  METHOD pocreate.
  ENDMETHOD.

  METHOD create_client.
DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD.

ENDCLASS.
