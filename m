Message-ID: <000801c498aa$992b23a0$8100a8c0@...267...>
From: "gary" <linux@...266...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C498ED.A6CE1010"
Subject: [Openvpn-devel] minimum cipher in openssl ?
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
Date: Sun Sep 12 02:27:01 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C498ED.A6CE1010
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I want to run openvpn on WRT54G but the crypto library of openssl is extrem=
ely large for the device. I understand that I can trim away some ciphers bu=
t would like to know what minimum ciphers I have to include. I want to incl=
ude only 3 symmetric cipher (blowfish, des and aes) and sha1 for key stuff.=
 What else is needed for a basic functional openvpn with TLS support ? No k=
ey generation function etc.(like the dh thing) is needed as that I can do o=
n some other hosting machine(I assume).=

------=_NextPart_000_0005_01C498ED.A6CE1010
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I want to run openvpn on WRT54G but the cr=
ypto=20
library of openssl is extremely large for the device. I understand that I c=
an=20
trim away some ciphers but would like to know what minimum ciphers I have t=
o=20
include. I want to include only 3 symmetric cipher (blowfish, des and aes) =
and=20
sha1 for key stuff. What else is needed for a basic functional openvpn with=
 TLS=20
support ? No key generation function etc.(like the dh thing)&nbsp;is needed=
 as=20
that I can do on some other hosting machine(I=20
assume).</FONT></DIV></BODY></HTML>

------=_NextPart_000_0005_01C498ED.A6CE1010--


