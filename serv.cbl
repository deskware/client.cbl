

      ****************************************
      * Program name: serv.cbl
      * This program is a TCP/IP server.  It
      * demonstrates the use of several CS
      * TCP/IP commands.
      *
      * Copyright 2000 Deskware, Inc.
      ****************************************                                                             
      * Syntax: CREATESOCKET USING .
      *
      * Syntax: BINDSOCKET USING  .
      *
      * Syntax: LISTENTOSOCKET  .
      *
      * Syntax: CONNECTTOSOCKET   .
      *
      * Syntax: ACCEPTFROMSOCKET  accepted socket number>.
      *
      * Syntax: RECEIVESOCKET  .
      *
      * Syntax: SENDSOCKET  .
      *
      * Syntax: SHUTDOWNSOCKET  .
      *
      * Syntax: CLOSESOCKET .
      *                                                             
      *                                                             
      * How to run this program: 
      * 1) Bring up a command prompt (DOS Prompt or Xterm)          
      * 2) Type `cobolscript.exe serv.cbl`                          
      * 3) Bring up a second command prompt (DOS Prompt OR Xterm)   
      * 4) Type `cobolscript.exe client.cbl`                        
      ***************************************************************
      * Include the TCP/IP variable copybook.
       COPY `tcpip.cpy`.

       1 host_name        PIC X(80).
       1 socket_num       PIC 9(02).
       1 connected_socket_num       PIC 9(02).
       1 port_num         PIC 9(05).
       1 backlog_num      PIC 9(02).
       1 string_var           PIC X(10).
       1 receive_string   PIC X(20).
       1 send_string      PIC X(20).

       MAIN.
           GETHOSTNAME USING host_name.
           DISPLAY `Starting Deskware Server on ` & host_name.

           MOVE 1 TO socket_num.
           MOVE 2 TO connected_socket_num.
           CREATESOCKET USING socket_num.
           DISPLAY `CREATESOCKET RETURN CODE <` & TCPIP-RETURN-CODE & `>`.
            
           MOVE 2500 TO port_num.
           BINDSOCKET USING socket_num port_num.
           DISPLAY `BINDSOCKET RETURN CODE <` & TCPIP-RETURN-CODE & `>`.

           MOVE 1 TO backlog_num.
           LISTENTOSOCKET USING socket_num backlog_num.
           DISPLAY `LISTENTOSOCKET RETURN CODE <` & TCPIP-RETURN-CODE & `>`.

           DISPLAY `WAITING TO ACCEPT CONECTION ON PORT <` & port_num & `>...`.
           ACCEPTFROMSOCKET USING socket_num connected_socket_num.
           DISPLAY `ACCEPTFROMSOCKET RETURN CODE <` & TCPIP-RETURN-CODE & `>`.

           MOVE SPACES TO receive_string.
           PERFORM ACCEPT-TCPIP-CONNECTIONS UNTIL
                 receive_string(1:4) = `STOP`.


           DISPLAY `Shutting down Deskware Server`.

           SHUTDOWNSOCKET USING connected_socket_num 1.
           CLOSESOCKET USING connected_socket_num.

           SHUTDOWNSOCKET USING socket_num 1.
           CLOSESOCKET USING socket_num.

           GOBACK.

       ACCEPT-TCPIP-CONNECTIONS.
           MOVE SPACES TO receive_string.
           RECEIVESOCKET USING connected_socket_num receive_string.
           PERFORM DISPLAY-TCPIP-RETURN-CODE.
           DISPLAY `THIS WAS RECEIVED: ` & receive_string.

           MOVE `GOT IT` TO send_string.
           SENDSOCKET USING connected_socket_num send_string.
           PERFORM DISPLAY-TCPIP-RETURN-CODE.
           DISPLAY `THIS WAS SENT: ` & send_string.

       DISPLAY-TCPIP-RETURN-CODE.
           DISPLAY `<` & TCPIP-RETURN-CODE & `>`.
           DISPLAY `<` & TCPIP-RETURN-MESSAGE & `>`.


