tables: ekko.

types: begin of ty_order,
         ebeln          type ekko-ebeln,
         ebelp          type ekpo-ebelp,
         matnr          type ekpo-matnr,
         maktx          type makt-maktx,
         menge          type ekpo-menge,
         meins          type ekpo-meins,
         peinh          type ekpo-peinh,
         werks          type ekpo-werks,
         lgort          type ekpo-lgort,
         hashcal_exists type ekpo-hashcal_exists,
         ekgrp          type ekko-ekgrp,
         bukrs          type ekpo-bukrs,
       end of ty_order.

data: it_table type table of ty_order,
      ls_table type ty_order.

"-----------------------------------------------------

selection-screen: begin of block a1 with frame.
select-options aedat for  ekko-aedat.
parameters:    bsart type ekko-bsart,
               ebeln type ekko-ebeln.
selection-screen: end of block a1.

"-----------------------------------------------------

start-of-selection.

  perform get_data.
  perform display_data.


form get_data.

  select ekko~ebeln,
         ekpo~ebelp,
         ekpo~matnr,
         makt~maktx,
         ekpo~menge,
         ekpo~meins,
         ekpo~peinh,
         ekpo~werks,
         ekpo~lgort,
         ekpo~hashcal_exists,
         ekko~ekgrp,
         ekpo~bukrs
    from ekko
    inner join ekpo  on ekko~ebeln eq ekpo~ebeln
    inner join makt  on ekpo~matnr eq makt~matnr
    into corresponding fields of table @it_table
    where ekko~frgrl eq 'X'.

endform.

form display_data.

  data: ol_alv type ref to cl_salv_table.

  cl_salv_table=>factory(
    importing
      r_salv_table   =  ol_alv
    changing
      t_table        =  it_table
  ).

  ol_alv->set_screen_status(
  exporting
    report        = sy-repid
    pfstatus      = 'GUI_TEST'
    set_functions = cl_salv_table=>c_functions_all
).

  ol_alv->display( ).

endform.
