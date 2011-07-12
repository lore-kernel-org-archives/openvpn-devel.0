From: Russell Morris <openvpn@...1315...>
Date: Tue, 12 Jul 2011 18:03:11 -0500
Message-id: <1310511791899675500@...1315...>
In-reply-to: <1310306284971654500@...1315...>
References: <1310306284971654500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=0946944461217943796497304460819711460222=axigen==="
Subject: Re: [Openvpn-devel] [Openvpn-users]  Sporadic Long Ping Times
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel <ktdann@...277...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=0946944461217943796497304460819711460222=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Let me try this again - as the pictures didn't seem to come through, and I =
resubmitted with a PDF file but it was too large ... :-(. Here are links to=
 the pictures (thanks Samuli for your help!)

=20

1) No OpenVPN - just a direct link

<http://build.openvpn.net/image007.jpg>

=20

2) OpenVPN, keepalive =3D 10 120

<http://build.openvpn.net/image008.jpg>

=20

3) OpenVPN, keepalive =3D 20 120

<http://build.openvpn.net/image009.jpg>

=20

Thoughts?

=20

Thanks,

... Russell



On Sun, 07/10/2011 08:58 AM, Russell Morris <openvpn@...1315...> wrote:


>=20



>=20





 *=20
 *=20
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}


 *=20
 *=20



Hi,

=20

My apologies in advance for the large pictures below - but I wanted to capt=
ure some data to help demonstrate this issue (and so we can perhaps determi=
ne what is causing it).

=20

Some ping (RTT) data, between the same two machines (endpoints) - with and =
without OpenVPN running. In the OpenVPN case I edited the routing table to =
force the traffic over the OpenVPN link (same physical link, and no interme=
diate machines ... just the two endpoints). In all cases the sample interva=
l is 500 ms. Here's the data ...

=20

1) No OpenVPN - just a direct link.

=20=20

=20

2) OpenVPN, keepalive =3D 10 120

=20=20

=20

3) OpenVPN, keepalive =3D 20120




>=20=20

So it doesn't look like keepalive is the culprit (or at least not all of it=
). Any thoughts?

=20

Thanks!

=20

... Russell

=20


> On Fri, 07/08/2011 10:39 PM, Daniel <ktdann@...277...> wrote:

>=20

Not sure if this would be the cause, but if openvpn ping is the
> culprit, what would be the correct measure to take?
> Increase the openvpn ping interval?
> Change MTU?
> Or its a bug and something should be done from the openvpn point of view?
>=20
> Dan.
>=20
> On 9 July 2011 10:42, Jan Just Keijser <janjust@...1147...> wrote:
> > Russell Morris wrote:
> >> Hi,
> >>
> >> I have been measuring data throughput and RTT on my OpenVPN link (clie=
nt to server), and while data throughput has been quite consistent (in the =
25-30 Mb/s range), RTT (ping) has shown a strange artifact.
> >>
> >> If I run ping continuously (1 second interval), I may see 10 or 20 ver=
y consisten runs, at ~ 10 ms ... but then a single point at 200-250 ms. If =
I let it keep running this keeps happening - not with a consistent pattern,=
 but about this rate.
> >>
> >> Has anyone else seen a similar artifact?
> >>
> >
> > ping RTT times over a VPN link can vary quite a bit, as I've noticed,
> > esp after a lack of activity for some time. If the spikes happen every
> > 10 to 20 seconds , however, then I suspect the openvpn pings are getting
> > in the way - try changing the 'ping' (or 'keepalive') options to
> >  ping 20
> > or
> >  keepalive 20 120
> > if the spikes now occur very 20 to 40 seconds then you've found the cul=
prit.
> >
> > HTH,
> >
> > JJK
> >
> >
> > -----------------------------------------------------------------------=
-------
> > All of the data generated in your IT infrastructure is seriously valuab=
le.
> > Why? It contains a definitive record of application performance, securi=
ty
> > threats, fraudulent activity, and more. Splunk takes this data and makes
> > sense of it. IT sense. And common sense.
> > http://p.sf.net/sfu/splunk-d2d-c2
> > _______________________________________________
> > Openvpn-users mailing list
> > Openvpn-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-users
> >
>=20
>=20
>=20
> --
> Daniel
---------------------------------------------------------------------------=
---
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security=20
threats, fraudulent activity, and more. Splunk takes this data and makes=20
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2 _________________________________________=
______
Openvpn-users mailing list
Openvpn-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-users

