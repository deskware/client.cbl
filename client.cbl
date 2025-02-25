

      *****************************************
      * CobolScript program name: client.cbl
      * This program provides an example 
      * of socket command usage.  Use in
      * conjunction with serv.cbl (see below).
      *
      * Copyright 2000 Deskware, Inc.
      *****************************************
      * Commands used:
      *
      * CREATESOCKET USING                           
      * BINDSOCKET USING                
      * LISTENTOSOCKET         
      * CONNECTTOSOCKET     
      * ACCEPTFROMSOCKET       
      * RECEIVESOCKET            
      * SENDSOCKET                 
      * SHUTDOWNSOCKET              
      * CLOSESOCKET                                  
      *                                                             
      * Instructions for running this program:
      * 1) Start a system prompt (dos prompt, xterm, or telnet session)          
      * 2) Type `cobolscript.exe serv.cbl`                          
      * 3) Start a second system prompt (dos prompt, xterm, or telnet session)  
      * 4) Type `cobolscript.exe client.cbl`                         
      * 5) Enter data to send to the server, or "STOP" to quit 
      **************************************************************
      * Include the TCP/IP variable copybook.
       COPY `tcpip.cpy`.

       1 host_name            PIC X(80).
       1 socket_num           PIC 9(2).
       1 connected_socket_num PIC 9(2).
       1 port_num             PIC Z9999.
       1 backlog_num          PIC 9(2).
       1 string               PIC X(10).
       1 receive_string       PIC X(20).
       1 send_string          PIC X(20).
       1 stop_var             PIC 9.

       DISPLAY `Starting Deskware Client (type STOP to exit).`.
       MOVE 1 TO socket_num .
       CREATESOCKET USING socket_num.
       DISPLAY `CREATESOCKET return code = <` & TCPIP-RETURN-CODE & `>`.
            
       MOVE 2500 TO port_num.
      * We are using the loop back IP in this example;
      * uncomment the line below and comment out the move
      * to actually get the host name
      * GETHOSTNAME USING host_name
       MOVE `127.0.0.1` TO host_name.

       DISPLAY `Your hostname is: ` & host_name.
       CONNECTTOSOCKET USING socket_num host_name port_num.
       DISPLAY `CONNECTTOSOCKET return code = <` & TCPIP-RETURN-CODE & `>`.
       DISPLAY TCPIP-RETURN-MESSAGE.

       PERFORM SEND-DATA-TO-SERVER UNTIL stop_var.

       SHUTDOWNSOCKET USING socket_num 1.
       CLOSESOCKET USING socket_num.
       GOBACK.

       SEND-DATA-TO-SERVER.
           ACCEPT send_string FROM KEYBOARD
               PROMPT `Data to send to port 2500: `.

           SENDSOCKET USING socket_num send_string.
           DISPLAY `SENDSOCKET return code = <` & TCPIP-RETURN-CODE & `>`.
           DISPLAY TCPIP-RETURN-MESSAGE.
      
           MOVE SPACES TO receive_string.
           RECEIVESOCKET USING socket_num receive_string.
           DISPLAY `RECEIVESOCKET return code = <` &  TCPIP-RETURN-CODE & `>`.
           DISPLAY `This was received: <` & receive_string & `>`.
           DISPLAY `RECEIVESOCKET return code = <` & TCPIP-RETURN-CODE & `>`.
           DISPLAY TCPIP-RETURN-MESSAGE.

           IF send_string(1:4) = `STOP` THEN
              MOVE 1 to stop_var
           END-IF.




