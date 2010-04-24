From: <openvpn@...1315...>
Date: Fri, 23 Apr 2010 23:54:28 -0500
Message-id: <1272084868166011500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=5717636928350712383671694560672050663883=axigen==="
Subject: [Openvpn-devel] Status Message Missing IP Address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=5717636928350712383671694560672050663883=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline







 *=20
 *=20
 *=20





Hi,

=20

I have found what seems to be an interesting feature (bug) of the managemen=
t interface =E2=80=93 as I have been using it to write a connection monitor=
 application.

=20

Up until recently I have been using the server-bridge command on the server=
, and setting up a bridge (allowing OpenVPN to assign the IP address). When=
 I did this the management interface on the client reported the IP address =
that it was assigned (both in real-time or manual state commands). However,=
 now I have changed the server configuration file to allow the local DHCP s=
erver (router) to assign the client IP address. While this works fine, and =
the client connection is functional, the management interface no longer rep=
orts the client IP address.

=20

Is this a known (or for some reason planned) mode of operation?

=20

Thanks,

=E2=80=A6 Russell

=20

=20

--===axigen=5717636928350712383671694560672050663883=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><BR>
<DIV style=3D"null: ">
<META content=3D"text/html; charset=3Dus-ascii" equiv=3D"Content-Type" http=
=3D"http">
<META name=3DProgId content=3DWord.Document>
<META name=3DGenerator content=3D"Microsoft Word 12">
<META name=3DOriginator content=3D"Microsoft Word 12"><LINK rel=3DFile-List=
><LINK rel=3DthemeData href=3D"~~themedata~~"><LINK rel=3DcolorSchemeMappin=
g href=3D"~~colorschememapping~~">
<STYLE>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1107304683 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Arial Rounded MT Bold";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	mso-themecolor:hyperlink;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</STYLE>

<DIV class=3DSection1>
<P class=3DMsoNormal>Hi,<?xml:namespace prefix =3D o /><o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>I have found what seems to be an interesting feature (=
bug) of the management interface =E2=80=93 as I have been using it to write=
 a connection monitor application.<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>Up until recently I have been using the server-bridge =
command on the server, and setting up a bridge (allowing <SPAN class=3DSpel=
lE>OpenVPN</SPAN> to assign the IP address). When I did this the management=
 interface on the client reported the IP address that it was assigned (both=
 in real-time or manual state commands). However, now I have changed the se=
rver configuration file to allow the local DHCP server (router) to assign t=
he client IP address. While this works fine, and the client connection is f=
unctional, the management interface no longer reports the client IP address=
.<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>Is this a known (or for some reason planned) mode of o=
peration?<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>Thanks,<o:p></o:p></P>
<P class=3DMsoNormal>=E2=80=A6 Russell<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P></DIV></DIV></body></html>=

--===axigen=5717636928350712383671694560672050663883=axigen===--


