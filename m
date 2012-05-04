From: "Frank Renwick" <frenwick@...1715...>
Date: Fri, 4 May 2012 14:26:51 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0062_01CD2A01.F3637D90"
Message-ID: <AFA91706C02B434CAE842015F9FF3643.MAI@...1715...>
Subject: [Openvpn-devel] using --passtos in conjunction with --fragment in
	OpenVPN 2.2.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0062_01CD2A01.F3637D90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
 
I hope this question is appropriate for this list.  I tried the
openvpn-users list and did not get a response.
 
We use openvpn for router-to-router tunneling in a hub-and-spoke VPN
deployment.
 
We utilize the --fragment option to avoid IP-layer fragmentation.
 
Recently we encountered a use case in which it became desirable to pass the
ToS Byte from the inner IP payload to the OpenVPN IP header  (we wish the
outer IP header to inheret the ToS byte of the payload datagram).
 
OpenVPN provides the --passtos option for this purpose, and when used
without also implementing the --fragment option it works as advertised in
our test lab.  However, when we implement --passtos and --fragment together,
the ToS byte of the inner payload datagram is not copied directly to the
OpenVPN IP header.  For example, if 0xB8 is the ToS byte value in the
original payload, then the OpenVPN IP header is 0xC0.
 
I suspect that this issue is related to the 4-byte reservation incurred by
exercising the --fragment option.  Is there anything we can do to enable us
to use both options in conjunction?
 
Thanks,
 
frank
 

------=_NextPart_000_0062_01CD2A01.F3637D90
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.19170"></HEAD>
<BODY>
<DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012>Hello,</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D400435115-02052012><SPAN=20
class=3D142282521-04052012>I hope this question is appropriate for this=20
list.&nbsp; I tried the openvpn-users list and did not get a=20
response.</SPAN></SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D400435115-02052012>We use op=
envpn for=20
router-to-router tunneling in a hub-and-spoke VPN=20
deployment.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D400435115-02052012>We utiliz=
e the=20
--fragment option to avoid IP-layer fragmentation.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D400435115-02052012>Recently =
we=20
encountered a use case in which it became desirable to pass the ToS Byte fr=
om=20
the inner&nbsp;IP payload to the OpenVPN IP header&nbsp; (we wish the outer=
 IP=20
header to inheret the ToS byte of the payload datagram).</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D400435115-02052012>OpenVPN p=
rovides the=20
--passtos option for this purpose, and when used without also implementing =
the=20
--fragment option it works as advertised in our test lab.&nbsp; However, wh=
en we=20
implement --passtos and --fragment together, the ToS byte of the inner payl=
oad=20
datagram is not copied directly to the OpenVPN IP header.&nbsp; For example=
, if=20
0xB8 is the ToS byte value in the original payload, then the OpenVPN IP hea=
der=20
is 0xC0.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D400435115-02052012>I suspect=
 that this=20
issue is related to the 4-byte reservation incurred by exercising the --fra=
gment=20
option.&nbsp; Is there anything we can do to enable us to use both options =
in=20
conjunction?</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012>Thanks,</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012>frank</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D400435115-02052012></SPAN></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------=_NextPart_000_0062_01CD2A01.F3637D90--



