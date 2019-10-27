*&---------------------------------------------------------------------*
*& Report ZLAC_SHOP_DEMO_JSON_FACTORY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlac_shop_demo_json_factory.

*--------------------------------------------------------------------*
* Coding
*--------------------------------------------------------------------*
START-OF-SELECTION.
  DATA: lx_lac_unsupported_type TYPE REF TO zcx_lac_unsupported_media_type,
        lx_shop_json_parser     TYPE REF TO zcx_lac_json_parser,
        lo_reader               TYPE REF TO if_sxml_reader,
        lv_json                 TYPE xstring.

  lv_json = cl_abap_codepage=>convert_to( '{}' ).

  TRY .
      lo_reader = zcl_lac_sxml_factory=>build( lv_json ).
    CATCH zcx_lac_unsupported_media_type INTO lx_lac_unsupported_type.
      MESSAGE lx_lac_unsupported_type->get_text( )
         TYPE 'E'.
  ENDTRY.
