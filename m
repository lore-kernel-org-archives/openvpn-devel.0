Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CCBF.7B7F047B"
Date: Thu, 31 Aug 2006 13:37:00 +0800
Message-ID: <E42673822206994F8293A048721B91A51346C8@...754...>
From: "Wang, Daming" <daming.wang@...753...>
Subject: [Openvpn-devel] a question about how to program tap_win32 driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6CCBF.7B7F047B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

hello:
=20
I am trying to write a simple program which functions like this:
first create a socket and bind the socket to the virtual tap_win32
driver provided
by openVPN, the tap ip was setted as "10.0.3.1". So if I use the socket
to send
out packet, the packet will be transmitted to the user space,right?=20
And then, I use a program which get a handle associated with the tap
driver
through "createfile" in tun.c and use "readfile" (in tun.c) trying to
get the
packet ,but the readfile always return failure(err=3D31).=20
=20
My question is: did I understand the usage procedure correctly? If so,
is the
method used in my program correctly? If not,can you give me some advice?
thank
you very much!
=20
best wishes!
michael,wang

=20

=20


------_=_NextPart_001_01C6CCBF.7B7F047B
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple style=3D'text-justify-trim:pu=
nctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'fon=
t-size:12.0pt'>hello:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>I am trying to write a simple program which functions like this:<o:p></=
o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>first create a socket and bind the socket to the virtual tap_win32 driv=
er provided<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>by openVPN, the tap ip was setted as &quot;10.0.3.1&quot;. So if I use =
the socket to send<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>out packet, the packet will be transmitted to the user space,right? <o:=
p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>And then, I use a program which get a handle associated with the tap dr=
iver<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>through &quot;createfile&quot; in tun.c and use &quot;readfile&quot; (i=
n tun.c) trying to get the<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>packet ,but the readfile always return failure(err=3D31). <o:p></o:p></=
span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>My question is: did I understand the usage procedure correctly? If so, =
is the<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>method used in my program correctly? If not,can you give me some advice=
? thank<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>you very much!<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>best wishes!<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US style=3D'font-size:12.0=
pt'>michael,wang<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span lang=3DE=
N-US
style=3D'font-size:10.5pt'>&nbsp;</span><span lang=3DEN-US><o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span lang=3DE=
N-US><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6CCBF.7B7F047B--

