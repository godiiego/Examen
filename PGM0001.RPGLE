 FTSTF02P   UF A E           K DISK
     FTA6REL1   UF A E           K DISK
     FBOADREL1  UF A E           K DISK
     DPGMNAME         SDS                  QUALIFIED
     DPGMNAME            *PROC
     FPTEST0001 CF   E             WORKSTN

      /free
        //Proceso principal
        dow *in03 = *off;
          EXSR SR_INICIO;
          EXSR SR_DESARROLLO;
          WRITE PANTALLA;
          EXFMT PANTALLA;
        ENDDO;
        *inlr = *on;

      //Sub procesos
        // Asigna valores a la pantalla
        BEGSR SR_INICIO;
          // Titulo de la empresa
          TA6REID=1;
          CHAIN TA6REID TA6REL1;
          IF %FOUND;
            TITULO = TA6RECONT;
          ENDIF;
          // Nombre del progrma
          NOMBREPGM = PGMNAME;
        ENDSR;
        //Desarrollo
        BEGSR SR_DESARROLLO;
          TSTF02FID =1;
          CHAIN TSTF02FID TSTF02P;
          IF %FOUND;
            //Asignar codigo de cliente
            COD = TSTF02COD;
            //Asignar numero de movimiento
            TRANSNUM = TSTF02MOV;
            //Asignar monto de la transaccion
            VAL = TSTF02VAL;
            //ASIGNA CODIGO Y NOMBRE DE LA CIUDAD
            CIU = TSTF02CIU;
            CHAIN TSTF02CIU BOADREL1;
            IF %FOUND;
              NOMCIU = BOADRENOM;
            ENDIF;
            //Modifica el fromato de fecha
            FECH = %XLATE( '.': '-': (%CHAR(TSTF02FECH:*EUR)));
          ENDIF;
        ENDSR;


      /end-free     