--===axigen=0946944461217943796497304460819711460222=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Let me try this again - as the pictures didn't seem to come throu=
gh, and I resubmitted with a PDF file but it was too large ... :-(. Here ar=
e links to the pictures (thanks Samuli for your help!)</P>
<P>&nbsp;</P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">1) No=
 OpenVPN - just a direct link</SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><SPAN=
 style=3D"FONT-FAMILY: 'Times New Roman','serif'; COLOR: black; FONT-SIZE: =
12pt; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US;=
 mso-fareast-language: EN-US; mso-bidi-language: AR-SA"><A href=3D"http://b=
uild.openvpn.net/image007.jpg">&lt;http://build.openvpn.net/image007.jpg&gt=
;</A></SPAN></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><SPAN=
 style=3D"FONT-FAMILY: 'Times New Roman','serif'; COLOR: black; FONT-SIZE: =
12pt; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US;=
 mso-fareast-language: EN-US; mso-bidi-language: AR-SA"></SPAN></SPAN>&nbsp=
;</P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><?xml=
:namespace prefix =3D o /><o:p><SPAN style=3D"FONT-FAMILY: 'Arial','sans-se=
rif'; FONT-SIZE: 10pt">2) OpenVPN, <SPAN class=3DSpellE>keepalive</SPAN> =
=3D 10 120</SPAN></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
<SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><SPAN st=
yle=3D"FONT-FAMILY: 'Times New Roman','serif'; COLOR: black; FONT-SIZE: 12p=
t; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; ms=
o-fareast-language: EN-US; mso-bidi-language: AR-SA"><A href=3D"http://buil=
d.openvpn.net/image008.jpg">&lt;http://build.openvpn.net/image008.jpg&gt;</=
A></SPAN></SPAN></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
<SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><SPAN st=
yle=3D"FONT-FAMILY: 'Times New Roman','serif'; COLOR: black; FONT-SIZE: 12p=
t; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; ms=
o-fareast-language: EN-US; mso-bidi-language: AR-SA"></SPAN></SPAN></o:p></=
SPAN>&nbsp;</P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
<SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p><SP=
AN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">3) OpenVPN,=
 <SPAN class=3DSpellE>keepalive</SPAN> =3D 20 120</SPAN></o:p></SPAN></o:p>=
</SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
<SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p><SP=
AN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p><SPAN =
style=3D"FONT-FAMILY: 'Times New Roman','serif'; COLOR: black; FONT-SIZE: 1=
2pt; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; =
mso-fareast-language: EN-US; mso-bidi-language: AR-SA"><A href=3D"http://bu=
ild.openvpn.net/image009.jpg">&lt;http://build.openvpn.net/image009.jpg&gt;=
</A></SPAN></o:p></SPAN></o:p></SPAN></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
<SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p><SP=
AN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p><SPAN =
style=3D"FONT-FAMILY: 'Times New Roman','serif'; COLOR: black; FONT-SIZE: 1=
2pt; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; =
mso-fareast-language: EN-US; mso-bidi-language: AR-SA"></SPAN></o:p></SPAN>=
</o:p></SPAN></o:p></SPAN>&nbsp;</P>
<P>Thoughts?</P>
<P>&nbsp;</P>
<P>Thanks,</P>
<P>... Russell</P>
<P><BR><BR>On Sun, 07/10/2011 08:58 AM, Russell&nbsp;Morris&nbsp;&lt;openvp=
n@...1315...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">
<STYLE id=3Daxi-htmleditor-style type=3Dtext/css>p { margin: 0px; }</STYLE>
<BR>
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">
<META content=3D"text/html; charset=3Dus-ascii" equiv=3D"Content-Type" http=
=3D"HTTP">
<META name=3DProgId content=3DWord.Document>
<META name=3DGenerator content=3D"Microsoft Word 12">
<META name=3DOriginator content=3D"Microsoft Word 12"><LINK rel=3DFile-List=
><LINK rel=3DEdit-Time-Data>
<STYLE>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</STYLE>
<LINK rel=3DthemeData href=3D"~~themedata~~"><LINK rel=3DcolorSchemeMapping=
 href=3D"~~colorschememapping~~">
<STYLE><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Arial Rounded MT Bold";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520081665 -1073717157 41 0 66047 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}
p
	{mso-style-noshow:yes;
	mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:"Arial","sans-serif";
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:"Balloon Text";
	mso-ansi-font-size:8.0pt;
	mso-bidi-font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-ascii-font-family:Tahoma;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></STYLE>

<DIV class=3DWordSection1>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Hi,<o=
:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">My ap=
ologies in advance for the large pictures below - but I wanted to capture s=
ome data to help demonstrate this issue (and so we can perhaps determine wh=
at is causing it).<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Some =
ping (RTT) data, between the same two machines (endpoints) - with and witho=
ut OpenVPN running. In the OpenVPN case I edited the routing table to force=
 the traffic over the OpenVPN link (same physical link, and no intermediate=
 machines ... just the two endpoints). In all cases the sample interval is =
500 <SPAN class=3DSpellE>ms.</SPAN> Here's the data ...<o:p></o:p></SPAN></=
P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">1) No=
 OpenVPN - just a direct link.<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<SPAN style=3D"mso-no-proof: yes"><?xml:namespace prefix =3D v /><v:shapet=
ype id=3D_x0000_t75 o=3D"o" spt=3D"75" preferrelative=3D"t" coordsize =3D "=
21600,21600" filled =3D "f" stroked =3D "f" path =3D " m@...1477...@5 l@...493...=
1477...@...1480...@...1478...@...1480...@...1478...@...1481... xe"> <v:stroke joinstyle =3D "miter">=
</v:stroke><v:formulas><v:f eqn =3D "if lineDrawn pixelLineWidth 0 "></v:f>=
<v:f eqn =3D "sum @0 1 0 "></v:f><v:f eqn =3D "sum 0 0 @1 "></v:f><v:f eqn =
=3D "prod @2 1 2 "></v:f><v:f eqn =3D "prod @3 21600 pixelWidth "></v:f><v:=
f eqn =3D "prod @3 21600 pixelHeight "></v:f><v:f eqn =3D "sum @0 0 1 "></v=
:f><v:f eqn =3D "prod @6 1 2 "></v:f><v:f eqn =3D "prod @7 21600 pixelWidth=
 "></v:f><v:f eqn =3D "sum @8 21600 0 "></v:f><v:f eqn =3D "prod @7 21600 p=
ixelHeight "></v:f><v:f eqn =3D "sum @10 21600 0 "></v:f></v:formulas><v:pa=
th o=3D"o" connecttype=3D"rect" extrusionok=3D"f" gradientshapeok =3D "t"><=
/v:path><o:lock v=3D"v" ext=3D"edit" aspectratio=3D"t"></o:lock></v:shapety=
pe><v:shape style=3D"WIDTH: 468pt; HEIGHT: 434.25pt; VISIBILITY: visible; m=
so-wrap-style: square" id=3DPicture_x0020_1 o=3D"o" spid=3D"_x0000_i1027" t=
ype =3D "#_x0000_t75" coordsize =3D "21600,21600"><v:imagedata title=3D"" o=
=3D"o"></v:imagedata></v:shape></SPAN><o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
&nbsp;</o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">2) Op=
enVPN, <SPAN class=3DSpellE>keepalive</SPAN> =3D 10 120<o:p></o:p></SPAN></=
P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<SPAN style=3D"mso-no-proof: yes"><v:shape style=3D"WIDTH: 468pt; HEIGHT: =
434.25pt; VISIBILITY: visible; mso-wrap-style: square" id=3DPicture_x0020_2=
 o=3D"o" spid=3D"_x0000_i1026" type =3D "#_x0000_t75" coordsize =3D "21600,=
21600"> <v:imagedata title=3D"" o=3D"o"></v:imagedata></v:shape></SPAN><o:p=
></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p>=
&nbsp;</o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">3) Op=
enVPN, <SPAN class=3DSpellE>keepalive</SPAN> =3D 20120<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt; mso-n=
o-proof: yes"><v:shape style=3D"WIDTH: 468pt; HEIGHT: 434.25pt; VISIBILITY:=
 visible; mso-wrap-style: square" id=3DPicture_x0020_3 o=3D"o" spid=3D"_x00=
00_i1025" type =3D "#_x0000_t75" coordsize =3D "21600,21600"><v:imagedata t=
itle=3D"" o=3D"o"></v:imagedata></v:shape></SPAN><SPAN style=3D"FONT-FAMILY=
: 'Arial','sans-serif'; FONT-SIZE: 10pt"><o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><BR>&=
nbsp;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">So it=
 doesn't look like <SPAN class=3DSpellE>keepalive</SPAN> is the culprit (or=
 at least not all of it). Any thoughts?<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Thank=
s!<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">... R=
ussell<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">&nbsp=
;<o:p></o:p></SPAN></P>
<P><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"><BR>O=
n Fri, 07/08/2011 10:39 PM, Daniel&nbsp;&lt;<A href=3D"mailto:ktdann@...1482...=
...">ktdann@...277...</A>&gt; wrote:<o:p></o:p></SPAN></P>
<BLOCKQUOTE style=3D"BORDER-BOTTOM: medium none; BORDER-LEFT: #0000cc 1.5pt=
 solid; PADDING-BOTTOM: 0in; MARGIN-TOP: 5pt; PADDING-LEFT: 3pt; PADDING-RI=
GHT: 0in; MARGIN-BOTTOM: 5pt; MARGIN-LEFT: 12pt; BORDER-TOP: medium none; B=
ORDER-RIGHT: medium none; PADDING-TOP: 0in">
<DIV>
<P class=3DMsoNormal><SPAN style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT=
-SIZE: 10pt; mso-fareast-font-family: 'Times New Roman'">Not sure if this w=
ould be the cause, but if <SPAN class=3DSpellE>openvpn</SPAN> ping is the<B=
R>culprit, what would be the correct measure to take?<BR>Increase the <SPAN=
 class=3DSpellE>openvpn</SPAN> ping interval?<BR>Change MTU?<BR>Or <SPAN cl=
ass=3DSpellE>its</SPAN> a bug and something should be done from the <SPAN c=
lass=3DSpellE>openvpn</SPAN> point of view?<BR><BR>Dan.<BR><BR>On 9 July 20=
11 10:42, Jan Just <SPAN class=3DSpellE>Keijser</SPAN> &lt;<A href=3D"mailt=
o:janjust@...1147...">janjust@...1147...</A>&gt; wrote:<BR>&gt; Russell Mor=
ris wrote:<BR>&gt;&gt; Hi,<BR>&gt;&gt;<BR>&gt;&gt; I have been measuring da=
ta throughput and RTT on my OpenVPN link (client to server), and while data=
 throughput has been quite consistent (in the 25-30 Mb/s range), RTT (ping)=
 has shown a strange artifact.<BR>&gt;&gt;<BR>&gt;&gt; If I run ping contin=
uously (1 second interval), I may see 10 or 20 very <SPAN class=3DSpellE>co=
nsisten</SPAN> runs, at ~ 10 ms ... but then a single point at 200-250 <SPA=
N class=3DSpellE>ms.</SPAN> If I let it keep running this keeps happening -=
 not with a consistent pattern, but about this rate.<BR>&gt;&gt;<BR>&gt;&gt=
; Has anyone else seen a similar artifact?<BR>&gt;&gt;<BR>&gt;<BR>&gt; ping=
 RTT times over a VPN link can vary quite a bit, as I've noticed,<BR>&gt; <=
SPAN class=3DSpellE>esp</SPAN> after a lack of activity for some time. If t=
he spikes happen every<BR>&gt; 10 to 20 seconds , however, then I suspect t=
he <SPAN class=3DSpellE>openvpn</SPAN> pings are getting<BR>&gt; in the way=
 - try changing the 'ping' (or '<SPAN class=3DSpellE>keepalive</SPAN>') opt=
ions to<BR>&gt; &nbsp;ping 20<BR>&gt; or<BR>&gt; &nbsp;<SPAN class=3DSpellE=
>keepalive</SPAN> 20 120<BR>&gt; if the spikes now occur <SPAN class=3DSpel=
lE>very</SPAN> 20 to 40 seconds then you've found the culprit.<BR>&gt;<BR>&=
gt; HTH,<BR>&gt;<BR>&gt; JJK<BR>&gt;<BR>&gt;<BR>&gt; ----------------------=
--------------------------------------------------------<BR>&gt; All of the=
 data generated in your IT infrastructure is seriously valuable.<BR>&gt; Wh=
y? It contains a definitive record of application performance, security<BR>=
&gt; threats, fraudulent activity, and more. <SPAN class=3DSpellE>Splunk</S=
PAN> takes this data and makes<BR>&gt; sense of it. IT sense. And common se=
nse.<BR>&gt; <A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%=
2Fserver.home%3A8080%2Fredir.hsp%3Furl%3Dhttp%3A%2F%2Fserver.home%3A8080%2F=
redir.hsp%3Furl%3D%68%74%74%70%3A%2F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%75=
%2F%73%70%6C%75%6E%6B%2D%64%32%64%2D%63%32" target=3D_blank>http://p.sf.net=
/sfu/splunk-d2d-c2</A><BR>&gt; ____________________________________________=
___<BR>&gt; <SPAN class=3DSpellE>Openvpn</SPAN>-users mailing list<BR>&gt;<=
A href=3D"mailto:%20Openvpn-users@lists.sourceforge.net"> Openvpn-users@...1484...=
ts.sourceforge.net</A><BR>&gt; <A href=3D"http://server.home:8080/redir.hsp=
?url=3Dhttp%3A%2F%2Fserver.home%3A8080%2Fredir.hsp%3Furl%3Dhttp%3A%2F%2Fser=
ver.home%3A8080%2Fredir.hsp%3Furl%3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73=
%2E%73%6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69=
%73%74%69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%75%73%65%72%73" target=3D_bla=
nk>https://lists.sourceforge.net/lists/listinfo/openvpn-users</A><BR>&gt;<B=
R><BR><BR><BR><SPAN style=3D"COLOR: #999999">--<BR>Daniel</SPAN><o:p></o:p>=
</SPAN></P></DIV></BLOCKQUOTE></DIV></DIV>---------------------------------=
---------------------------------------------<BR>All of the data generated =
in your IT infrastructure is seriously valuable.<BR>Why? It contains a defi=
nitive record of application performance, security <BR>threats, fraudulent =
activity, and more. Splunk takes this data and makes <BR>sense of it. IT se=
nse. And common sense.<BR><A href=3D"http://server.home:8080/redir.hsp?url=
=3D%68%74%74%70%3A%2F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%75%2F%73%70%6C%75=
%6E%6B%2D%64%32%64%2D%63%32" target=3D_blank>http://p.sf.net/sfu/splunk-d2d=
-c2</A> _______________________________________________<BR>Openvpn-users ma=
iling list<BR><A href=3D"mailto:Openvpn-users@lists.sourceforge.net" target=
=3D_blank>Openvpn-users@lists.sourceforge.net</A><BR><A href=3D"http://serv=
er.home:8080/redir.hsp?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%=
6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%=
69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%75%73%65%72%73" target=3D_blank>http=
s://lists.sourceforge.net/lists/listinfo/openvpn-users</A><BR></DIV></BLOCK=
QUOTE></body></html>=

--===axigen=0946944461217943796497304460819711460222=axigen===--


