content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [Openvpn-devel] TCP tunnel problem on Windows
Message-ID: <1527F40959C109439CBC334DE4758F280C10ED@...142...>
From: =?iso-8859-2?Q?Lipert_V=E1clav?= <VLipert@...141...>
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
Date: Thu Dec 11 04:31:02 2003
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

My client config file:

remote localhost
rport 2000
proto tcp-client
dev tap
ifconfig 192.168.16.43 255.255.255.0
secret key.txt
ping-restart 60
ping-timer-rem
persist-tun
persist-key
resolv-retry 86400
ping 45
comp-lzo
verb 5
mute 10

--------------------------
My server config file:

lport 443
proto tcp-server
dev tap
ifconfig 192.168.16.42 255.255.255.0
dev-node "Open VPN"
secret key.txt
ping 45
comp-lzo
verb 5
mute 10
---------------------------


Communication from client goes through HTTP proxy, which supports CONNECT m=
ethod on port 443. Program (PortTunnel) that sends CONNECT to proxy runs on=
 port 2000. It does same thing as http-proxy parameter in OpenVPN, but with=
 this parameter I had problems. When I use this parameter it generates foll=
owing errors after connecting (with help of PortTunnel it works OK):
----------------------------
Wed Dec 03 18:32:00 2003 37: Send to HTTP proxy: 'CONNECT mycomp.dyndns.ws:=
443 HTTP/1.0'
Wed Dec 03 18:32:04 2003 38: HTTP proxy returned: 'HTTP/1.0 200 OK'
Wed Dec 03 18:32:04 2003 39: TCPv4_CLIENT link local: [undef]
Wed Dec 03 18:32:04 2003 40: TCPv4_CLIENT link remote: 127.0.0.1:3128
Wed Dec 03 18:32:04 2003 41: TCPv4_CLIENT WRITE [60] to 127.0.0.1:3128:  DA=
TA len=3D60
Wed Dec 03 18:32:04 2003 42: TCPv4_CLIENT WRITE [84] to 127.0.0.1:3128:  DA=
TA len=3D84
Wed Dec 03 18:32:04 2003 43: TCPv4_CLIENT WRITE [84] to 127.0.0.1:3128:  DA=
TA len=3D84
Wed Dec 03 18:32:04 2003 44: WARNING: Bad encapsulated packet length from p=
eer (17505), which must be > 0 and <=3D 1579 -- please ensure that --tun-mt=
u or --link-mtu is equal on both peers -- this condition could also indicat=
e a possible active attack on the TCP link -- [Attemping restart...]
Wed Dec 03 18:32:04 2003 45: Connection reset, restarting [0]
Wed Dec 03 18:32:04 2003 46: PID packet_id_free
Wed Dec 03 18:32:04 2003 47: Closing TCP/UDP socket
Wed Dec 03 18:32:04 2003 48: Restart pause, 10 second(s)
----------------------------



Server is connected directly to internet via dial-up.


Vasek Lipert




-----Original Message-----
From: James Yonan [mailto:jim@...41...]=20
Sent: Wednesday, December 10, 2003 12:38 PM
To: Lipert V=E1clav; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] TCP tunnel problem on Windows

Lipert,

The error messages below occur because of an IRP Queue overrun in the
TAP-Win32 driver.  The IRP Queue handles the packet flow from the TAP drive=
r to the userspace component of OpenVPN.  Not sure why this would occur, th=
ough your config files might shed some light.

James

Lipert V=E1clav <VLipert@...141...> said:

> Hello,
>=20
> I am using OpenVPN 1.5.0 for Windows (windowsxp - windowsxp, tap,=20
> tcp-client
tcp-server) and I have one problem. After connection establishing work ping=
ing OK, but when I try connect from server to client with VNC or Remote Des=
ktop Connection (from Microsoft) it is working for few seconds (first screen
loaded) and then stops working all TCP/IP communication (pinging doesnt wor=
k).
On side of client it generates this error (on server side it is no error):
>=20
> Mon Dec 08 18:11:57 2003 672: TCPv4_CLIENT link local: [undef] Mon Dec=20
> 08 18:11:57 2003 673: TCPv4_CLIENT link remote: 127.0.0.1:2000 Mon Dec=20
> 08 18:11:57 2003 674: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:57 2003 675: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:57 2003 676: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:57 2003 677: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:57 2003 678: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:57 2003 679: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:57 2003 680: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:58 2003 681: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:58 2003 682: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:11:58 2003 683: read from TUN/TAP  [State=3DAT?c
Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=3D5 Tx=3D[315,0] Rx=3D[0=
,0] IrpQ=3D[16,16,16] PktQ=3D[0,10,64]]: General failure (ERROR_GEN_FAILURE=
) (code=3D31)
> Mon Dec 08 18:12:27 2003 684: 269 variation(s) on previous 10=20
> message(s)
suppressed by --mute
> Mon Dec 08 18:12:27 2003 685: Connection reset, restarting [0] Mon Dec=20
> 08 18:12:27 2003 686: Closing TCP/UDP socket Mon Dec 08 18:12:27 2003=20
> 687: Restart pause, 3 second(s)
>=20
>=20
> Anyone knows, where could be a problem?
>=20
> Thanks
> Wally
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it help you=20
> create better code?  SHARE THE LOVE, and help us help YOU!  Click=20
> Here: http://sourceforge.net/donate/=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--=20




