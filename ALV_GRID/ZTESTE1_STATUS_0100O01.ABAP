*----------------------------------------------------------------------*
***INCLUDE ZTESTE1_STATUS_0100O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
module status_0100 output.
  set pf-status 'GUI_STATUS2'.
** SET TITLEBAR 'xxx'...

  data: okcode100 type sy-ucomm.

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

  "-----------------------------------------------------------------------------
  "ALV - CONTAINER 2

  data: ol_alvgrid     type ref to cl_gui_alv_grid,          "instancia da alv grid
        ol_container   type ref to cl_gui_custom_container,  "instancia do container
        custom_control type scrfname.                        "nome do custom control

  data: it_fieldcat type lvc_t_fcat, "tabela do fieldcatalog
        ls_fieldcat type lvc_s_fcat, "estrutura do fieldcatalog
        ls_layout   type lvc_s_layo. "estrutura do layout

  data ol_event_handler type ref to zcl_event_handler. "instancia da classe de eventos

  data: lt_rows type lvc_t_row,       "tabela para campos de multiselecao na alv
        ls_rows like line of lt_rows. "linha de multiselecao


  "-----------------------------------------------------------------------------

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

  custom_control = 'CONTAINER'. "atribui o container

  create object ol_event_handler. "objeto da classe de eventos.

  "se o container ainda nao foi criado...
  if ol_alvgrid is initial.

    "cria o container
    create object ol_container
      exporting
        container_name              = custom_control
      exceptions
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6.

    "cria o alvgrid
    create object ol_alvgrid
      exporting
        i_parent          = ol_container
      exceptions
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        others            = 5.

  endif.

  "limpa o fieldcatalog
  clear it_fieldcat.
  clear ls_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'EBELN'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Número Pedido'.
  ls_fieldcat-seltext   = 'Número Pedido'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'EBELP'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Número Item'.
  ls_fieldcat-seltext   = 'Número Item'.
  ls_fieldcat-just      = 'C'.
  ls_fieldcat-hotspot   = 'X'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'MATNR'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 10.
  ls_fieldcat-coltext   = 'Nº Material'.
  ls_fieldcat-seltext   = 'Nº Material'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'MENGE'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Quantidade Items'.
  ls_fieldcat-seltext   = 'Quantidade Items'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'MEINS'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 10.
  ls_fieldcat-coltext   = 'Unidade de Item'.
  ls_fieldcat-seltext   = 'Unidade de Item'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'PEINH'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 10.
  ls_fieldcat-coltext   = 'Valor Unitário'.
  ls_fieldcat-seltext   = 'Valor Unitário'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'WERKS'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Centro'.
  ls_fieldcat-seltext   = 'Centro'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'LGORT'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Depósito'.
  ls_fieldcat-seltext   = 'Depósito'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'EKPO-HASHCAL_EXISTS'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Organização Compras'.
  ls_fieldcat-seltext   = 'Organização Compras'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'EKGRP'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Grupo Compradores'.
  ls_fieldcat-seltext   = 'Grupo Compradores'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

  clear ls_fieldcat.
  ls_fieldcat-fieldname = 'BUKRS'.
  ls_fieldcat-inttype   = 'C'.
  ls_fieldcat-outputlen = 20.
  ls_fieldcat-coltext   = 'Empresa'.
  ls_fieldcat-seltext   = 'Empresa'.
  ls_fieldcat-just      = 'C'.
  append ls_fieldcat to it_fieldcat.

**  fica a escuta do evento hostspot no alv
*  set handler ol_event_handler->handle_hotspot_click for ol_alvgrid.

  "fica a escuta do evento de edicao do alv
*  set handler ol_event_handler->handle_data_changed for ol_alvgrid.

  "métodos para inserir botoes na toolbar.
  set handler ol_event_handler->handle_toolbar for ol_alvgrid.

  "fica a escuta de um clique de botao
  set handler ol_event_handler->handle_user_command for ol_alvgrid.

  "metodo para registar qualquer edição efetuada no alv
  call method ol_alvgrid->register_edit_event
    exporting
      "constante obrigatoria como parametro
      "esta constante so aparece aqui no programa e nao está declarada em nenhum outro lado
      i_event_id = cl_gui_alv_grid=>mc_evt_modified
    exceptions
      error      = 1
      others     = 2.

  call method ol_alvgrid->get_selected_rows
    importing
      et_index_rows = lt_rows.

  ls_layout-zebra = 'X'.
  ls_layout-edit_mode = 'X'.
  ls_layout-sel_mode = 'A'.

  "metodo para receber o container com alv
  call method ol_alvgrid->set_table_for_first_display
    exporting
      is_layout       = ls_layout
    changing
      it_outtab       = it_table
      it_fieldcatalog = it_fieldcat
    exceptions
      others          = 1.

  "atualiza o alv
  call method ol_alvgrid->refresh_table_display
    exceptions
      others = 1.

endmodule.
