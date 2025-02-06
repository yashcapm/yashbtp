CLASS zcl_api_getdata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS:
      base_url     TYPE string VALUE 'https://lmiapi.estonetech.in/api/SAP_Integration/LMISapPurchaseOrder?Order_Id=308635',
      content_type TYPE string VALUE 'Content-type',
      json_content TYPE string VALUE 'application/json; charset=UTF-8'.

ENDCLASS.



CLASS ZCL_API_GETDATA IMPLEMENTATION.


  METHOD create_client.
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    SELECT * FROM zc_api_auto
     WHERE ebeln IS INITIAL
    INTO TABLE @DATA(it_api).


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

    TYPES:BEGIN OF ty_kunnr,
            kunnr TYPE kunnr,
          END OF ty_kunnr.
    DATA : lv_str1  TYPE string,
           lv_str2  TYPE string,
           lv_str3  TYPE string,
           lv_str4  TYPE string,
           lv_str5  TYPE string,
           lv_str6  TYPE string,
           lv_str7  TYPE string,
           lv_str8  TYPE string,
           lv_str9  TYPE string,
           lv_str10 TYPE string,
           it_kunnr TYPE STANDARD TABLE OF ty_kunnr,
           wa_kunnr TYPE ty_kunnr.

    CLEAR:it_kunnr,wa_kunnr,it_tab,wa_tab.
    SPLIT  response AT '},' INTO  lv_str1  lv_str2 lv_str3 lv_str4 lv_str5
                                           lv_str6  lv_str7 lv_str8 lv_str9 lv_str10.
    CLEAR:lv_str5,lv_str6,lv_str7.
    SPLIT lv_str4 AT ':"' INTO lv_str5 lv_str6.
    IF lv_str6 IS NOT INITIAL.
      DATA(zkunnr) = lv_str6+0(10).
    ELSE.
      zkunnr = '0020000000'.
    ENDIF.
    wa_kunnr-kunnr = zkunnr.
    APPEND wa_kunnr TO it_kunnr.
    CLEAR:wa_kunnr.
*      <<<<<<<<<<<<<<<>>>>>>>>>>>>
    CLEAR:lv_str5,lv_str6,lv_str7.
    SPLIT lv_str2 AT ':"' INTO lv_str5 lv_str6.
    IF lv_str6 IS NOT INITIAL.
*        DATA(zkunnr2) = lv_str6+0(10).
*      ELSE.
      zkunnr = '0020000000'.
    ENDIF.
    wa_kunnr-kunnr = zkunnr.
    APPEND wa_kunnr TO it_kunnr.
    CLEAR:wa_kunnr.
*      <<<<<<<<<<<<<<<>>>>>>>>>>>>>>>
    CLEAR:lv_str5,lv_str6,lv_str7.
    SPLIT lv_str3 AT ':"' INTO lv_str5 lv_str6.
    IF lv_str6 IS NOT INITIAL.
      zkunnr = lv_str6+0(10).
    ELSE.
      zkunnr = '0020000000'.
    ENDIF.
    wa_kunnr-kunnr = zkunnr.
    APPEND wa_kunnr TO it_kunnr.
    CLEAR:wa_kunnr.

    LOOP AT it_api INTO DATA(wa_api).
      LOOP AT it_kunnr INTO wa_kunnr.
        MOVE-CORRESPONDING  wa_api TO wa_tab.
        wa_tab-kunnr = wa_kunnr-kunnr.
        APPEND wa_tab TO it_tab.
      ENDLOOP.
      CLEAR:wa_api,wa_kunnr.
    ENDLOOP.

    loop at it_tab INTO wa_tab.
     MODIFY ztt_api_master from @wa_tab.
     clear wa_tab.
    endloop.








  ENDMETHOD.
ENDCLASS.
