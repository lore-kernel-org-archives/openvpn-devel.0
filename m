Message-ID: <a6589cd6041105091611d082c6@...278...>
From: Hans Fugal <fugalh@...277...>
Reply-To: Hans Fugal <fugalh@...277...>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_209_30847182.1099674986860"
Subject: [Openvpn-devel] CreateFile failed on TAP device
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
Date: Fri Nov  5 09:22:13 2004
To: openvpn-devel@lists.sourceforge.net

------=_Part_209_30847182.1099674986860
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A user is getting this error. She's using XP

Fri Nov 05 09:07:24 2004 us=747770 CreateFile failed on TAP device:
\\.\Global\{A3B605BE-B118-49BA-92C3-C6ADFD7A364C}.tap: The system
cannot find the file specified.   (errno=2)

Attached is her full log. She was connecting just fine yesterday. I've
had her stop and start via openvpn gui, with the same results (this
log file is from the start after the stop)

I don't know what to tell her, other than to uninstall, reboot, and
reinstall. Does anyone have any other advice?

-- 
De gustibus non disputandum est.

------=_Part_209_30847182.1099674986860
Content-Type: text/plain; name="VPN Log 11-05-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="VPN Log 11-05-04.txt"

Fri Nov 05 09:07:15 2004 us=3D852765 Current Parameter Settings:
Fri Nov 05 09:07:15 2004 us=3D853005   config =3D 'wencor.ovpn'
Fri Nov 05 09:07:15 2004 us=3D853046   mode =3D 0
Fri Nov 05 09:07:15 2004 us=3D853086   show_ciphers =3D DISABLED
Fri Nov 05 09:07:15 2004 us=3D853126   show_digests =3D DISABLED
Fri Nov 05 09:07:15 2004 us=3D853513 160 variation(s) on previous 5 message=
(s) suppressed by --mute
Fri Nov 05 09:07:15 2004 us=3D853567 OpenVPN 2.0_beta11 Win32-MinGW [SSL] [=
LZO] built on Aug 18 2004
Fri Nov 05 09:07:15 2004 us=3D860126 LZO compression initialized
Fri Nov 05 09:07:15 2004 us=3D860685 Control Channel MTU parms [ L:1542 D:1=
38 EF:38 EB:0 ET:0 EL:0 ]
Fri Nov 05 09:07:15 2004 us=3D981892 Data Channel MTU parms [ L:1542 D:1450=
 EF:42 EB:19 ET:0 EL:0 ]
