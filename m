content-class: urn:content-classes:message
MIME-Version: 1.0
Message-ID: <1527F40959C109439CBC334DE4758F280C10EA@...142...>
From: =?iso-8859-2?Q?Lipert_V=E1clav?= <VLipert@...141...>
Subject: [Openvpn-devel] TCP tunnel problem on Windows
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Dec  9 00:47:02 2003
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

I am using OpenVPN 1.5.0 for Windows (windowsxp - windowsxp, tap, tcp-clien=
t tcp-server) and I have one problem. After connection establishing work pi=
nging OK, but when I try connect from server to client with VNC or Remote D=
esktop Connection (from Microsoft) it is working for few seconds (first scr=
een loaded) and then stops working all TCP/IP communication (pinging doesnt=
 work). On side of client it generates this error (on server side it is no =
error):

Mon Dec 08 18:11:57 2003 672: TCPv4_CLIENT link local: [undef]
Mon Dec 08 18:11:57 2003 673: TCPv4_CLIENT link remote: 127.0.0.1:2000
Mon Dec 08 18:11:57 2003 674: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:57 2003 675: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:57 2003 676: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:57 2003 677: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:57 2003 678: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:57 2003 679: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:57 2003 680: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:58 2003 681: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:58 2003 682: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:11:58 2003 683: read from TUN/TAP  [State=3DAT?c Err=3D[c:\sr=
c\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0,0] IrpQ=3D[=
16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=3D31)
Mon Dec 08 18:12:27 2003 684: 269 variation(s) on previous 10 message(s) su=
ppressed by --mute
Mon Dec 08 18:12:27 2003 685: Connection reset, restarting [0]
Mon Dec 08 18:12:27 2003 686: Closing TCP/UDP socket
Mon Dec 08 18:12:27 2003 687: Restart pause, 3 second(s)


Anyone knows, where could be a problem?

Thanks
Wally

