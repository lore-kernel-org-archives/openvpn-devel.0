Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C62BED.8C92C3B4"
Message-ID: <9C8E8B77B6BAD3418C916FFE1185189302C285@...545...>
From: "CROKAERT Pierre" <pcrokaert@...544...>
Subject: [Openvpn-devel] bug in suppress-timestamps option rev 2.0.5
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
Date: Tue Feb  7 11:19:04 2006
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C62BED.8C92C3B4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

When using the suppress-timestamps option, the following option
parameter is incorrectly skipped. The ++i must be remove.
REM: this is not an issue in rev 2.1 beta because the parameter count
method has changed.
=20
Rev 2.0.5
=20
  else if (streq (p[0], "suppress-timestamps"))
    {
      ++i;    <------- to remove
      VERIFY_PERMISSION (OPT_P_GENERAL);
      options->suppress_timestamps =3D true;
      set_suppress_timestamps(true);
    }

=20
Should be (there is only one parameter for this option)
=20
  else if (streq (p[0], "suppress-timestamps"))
    {
      VERIFY_PERMISSION (OPT_P_GENERAL);
      options->suppress_timestamps =3D true;
      set_suppress_timestamps(true);
    }

=20
=20

------_=_NextPart_001_01C62BED.8C92C3B4
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D875185910-07022006><SPAN=20
class=3D265304613-07022006>When using the suppress-timestamps option, the=20
following option parameter is incorrectly skipped. The ++i must be=20
remove.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D875185910-07022006><SPAN=20
class=3D265304613-07022006>REM: this is not an issue in rev 2.1 beta becaus=
e the=20
parameter count method has changed.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D875185910-07022006><SPAN=20
class=3D265304613-07022006></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D875185910-07022006>Rev=20
2.0.5</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D875185910-07022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; else if (streq (p[0],=20
"suppress-timestamps"))<BR>&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++i;<SPAN=20
class=3D265304613-07022006>&nbsp;&nbsp;&nbsp; &lt;------- to=20
remove</SPAN><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VERIFY_PERMISSION=20
(OPT_P_GENERAL);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
options-&gt;suppress_timestamps =3D true;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
set_suppress_timestamps(true);<BR>&nbsp;&nbsp;&nbsp; }</FONT></DIV>
<DIV><FONT face=3DArial></FONT><FONT size=3D2><BR>&nbsp;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D875185910-07022006>Should be=
 (there is=20
only one parameter for this option)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><FONT face=3DArial>&nbsp; else if (streq (p[0],=20
"suppress-timestamps"))<BR>&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VERIFY_PERMISSION=20
(OPT_P_GENERAL);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
options-&gt;suppress_timestamps =3D true;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
set_suppress_timestamps(true);<BR>&nbsp;&nbsp;&nbsp; }<BR></FONT></FONT></D=
IV>
<DIV><FONT size=3D2><FONT face=3DArial></FONT></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><FONT=20
face=3DArial>&nbsp;</DIV></FONT></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C62BED.8C92C3B4--

