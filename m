Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9862D.12A546EC"
Date: Tue, 3 Feb 2009 19:27:28 +0100
Message-ID: <9C8E8B77B6BAD3418C916FFE1185189301727E02@...545...>
From: "CROKAERT Pierre" <pct@...544...>
Subject: [Openvpn-devel] Use redirect-gateway when no default gateway defined
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

------_=_NextPart_001_01C9862D.12A546EC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I have a system connected to VPN through a local proxy, and I would like
to use the -redirect-gateway option.

I have selected the 'local' and 'def1' options to prevent any access to
the net_gateway member,=20

but the line:

=20

     else if (!rl->spec.net_gateway_defined) -- > in
redirect_default_route_to_vpn

=20

will prevent the redirect to be executed (although the net_gateway is
not used any more).

=20

Do you see another way to define this gateway, or shouldn't we add a
condition like this to allow redirect even if no gateway defined.

=20

else if (!rl->spec.net_gateway_defined)

{

      if ( (!rl->redirect_local) || (!rl->redirect_def1) /* OpenVPN 2.1
|| (rl->spec.bypass->n_bypass) */ )

      {

        msg (M_WARN, "%s Cannot read current default gateway from
system", err);

      }

}

=20

=20

Thank you,

=20

Pierre

=20


------_=_NextPart_001_01C9862D.12A546EC
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:off=
ice:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DFR-BE
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hello,<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DFR-BE
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>I have a system connec=
ted to
VPN through a local proxy, and I would like to use the &#8211;redirect-gate=
way
option.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>I have selected the &#=
8216;local&#8217;
and &#8216;def1&#8217; options to prevent any access to the net_gateway mem=
ber,
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>but the line:<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbs=
p; else if
(!rl-&gt;spec.net_gateway_defined) -- &gt; in redirect_default_route_to_vpn=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>will prevent the redir=
ect to
be executed (although the net_gateway is not used any more).<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>Do you see another way=
 to
define this gateway, or shouldn&#8217;t we add a condition like this to all=
ow
redirect even if no gateway defined.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>else if
(!rl-&gt;spec.net_gateway_defined)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>{<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (
(!rl-&gt;redirect_local) || (!rl-&gt;redirect_def1) /* OpenVPN 2.1 ||
(rl-&gt;spec.bypass-&gt;n_bypass) */ )<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp; msg (M_WARN,
&quot;%s Cannot read current default gateway from system&quot;, err);<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>}<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>Thank you,<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

<p class=3DMsoNormal><st1:City w:st=3D"on"><st1:place w:st=3D"on"><font siz=
e=3D2
  face=3D"Courier New"><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fa=
mily:"Courier New"'>Pierre</span></font></st1:place></st1:City><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB style=3D'font-size:10.0pt;=
font-family:
"Courier New"'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></spa=
n></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9862D.12A546EC--

