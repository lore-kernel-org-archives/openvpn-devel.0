Message-ID: <20686C579479DC438276A726FE80CDAA020E05FC@...281...>
From: satinders@...280...
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4D8EA.9C803010"
Subject: [Openvpn-devel] Plug-in to modify payload flowing over tunnel
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
Date: Thu Dec  2 19:42:02 2004
To: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4D8EA.9C803010
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
  Does openvpn support any plug-in for viewing and modifying the payload
to/from tunnel just before encryption and after decryption? I need to add
some fields in the messages going to and coming from tunnel. I need this for
both control and data messages.

I looked into 2.0_beta18 and didn't find any. I am planning to add such
plug-in. The point I identified are:

for changing messages flowing to tunnel:
	In the beginning of method encrypt_sign. 

for changing messages flowing from tunnel:
	At the end of method process_incoming_link just before processing of
ping and occ messages.

This is based on my assumption that all messages to tunnel are calling
encrypt_sign method for encrypting the data. Do you have any plan to change
the logic/name/location for these methods which may alter this assumption.

Please comment.

Regards,
Satinder Singh

------_=_NextPart_001_01C4D8EA.9C803010
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>Plug-in to modify payload flowing over tunnel</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi,</FONT>
<BR><FONT SIZE=3D2>&nbsp; Does openvpn support any plug-in for viewing and =
modifying the payload to/from tunnel just before encryption and after decry=
ption? I need to add some fields in the messages going to and coming from t=
unnel. I need this for both control and data messages.</FONT></P>

<P><FONT SIZE=3D2>I looked into 2.0_beta18 and didn't find any. I am planni=
ng to add such plug-in. The point I identified are:</FONT>
</P>

<P><FONT SIZE=3D2>for changing messages flowing to tunnel:</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>In the beginn=
ing of method encrypt_sign. </FONT>
</P>

<P><FONT SIZE=3D2>for changing messages flowing from tunnel:</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>At the end of=
 method process_incoming_link just before processing of ping and occ messag=
es.</FONT>
</P>

<P><FONT SIZE=3D2>This is based on my assumption that all messages to tunne=
l are calling encrypt_sign method for encrypting the data. Do you have any =
plan to change the logic/name/location for these methods which may alter th=
is assumption.</FONT></P>

<P><FONT SIZE=3D2>Please comment.</FONT>
</P>

<P><FONT SIZE=3D2>Regards,</FONT>
<BR><FONT SIZE=3D2>Satinder Singh</FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C4D8EA.9C803010--