Fri Nov 05 09:07:15 2004 us=3D982098 Local Options String: 'V4,dev-type tun=
,link-mtu 1542,tun-mtu 1500,proto UDPv4,comp-lzo,cipher BF-CBC,auth SHA1,ke=
ysize 128,key-method 2,tls-client'
Fri Nov 05 09:07:15 2004 us=3D982158 Expected Remote Options String: 'V4,de=
v-type tun,link-mtu 1542,tun-mtu 1500,proto UDPv4,comp-lzo,cipher BF-CBC,au=
th SHA1,keysize 128,key-method 2,tls-server'
Fri Nov 05 09:07:15 2004 us=3D982276 Local Options hash (VER=3DV4): '416909=
19'
Fri Nov 05 09:07:15 2004 us=3D982361 Expected Remote Options hash (VER=3DV4=
): '530fdded'
Fri Nov 05 09:07:15 2004 us=3D982526 Socket Buffers: R=3D[8192->8192] S=3D[=
8192->8192]
Fri Nov 05 09:07:15 2004 us=3D982612 UDPv4 link local (bound): [undef]:5000
Fri Nov 05 09:07:15 2004 us=3D982669 UDPv4 link remote: 204.96.22.195:5000
Fri Nov 05 09:07:16 2004 us=3D154584 TLS Error: Unroutable control packet r=
eceived from 204.96.22.195:5000 (si=3D3 op=3DP_CONTROL_V1)
Fri Nov 05 09:07:16 2004 us=3D260380 TLS: Initial packet from 204.96.22.195=
:5000, sid=3D3d13f385 c9efe0c3
Fri Nov 05 09:07:17 2004 us=3D936832 TLS Error: Unroutable control packet r=
eceived from 204.96.22.195:5000 (si=3D3 op=3DP_CONTROL_V1)
Fri Nov 05 09:07:17 2004 us=3D944331 VERIFY OK: depth=3D1, /C=3DUS/ST=3DUta=
h/L=3DSpringville/O=3DWencor.West.Inc/OU=3DIT/CN=3DWencor.OpenVPN.Certifica=
te.Authority/emailAddress=3Dsysadm@...304...
Fri Nov 05 09:07:17 2004 us=3D945390 VERIFY OK: depth=3D0, /C=3DUS/ST=3DUta=
h/O=3DWencor.West.Inc/OU=3DIT/CN=3Ddent.wencor.com/emailAddress=3Dsysadm@...305...=
ncor.com
Fri Nov 05 09:07:20 2004 us=3D682173 TLS Error: Unroutable control packet r=
eceived from 204.96.22.195:5000 (si=3D3 op=3DP_CONTROL_V1)
Fri Nov 05 09:07:21 2004 us=3D826992 TLS Error: Unroutable control packet r=
eceived from 204.96.22.195:5000 (si=3D3 op=3DP_CONTROL_V1)
Fri Nov 05 09:07:22 2004 us=3D112511 Data Channel Encrypt: Cipher 'BF-CBC' =
initialized with 128 bit key
Fri Nov 05 09:07:22 2004 us=3D112648 Data Channel Encrypt: Using 160 bit me=
ssage hash 'SHA1' for HMAC authentication
Fri Nov 05 09:07:22 2004 us=3D112919 Data Channel Decrypt: Cipher 'BF-CBC' =
initialized with 128 bit key
Fri Nov 05 09:07:22 2004 us=3D112981 Data Channel Decrypt: Using 160 bit me=
ssage hash 'SHA1' for HMAC authentication
Fri Nov 05 09:07:22 2004 us=3D179610 Control Channel: TLSv1, cipher TLSv1/S=
SLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Fri Nov 05 09:07:22 2004 us=3D179842 [dent.wencor.com] Peer Connection Init=
iated with 204.96.22.195:5000
Fri Nov 05 09:07:24 2004 us=3D279684 SENT CONTROL [dent.wencor.com]: 'PUSH_=
REQUEST' (status=3D1)
Fri Nov 05 09:07:24 2004 us=3D664452 PUSH: Received control message: 'PUSH_=
REPLY,route 172.16.59.0 255.255.255.0,dhcp-option DOMAIN wencor.com,dhcp-op=
tion DNS 172.16.59.3,dhcp-option DNS 172.16.59.7,dhcp-option WINS 172.16.59=
.1,route 172.16.97.1,ping 10,ping-restart 60,ifconfig 172.16.97.246 172.16.=
97.245'
Fri Nov 05 09:07:24 2004 us=3D664723 OPTIONS IMPORT: timers and/or timeouts=
 modified
Fri Nov 05 09:07:24 2004 us=3D664779 OPTIONS IMPORT: --ifconfig/up options =
modified
Fri Nov 05 09:07:24 2004 us=3D664823 OPTIONS IMPORT: route options modified
Fri Nov 05 09:07:24 2004 us=3D747538 1 variation(s) on previous 5 message(s=
) suppressed by --mute
Fri Nov 05 09:07:24 2004 us=3D747770 CreateFile failed on TAP device: \\.\G=
lobal\{A3B605BE-B118-49BA-92C3-C6ADFD7A364C}.tap: The system cannot find th=
e file specified.   (errno=3D2)
Fri Nov 05 09:07:24 2004 us=3D747824 Exiting
------=_Part_209_30847182.1099674986860--

