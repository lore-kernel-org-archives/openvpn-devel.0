Message-ID: <20686C579479DC438276A726FE80CDAA01BC1A45@...281...>
From: satinders@...280...
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4AB97.7EC94EB0"
Subject: [Openvpn-devel] Suggestion: OpenVPN should provide hooks
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
Date: Wed Oct  6 04:31:31 2004
To: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4AB97.7EC94EB0
Content-Type: text/plain;
	charset="iso-8859-1"

OpenVPN should provide hooks just like apache server. This will facilitate
customization of openvpn features. One of the hooks could be
post_tunnel_read_request  which will be called when openvpn reads message
from remote peer. One can add his own treament to message through this
request.

This will greatly improve openvpn's adaptability.

We can have same implementation as in apache (through modules, function
registration) or we can have blank callbacks which developer can fill-in to
acheieve feature enhancments.

Developer should be able to write his module having implementation of
various hooks and then just compile it with openvpn.

Regards,
Satinder Singh

------_=_NextPart_001_01C4AB97.7EC94EB0
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>Suggestion: OpenVPN should provide hooks </TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>OpenVPN should provide hooks just like apache server. Thi=
s will facilitate customization of openvpn features. One of the hooks could=
 be post_tunnel_read_request&nbsp; which will be called when openvpn reads =
message from remote peer. One can add his own treament to message through t=
his request.</FONT></P>

<P><FONT SIZE=3D2>This will greatly improve openvpn's adaptability.</FONT>
</P>

<P><FONT SIZE=3D2>We can have same implementation as in apache (through mod=
ules, function registration) or we can have blank callbacks which developer=
 can fill-in to acheieve feature enhancments.</FONT></P>

<P><FONT SIZE=3D2>Developer should be able to write his module having imple=
mentation of various hooks and then just compile it with openvpn.</FONT></P>

<P><FONT SIZE=3D2>Regards,</FONT>
<BR><FONT SIZE=3D2>Satinder Singh</FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C4AB97.7EC94EB0--

