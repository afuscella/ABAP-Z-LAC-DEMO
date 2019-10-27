*&---------------------------------------------------------------------*
*& Report ZLAC_SHOP_DEMO_PERSIST_DB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlac_shop_demo_persist_db.

DATA(lo_text_persistence) = CAST zif_lac_shop_persist_so_txt(
  NEW zcl_lac_shop_persist_so_txt( )
).

DATA(ls_txt_json) = VALUE zlac_shop_so_txt_json(
  salesorderid   = '$2'
  salesorderitem = '01'
  message          = 'aaokoaaaokoaaaokoaaaokoaaaokoaaaokoaaaokoaaaokoa'
    && 'aaokoaaaokoaaaokoaaaokoaaaokoaaaokoaaaokoaaaokoa11saa'
).

TRY .
    DATA(ls_data) = lo_text_persistence->create_resource( ls_txt_json ).
  CATCH zcx_shop INTO DATA(lx_shop).
    lx_shop->raise_message( ).
ENDTRY.

WRITE ls_data-so_number.
