Message-Id: <200403111500.i2BF0uFw018614@...179...>
From: "Marc Hassman" <mhassman@...178...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001C_01C40746.EB359900"
Subject: [Openvpn-devel] route from server?
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
Date: Thu Mar 11 08:42:31 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C40746.EB359900
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

A question and a suggestion:
 
Q: This is probably an XP problem rather than a OpenVPN one. With Windows XP
as a client, I can 
add an arbitrary route using the 'route' statement and I observe it being
added in the 'route print' listing.
However, a few seconds later the route disappears from XP's routing table.
Has anybody else 
experienced this?
 
S: It would be helpful when running in a 1 config file/tcp/tap/inetd setup
if the server end of the connection
could push static routes to the client thereby making a change a single
server file change and not a 
per client file change. I think this might be beneficial to other setups as
well.
 
Thanks for your efforts, 
Marc H
 

------=_NextPart_000_001C_01C40746.EB359900
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>A questio=
n and a=20
suggestion:</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>Q: This i=
s probably=20
an XP problem rather than a OpenVPN one. With Windows XP as a client, I can=
=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>add an ar=
bitrary=20
route using the 'route' statement and I observe it being added in the 'rout=
e=20
print' listing.</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>However, =
a few=20
seconds later the route disappears from XP's routing table. Has anybody els=
e=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>experienc=
ed=20
this?</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>S: It wou=
ld be=20
helpful when running in a 1 config file/tcp/tap/inetd setup if the server e=
nd of=20
the connection</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>could pus=
h static=20
routes to the client thereby making a change a single server file change an=
d not=20
a </FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>per clien=
t file=20
change. I think this might be beneficial to other setups as=20
well.</FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>Thanks fo=
r your=20
efforts, </FONT></SPAN></DIV>
<DIV><SPAN class=3D420114114-11032004><FONT face=3DArial size=3D2>Marc=20
H</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_001C_01C40746.EB359900--


