From: "John A" <john@...2578...>
Date: Wed, 16 Sep 2020 12:49:38 -0400
Message-ID: <015201d68c49$5e85b310$1b911930$@aronetics.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0153_01D68C27.D775E7D0"
Content-Language: en-us
Subject: [Openvpn-devel] LD Errors / vpn_connect or vpn_init
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.

------=_NextPart_000_0153_01D68C27.D775E7D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey y'all,

I am new to this list and have been on listservs/majordomos since the
mid-90s. I visit here today to ask and hopefully receive an answer.

I have errors of undefined references such as:

/tmp/ccDkPqm5.ltrans7.ltrans.o: In function `vpn_init()':
<artificial>:(.text+0x1051): undefined reference to
`openvpn::ClientAPI::OpenVPNClient::OpenVPNClient()'

Is there documentation somewhere that I can look over or an quick quip
answer here of what obvious thing or stuff I am missing?

This in on CentOS 7 machine, x86_64, what more could I provide? Is there a
slack group?

Best regards,
John

Aronetics.com
We Speak ITR
+1-216/307-5760



------=_NextPart_000_0153_01D68C27.D775E7D0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 16.0.10364.2=
0059">
<TITLE>LD Errors / vpn_connect or vpn_init</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Hey y&#8217;all,</=
FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">I am new to this l=
ist and have been on listservs/majordomos since the</FONT></SPAN><SPAN LANG=
=3D"en-us"> <FONT FACE=3D"Calibri">mid-90s</FONT></SPAN><SPAN LANG=3D"en-us=
"><FONT FACE=3D"Calibri">. I visit here today to ask and hopefully</FONT></=
SPAN><SPAN LANG=3D"en-us"> <FONT FACE=3D"Calibri">receive</FONT></SPAN><SPA=
N LANG=3D"en-us"> <FONT FACE=3D"Calibri">an answer.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">I have</FONT></SPA=
N><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri"> errors of undefined</FONT></=
SPAN><SPAN LANG=3D"en-us"> <FONT FACE=3D"Calibri">references such as:</FONT=
></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">/tmp/ccDkPqm5.ltra=
ns7.ltrans.o: In function `vpn_init()':</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">&lt;artificial&gt;=
:(.text+0x1051): undefined reference to `openvpn::ClientAPI::OpenVPNClient:=
:OpenVPNClient()'</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Is</FONT></SPAN><S=
PAN LANG=3D"en-us"> <FONT FACE=3D"Calibri">there documentation somewhere th=
at I can look over or an quick quip answer here of what obvious thing or st=
uff I am missing?</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">This in on CentOS =
7 machine, x86_64, what more could I provide? Is there a slack group?</FONT=
></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">Best regards,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">John</FONT></SPAN>=
</P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Aronetics.com</FON=
T></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">We Speak IT</FONT></SPAN><SPAN LANG=
=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><=
SPAN LANG=3D"en-us"><FONT SIZE=3D4 FACE=3D"Arial">&reg;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SP=
AN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">+1-216/307-5760</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>=

------=_NextPart_000_0153_01D68C27.D775E7D0--


