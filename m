Message-ID: <1300.212.114.222.10.1080315611.squirrel@...190...>
From: "Markus Gsottberger" <ml-lists@...189...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Tunnel Problem Linux<->Windows2000
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
Date: Fri Mar 26 07:41:59 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

i'm using OpenVPN 1.5 on Linux and Windows2000 and have a Problem.
Ping and traceroute works fine through the tunnel. But wenn i for example
try to transfer files it fails after a few kb. Any ideas?
My config and the Error Message on the client are below.
Thx in advance.

-- Markus

Linux (Daemon):
openvpn --dev tap --port 5001 --verb 3 --udp-mtu 1500 --comp-lzo --daemon

Windows 2000 (Client):
openvpn --dev-node tap-00 --ping 10 --remote foo.bar.de --port 5001 --verb
3 --mute 10 --udp-mtu 1500 --comp-lzo --float

Fri Mar 26 16:25:39 2004 27: read from TUN/TAP=20
[State=3DAT?cErr=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[6=
18,0]
Rx=3D[350,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20
(code=3D234)
Fri Mar 26 16:25:39 2004 28: read from TUN/TAP
[State=3DAT?c Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[=
622,0]
Rx=3D[354,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20=20
(code=3D234)
Fri Mar 26 16:25:40 2004 29: read from TUN/TAP
[State=3DAT?c Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[=
631,0]
Rx=3D[363,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20=20
(code=3D234)
Fri Mar 26 16:25:42 2004 30: read from TUN/TAP
[State=3DAT?c Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[=
632,0]
Rx=3D[363,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20=20
(code=3D234)
Fri Mar 26 16:25:45 2004 31: read from TUN/TAP
[State=3DAT?c Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[=
633,0]
Rx=3D[363,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20=20
(code=3D234)
Fri Mar 26 16:25:52 2004 32: read from TUN/TAP
[State=3DAT?c Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[=
634,0]
Rx=3D[363,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20=20
(code=3D234)
Fri Mar 26 16:26:04 2004 33: read from TUN/TAP
[State=3DAT?c Err=3D[c:\src\openvpn\tap-win32\tapdrvr.c/2019] #O=3D3 Tx=3D[=
635,0]
Rx=3D[363,0] IrpQ=3D[0,1,16] PktQ=3D[0,10,64]]: Es sind mehr Daten verf=B3g=
bar.=20=20
(code=3D234)



