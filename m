From: "Thibault Le Meur" <Thibault.LeMeur@...1015...>
Date: Fri, 1 Jun 2007 09:37:54 +0200
Message-ID: <047b01c7a41f$c7f59390$161ce4a0@...1015...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_047C_01C7A430.8B7E6390"
In-Reply-To: <BAY128-W1C8597326B508CE3443CDFD2D0@...512...>
Subject: [Openvpn-devel] RE :  OPENVPN with OPENLDAP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Hisham Aziz' <shammer_@...160...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_047C_01C7A430.8B7E6390
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There is 2 approaches for this.
=20
One is tu use Brane F. Gracnar's addon :=20

 <http://frost.ath.cx/software/openvpn_auth/>
http://frost.ath.cx/software/openvpn_auth/

=20

Another is to use Ralf L=FCbben's Radius plugin and delegate every backend
search to the radius server.

=20

I, personnally, prefer solution 2, however it might not cope with all your
needs yet: for instance more work has to be done on the=20

radius dictionary so that all client configuration push options are
supported  (I need a little more time for this).

For more info see: http://www.nongnu.org/radiusplugin/

=20

HTH,

Thibault

=20

=20

-----Message d'origine-----
De : openvpn-devel-bounces@lists.sourceforge.net
[mailto:openvpn-devel-bounces@lists.sourceforge.net] De la part de Hisham
Aziz
Envoy=E9 : jeudi 31 mai 2007 22:20
=C0 : openvpn-devel@lists.sourceforge.net
Objet : *****SPAM***** [Openvpn-devel] OPENVPN with OPENLDAP


Hi...

Im just starting out with Openvpn, recently figured out how to create a
tunnel connection between two machines. Now im wondering if i can use
openvpn to connect and authenticate with an LDAP and query it to find
certain objects with certain attribute using some sort of script. Basically
Im asking here is in a typical client.conf file for a OpenVpn client where
would I need to execute such a script to query the LDAP database and also
what kind of script is best suited ( Perl, Python , SH, .bat ).

SO the questions are how do i do this and where in the file do i do this?
Here is my client.ovpn file. Obv it has to be changed, i was using this for
making a simple server/client tunnel with another machine using certs and
keys on my etoken smartcards.

**************************************************
pull
client

dev tun
proto udp
remote 128.100.103.211

port 1194
resolv-retry infinite
nobind

persist-key
persist-tun
verb 3

ca "C:\\temp\\ca.crt"

pkcs11-providers "C:\\PKI\\WC\\NSIS\\eTpkcs11.dll"
pkcs11-slot-type label
pkcs11-slot "eToken"

pkcs11-id-type id
pkcs11-id 06
*************************************************


Thanks




  _____=20=20

Discover the new Windows Vista Learn more!
<http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=3DQB=
RE>=20=20


------=_NextPart_000_047C_01C7A430.8B7E6390
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<TITLE>Message</TITLE>

<STYLE>P {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; P=
ADDING-TOP: 0px
}
BODY {
	FONT-SIZE: 10pt; FONT-FAMILY: Tahoma
}
</STYLE>

