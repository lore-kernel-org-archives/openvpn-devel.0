Message-ID: <001701c5ae5b$98bd31c0$6728320a@...445...>
From: "Raphael Couto" <rcouto@...443...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01C5AE42.71FC1E70"
Subject: [Openvpn-devel] OpenVPN and HPUX
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
Date: Wed Aug 31 11:42:11 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C5AE42.71FC1E70
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI,

    I have a HP machine (HPUX 11.00), and I'm trying to run openvpn. The co=
mpilation was ok, but when I try to run openvpn:

root@...444.../root# /usr/local/sbin/openvpn --config openvpn_server.conf
Wed Aug 31 15:27:04 2005 OpenVPN 2.0 hppa2.0w-hp-hpux11.00 [SSL] [LZO] buil=
t on Aug 15 2005
Wed Aug 31 15:27:04 2005 Diffie-Hellman initialized with 1024 bit key
Wed Aug 31 15:27:04 2005 TLS-Auth MTU parms [ L:1544 D:140 EF:40 EB:0 ET:0 =
EL:0 ]
Wed Aug 31 15:27:04 2005 TUN/TAP device /dev/tun0 opened
Wed Aug 31 15:27:04 2005 Sorry, but I don't know how to do 'ifconfig' comma=
nds on this operating system.  You should ifconfig your TUN/TAP device manu=
ally or use an --up script.
Wed Aug 31 15:27:04 2005 Exiting

    I'm not an expert on HPUX. I'm trying to configure tun interface manual=
ly, but no success.

    Anybody can help?

    Thanks.

    Raphael


------=_NextPart_000_0014_01C5AE42.71FC1E70
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1515" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>HI,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; I have a HP machine (HP=
UX=20
11.00), and I'm trying to run openvpn. The compilation was ok, but when I t=
ry to=20
run openvpn:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:root@...444.../root# /usr/local/sbin/openvpn">root@...444...=
/root#=20
/usr/local/sbin/openvpn</A> --config openvpn_server.conf<BR>Wed Aug 31 15:2=
7:04=20
2005 OpenVPN 2.0 hppa2.0w-hp-hpux11.00 [SSL] [LZO] built on Aug 15 2005<BR>=
Wed=20
Aug 31 15:27:04 2005 Diffie-Hellman initialized with 1024 bit key<BR>Wed Au=
g 31=20
15:27:04 2005 TLS-Auth MTU parms [ L:1544 D:140 EF:40 EB:0 ET:0 EL:0 ]<BR>W=
ed=20
Aug 31 15:27:04 2005 TUN/TAP device /dev/tun0 opened<BR>Wed Aug 31 15:27:04=
 2005=20
Sorry, but I don't know how to do 'ifconfig' commands on this operating=20
system.&nbsp; You should ifconfig your TUN/TAP device manually or use an --=
up=20
script.<BR>Wed Aug 31 15:27:04 2005 Exiting<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; I'm not an expert&nbsp;=
on HPUX.=20
I'm trying to configure tun interface manually, but no success.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; Anybody can help?</FONT=
></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; Thanks.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; Raphael</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_0014_01C5AE42.71FC1E70--


