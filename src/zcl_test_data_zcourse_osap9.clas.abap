CLASS zcl_test_data_zcourse_osap9 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_DATA_ZCOURSE_OSAP9 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_course   TYPE STANDARD TABLE OF zcourse_osap9 WITH EMPTY KEY,
          lt_schedule TYPE STANDARD TABLE OF zschedule_osap9 WITH EMPTY KEY.

    TRY.

        lt_course = VALUE #(

        ( course_uuid = cl_system_uuid=>create_uuid_x16_static( )
        course_id = 'BC400'
        course_name = 'ABAP Development'
        course_length = 5
        country = 'DE'
        price = 1000
        currency_code = 'EUR' )

        ( course_uuid = cl_system_uuid=>create_uuid_x16_static( )
        course_id = 'BC401'
        course_name = 'ABAP Objects'
        course_length = 5
        country = 'DE'
        price = 1000
        currency_code = 'EUR' )

        ( course_uuid = cl_system_uuid=>create_uuid_x16_static( )
        course_id = 'BC402'
        course_name = 'ABAP Advanced Development'
        course_length = 5
        country = 'DE'
        price = 1000
        currency_code = 'EUR' ) ).


        DELETE FROM zcourse_osap9.

        INSERT zcourse_osap9 FROM TABLE @lt_course.

        out->write( |{ sy-dbcnt } entries in ZCOURSE_dsap1 modified| ).




        lt_schedule = VALUE #(

        ( schedule_uuid = cl_system_uuid=>create_uuid_x16_static( )
        course_uuid = lt_course[ 1 ]-course_uuid
        course_begin = '20200301'
        trainer = 'John Doe'
        is_online = abap_false
        location = 'Walldorf' )

        ( schedule_uuid = cl_system_uuid=>create_uuid_x16_static( )
        course_uuid = lt_course[ 2 ]-course_uuid
        course_begin = '20200308'
        trainer = 'Mary Jane'
        is_online = abap_true
        location = 'VLC' ) ).

        DELETE FROM zschedule_osap9.

        INSERT zschedule_osap9 FROM TABLE @lt_schedule.

        out->write( |{ sy-dbcnt } entries in ZSCHEDULE_dsap1 modified| ).

        COMMIT WORK.

      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