<META content=3D"MSHTML 6.00.2900.3086" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff><SPAN class=3D742152407-01062007>Th=
ere is 2=20
approaches for this.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff><SPAN=20
class=3D742152407-01062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D742152407-01062007><FONT face=3DArial color=3D#000=
0ff>One is=20
tu use Brane F. Gracnar's addon :</FONT>
<P><A href=3D"http://frost.ath.cx/software/openvpn_auth/"><U><FONT=20
face=3DArial>http://frost.ath.cx/software/openvpn_auth/</FONT></U></A></P>
<P>&nbsp;</P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN class=3D742152407-0106200=
7>Another=20
is to use Ralf L=FCbben's Radius plugin and delegate every backend search t=
o the=20
radius server.</SPAN></FONT></FONT></P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D742152407-01062007></SPAN></FONT></FONT>&nbsp;</P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN class=3D742152407-0106200=
7>I,=20
personnally, prefer solution 2, however it might not&nbsp;cope with all you=
r=20
needs yet: for instance more work&nbsp;has to be done on the=20
</SPAN></FONT></FONT></P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN class=3D742152407-0106200=
7>radius=20
dictionary so that all client configuration push options&nbsp;are=20
supported</SPAN>&nbsp;<SPAN class=3D742152407-01062007> (I need a little mo=
re time=20
for this).</SPAN></FONT></FONT></P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN class=3D742152407-0106200=
7>For more=20
info see: <A=20
href=3D"http://www.nongnu.org/radiusplugin/">http://www.nongnu.org/radiuspl=
ugin/</A></SPAN></FONT></FONT></P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D742152407-01062007></SPAN></FONT></FONT>&nbsp;</P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D742152407-01062007>HTH,</SPAN></FONT></FONT></P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D742152407-01062007>Thibault</SPAN></FONT></FONT></P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D742152407-01062007></SPAN></FONT></FONT>&nbsp;</P>
<P><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D742152407-01062007></SPAN></FONT></FONT>&nbsp;</P></SPAN></FONT></D=
IV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Dfr dir=3Dltr align=3Dleft><FONT=
=20
  face=3DTahoma>-----Message d'origine-----<BR><B>De&nbsp;:</B>=20
  openvpn-devel-bounces@lists.sourceforge.net=20
  [mailto:openvpn-devel-bounces@lists.sourceforge.net] <B>De la part de</B>=
=20
  Hisham Aziz<BR><B>Envoy=E9&nbsp;:</B> jeudi 31 mai 2007 22:20<BR><B>=C0&n=
bsp;:</B>=20
  openvpn-devel@lists.sourceforge.net<BR><B>Objet&nbsp;:</B> *****SPAM*****=
=20
  [Openvpn-devel] OPENVPN with OPENLDAP<BR><BR></FONT></DIV>Hi...<BR><BR>Im=
 just=20
  starting out with Openvpn, recently figured out how to create a tunnel=20
  connection between two machines. Now im wondering if i can use openvpn to=
=20
  connect and authenticate with an LDAP and query it to find certain object=
s=20
  with certain attribute using some sort of script. Basically Im asking her=
e is=20
  in a typical client.conf file for a OpenVpn client where would I need to=
=20
  execute such a script to query the LDAP database and also what kind of sc=
ript=20
  is best suited ( Perl, Python , SH, .bat ).<BR><BR>SO the questions are h=
ow do=20
  i do this and where in the file do i do this?<BR>Here is my client.ovpn f=
ile.=20
  Obv it has to be changed, i was using this for making a simple server/cli=
ent=20
  tunnel with another machine using certs and keys on my etoken=20
  smartcards.<BR><BR>**************************************************<BR>=
pull<BR>client<BR><BR>dev=20
  tun<BR>proto udp<BR>remote 128.100.103.211<BR><BR>port 1194<BR>resolv-ret=
ry=20
  infinite<BR>nobind<BR><BR>persist-key<BR>persist-tun<BR>verb 3<BR><BR>ca=
=20
  "C:\\temp\\ca.crt"<BR><BR>pkcs11-providers=20
  "C:\\PKI\\WC\\NSIS\\eTpkcs11.dll"<BR>pkcs11-slot-type label<BR>pkcs11-slo=
t=20
  "eToken"<BR><BR>pkcs11-id-type id<BR>pkcs11-id=20
  06<BR>*************************************************<BR><BR><BR>Thanks=
<BR><BR><BR><BR>
  <HR>
  Discover the new Windows Vista <A=20
  href=3D"http://search.msn.com/results.aspx?q=3Dwindows+vista&amp;mkt=3Den=
-US&amp;form=3DQBRE"=20
  target=3D_new>Learn more!</A> </BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_047C_01C7A430.8B7E6390--



