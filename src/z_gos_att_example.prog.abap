*&---------------------------------------------------------------------*
*& Report Z_GOS_ATT_EXAMPLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_gos_att_example.


CONSTANTS: objtype TYPE borident-objtype VALUE 'ZTMP_GOSAT'.

TYPES: BEGIN OF exclude_type,
         fcode LIKE rsmpe-func,
       END OF exclude_type.

DATA: manager       TYPE REF TO cl_gos_manager,
      gos_container TYPE REF TO cl_gui_custom_container,
      obj           TYPE borident,
      ok_code       TYPE sy-ucomm,
      exclude_tab   TYPE STANDARD TABLE OF exclude_type,
      exclude_wa    TYPE exclude_type.

PARAMETERS: p_onrep TYPE flag RADIOBUTTON GROUP g1 DEFAULT 'X',
            p_onscr TYPE flag RADIOBUTTON GROUP g1.

START-OF-SELECTION.

**********************************************************************
* Object Key Declaration for both implementations
**********************************************************************

  obj-objtype = objtype.
  obj-objkey = 'ANY_KEY_YOU_WANT'.


  IF p_onrep EQ abap_true.

**********************************************************************
* Implementation on Toolbar
**********************************************************************

    CREATE OBJECT manager
      EXPORTING
        is_object       = obj
        ip_start_direct = ' '
      EXCEPTIONS
        OTHERS          = 1.



  ELSE.

**********************************************************************
* Implementation on Screen
**********************************************************************


    CREATE OBJECT manager
      EXPORTING
*       is_object       = obj
        ip_start_direct = ' '
      EXCEPTIONS
        OTHERS          = 1.

  ENDIF.



  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'PF_STATUS_0100'.
* SET TITLEBAR 'xxx'.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'CANCEL'.

      LEAVE PROGRAM.

    WHEN 'LIST'.

**********************************************************************
* Implementation on Screen
**********************************************************************


      CALL METHOD manager->start_service_direct
        EXPORTING
*         io_container     = gos_container
          ip_service       = 'VIEW_ATTA'
          is_object        = obj
          ip_no_check      = 'X'
        EXCEPTIONS
          no_object        = 1
          object_invalid   = 2
          execution_failed = 3
          OTHERS           = 4.

  ENDCASE.

ENDMODULE.
