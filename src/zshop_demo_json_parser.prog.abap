*&---------------------------------------------------------------------*
*& Report ZSHOP_DEMO_JSON_PARSER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zshop_demo_json_parser.

*--------------------------------------------------------------------*
* CLASS
*--------------------------------------------------------------------*
CLASS lc DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS:
      main IMPORTING  io_reader TYPE REF TO if_sxml_reader.

ENDCLASS.

CLASS lc IMPLEMENTATION.
  METHOD main.

    DATA: lo_json_parser TYPE REF TO zif_shop_json_parser,
          ld_ddic        TYPE REF TO data.

    FIELD-SYMBOLS <fs_response> TYPE zshop_so_hdr_json.

    CREATE OBJECT lo_json_parser TYPE zcl_shop_json_parser
      EXPORTING
        io_reader = io_reader.

    ld_ddic = lo_json_parser->parse( VALUE zshop_so_hdr_json( ) ).
    ASSIGN ld_ddic->* TO <fs_response>.
    IF <fs_response> IS NOT ASSIGNED.
      RETURN.
    ENDIF.

    WRITE: / <fs_response>-uuid,
           / <fs_response>-companycode,
           / <fs_response>-businessplace,
           / <fs_response>-salesorderid,
           / <fs_response>-salesorderdate,
           / <fs_response>-createdate,
           / <fs_response>-createtime.

  ENDMETHOD.

ENDCLASS.

*--------------------------------------------------------------------*
* Coding
*--------------------------------------------------------------------*
START-OF-SELECTION.
  DATA: lx_shop_unsupported_type TYPE REF TO zcx_shop_unsupported_type,
        lx_shop_json_parser      TYPE REF TO zcx_shop_json_parser,
        lo_reader                TYPE REF TO if_sxml_reader,
        lv_json                  TYPE xstring.

  lv_json = cl_abap_codepage=>convert_to( '{'
    && '"uuid": "1302bdc1-ee08-4683-bac8-e50488d58c7c",'
    && '"companyCode": "BR01",'
    && '"businessPlace": "0001",'
    && '"salesOrderId": "1000000001",'
    && '"salesOrderDate": "21/10/2019",'
    && '"createDate": "21/10/2019",'
    && '"createTime": "21:22:00"'
    && '}' ).

  TRY .
      lo_reader = zcl_shop_sxml_factory=>build( lv_json ).
    CATCH zcx_shop_unsupported_type INTO lx_shop_unsupported_type.
      MESSAGE lx_shop_unsupported_type->get_text( )
         TYPE 'E'.
  ENDTRY.

  TRY.
      NEW lc( )->main( lo_reader ).
    CATCH zcx_shop_json_parser INTO lx_shop_json_parser.
      MESSAGE lx_shop_json_parser->get_text( )
         TYPE 'E'.
  ENDTRY.
