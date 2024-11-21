*&---------------------------------------------------------------------*
*& Include          ZALV_TEST
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
***INCLUDE ZCL_EVENT_HANDLER.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Class zcl_event_handler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
class zcl_event_handler definition final.

  public section.

    methods:
      "método para implementar botoes na toolbar do alv
      handle_toolbar for event toolbar of cl_gui_alv_grid
        importing e_object e_interactive,

      "metodo para mudanca de evento ao duplo clique
*      handle_hotspot_click
*        for event hotspot_click of cl_gui_alv_grid
*        importing
*          e_row_id
*          e_column_id
*          es_row_no,

      "metodo para registar alteracoes feitas diretamente na celula
*      handle_data_changed
*        for event data_changed of cl_gui_alv_grid
*        importing
*          er_data_changed,

      "método para chamar a funcao dos botoes da toolbar
      handle_user_command for event user_command of cl_gui_alv_grid
        importing e_ucomm.

endclass.

class zcl_event_handler implementation.

*  method handle_hotspot_click.
*    perform handle_hotspot_click using e_row_id e_column_id es_row_no.
*  endmethod.

*  method handle_data_changed.
*    perform handle_data_changed using er_data_changed.
*  endmethod.

  method handle_toolbar.

    data: ls_toolbar type stb_button.

    e_interactive = 'X'. "torna a barra de ferramentas interativa

    clear e_object->mt_toolbar. "limpa a toolbar

    "cria os botoes
    clear ls_toolbar.
    ls_toolbar-function  = 'ALTERAR'.
    ls_toolbar-icon      = ICON_CHANGE .
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'Alterar'.
    append ls_toolbar to e_object->mt_toolbar.

    clear ls_toolbar.
    ls_toolbar-function  = 'FCT_EMAIL_PCT'.
    ls_toolbar-icon      = ICON_MAIL  .
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'Enviar Email'.
    append ls_toolbar to e_object->mt_toolbar.

    "cria os botoes
    clear ls_toolbar.
    ls_toolbar-function  = 'REMOVER'.
    ls_toolbar-icon      = ICON_NEGATIVE .
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'Remover'.
    append ls_toolbar to e_object->mt_toolbar.

    "cria os botoes
    clear ls_toolbar.
    ls_toolbar-function  = 'LIBERAR'.
    ls_toolbar-icon      = ICON_CHECKED .
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'Liberar'.
    append ls_toolbar to e_object->mt_toolbar.

  endmethod.

  method handle_user_command.

    case e_ucomm.
      when 'FCT_EXPORT_PDF'.
*        perform get_data_pdf.
    endcase.

  endmethod.

endclass.
