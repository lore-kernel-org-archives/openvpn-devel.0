content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C43A1D.F75C156A"
Message-ID: <2A4D228810E123409F4E80AAD2C3D034339140@...218...>
From: "Chris Timmons" <ChrisT@...217...>
Subject: [Openvpn-devel] Openvpn clustering
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
Date: Sat May 15 12:02:04 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C43A1D.F75C156A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am curious to see if there is any way you can distribute openvpn to a
cluster of firewalls?  I am thinking specifically of two or more Soekris
4801+vpn1411 cards, all clustered with Openbsd 3.5+carp+pfsync.

I have tried it, but I could not get it to work. The vpn connection
would continually reset after a minute or so as it would jump from one
box to the other and back. I can point clients at specific machines or
ports, but that loses all scalability.

Ideas? Thoughts? Too ambitious? Cluebat?

Thanks,

Chris.


------_=_NextPart_001_01C43A1D.F75C156A
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.0.6487.1">
<TITLE>Openvpn clustering</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">I am curious to see if there is any way yo=
u can distribute openvpn to a cluster of firewalls?&nbsp; I am thinking spe=
cifically of two or more Soekris 4801+vpn1411 cards, all clustered with Ope=
nbsd 3.5+carp+pfsync.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have tried it, but I could not get it to=
 work. The vpn connection would continually reset after a minute or so as i=
t would jump from one box to the other and back. I can point clients at spe=
cific machines or ports, but that loses all scalability.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Ideas? Thoughts? Too ambitious? Cluebat?</=
FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Chris.</FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C43A1D.F75C156A--

