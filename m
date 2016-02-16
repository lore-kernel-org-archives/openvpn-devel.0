From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C3205A.6050408@...515...>
Date: Tue, 16 Feb 2016 15:12:58 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Always including tap-windows6,
 openvpn-gui and easy-rsa in openvpn-build -generated Windows
 installers?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Currently openvpn-build allows producing installers which do not=20
_contain_ tap-windows6, openvpn-gui or easy-rsa at all. On top of this=20
one can - at install time - select which of the contained components are=20
intalled.

Let me know if you have good arguments on why we should have the option=20
to generate installers without the said components. If nobody speaks up,=20
I'll remove the conditional code from openvpn.nsi while preparing for=20
the OpenVPN 2.4 release.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

