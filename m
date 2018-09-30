From: Simon Rozman <simon@...2293...>
Date: Sun, 30 Sep 2018 08:46:12 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10991F54B2@...2294...>
References: <1538141209-32330-1-git-send-email-lstipakov@...277...>
 <99D61A626FDA8A4B90A270669121BE10991F46BA@...2294...>
 <CAGyAFMXddqfZAHu-_aaue49zu_TCaFz4yMBpo6kV9XbZBPqgoQ@...278...>
In-Reply-To: <CAGyAFMXddqfZAHu-_aaue49zu_TCaFz4yMBpo6kV9XbZBPqgoQ@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0006_01D458AA.CDCD5EA0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] win: support for Visual Studio 2017
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0006_01D458AA.CDCD5EA0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0007_01D458AA.CDCD5EA0"

------=_NextPart_001_0007_01D458AA.CDCD5EA0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Acked-by: Simon Rozman <simon@...2293...>



From: Lev Stipakov <lstipakov@...277...>
Sent: Sunday, September 30, 2018 7:19 AM
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] win: support for Visual Studio 2017



Hi,


I was very delighted to see this contribution. However, after hours of
struggling to compile and prepare pre-requisites, I gave up my attempts to
test this patch. The openvpn-build/msvc/build.bat was indeed helpful, though a
bit outdated to be directly usable.



Sorry, I probably have to state it more clear in email - I have prepared patch 
to openvpn-build as well,

see https://github.com/OpenVPN/openvpn-build/pull/137 The new version should 
be usable out of the box.



I don't think you need autoconf or anything besides VS2017 and ActiveState 
Perl. Certainly you

are not supposed to copy or edit files manually. Here is build log from 
AppVeyor:



https://ci.appveyor.com/project/lstipakov/openvpn-build/build/openvpn-build-19/job/kl2ky4ncbhiqw8gg?fullLog=true



Now, I have begun to question the rationale of this patch... If it is too hard
to setup building environment for me (Visual Studio is my daily working
environment from 1998),



We should sort it out. To build with VS you are only supposed to



1) clone openvpn-build

2) run msvc/build.bat

3) (optionally) open msvc/build.tmp/openvpn-master/openvpn.sln with Visual 
Studio IDE and enjoy coding



Would have been nice to add Windows 10 ARM64 support, but remembered somebody
needs to compile pre-requisites for ARM64 nightmare...



Can TAP driver be compiled for ARM64?



BTW, I have a patch in my forked repo re-establishing Visual Studio 2017
support for compiling openvpnserv.exe. I needed it to debug while developing
support for multi-instances



With this and openvpn-build patch I was able to debug (run and attach to 
process) both openvpn and openvpnserv.exe



Best regards,
Simon



-- 

-Lev


------=_NextPart_001_0007_01D458AA.CDCD5EA0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:Consolas;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'mso=
-fareast-language:EN-US'>Acked-by: Simon Rozman &lt;simon@...2293...&gt;<o:=
p></o:p></span></p><p class=3DMsoNormal><span style=3D'mso-fareast-language=
:EN-US'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-left:s=
olid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;b=
order-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNorm=
al><b><span lang=3DEN-US>From:</span></b><span lang=3DEN-US> Lev Stipakov &=
lt;lstipakov@...277...&gt; <br><b>Sent:</b> Sunday, September 30, 2018 7:19=
 AM<br><b>To:</b> Simon Rozman &lt;simon@...2293...&gt;<br><b>Cc:</b> openv=
pn-devel@lists.sourceforge.net<br><b>Subject:</b> Re: [Openvpn-devel] [PATC=
H] win: support for Visual Studio 2017<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div><div><div><p class=3DMsoNo=
rmal>Hi,<o:p></o:p></p><div><blockquote style=3D'border:none;border-left:so=
lid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:=
0cm'><p class=3DMsoNormal><br>I was very delighted to see this contribution=
. However, after hours of <br>struggling to compile and prepare pre-requisi=
tes, I gave up my attempts to <br>test this patch. The openvpn-build/msvc/b=
uild.bat was indeed helpful, though a <br>bit outdated to be directly usabl=
e.&nbsp;<o:p></o:p></p></blockquote><div><p class=3DMsoNormal><o:p>&nbsp;</=
o:p></p></div><div><p class=3DMsoNormal>Sorry, I probably have to state it =
more clear in email - I have prepared patch to openvpn-build as well,<o:p><=
/o:p></p></div><div><p class=3DMsoNormal>see&nbsp;<a href=3D"https://github=
.com/OpenVPN/openvpn-build/pull/137">https://github.com/OpenVPN/openvpn-bui=
ld/pull/137</a> The new version should be usable out of the box.<o:p></o:p>=
</p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p clas=
s=3DMsoNormal>I don't think you need autoconf or anything besides VS2017 an=
d ActiveState Perl. Certainly you&nbsp;<o:p></o:p></p></div><div><p class=
=3DMsoNormal>are not supposed to copy or edit files manually. Here is build=
 log from AppVeyor:<o:p></o:p></p></div><div><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p></div><div><p class=3DMsoNormal><a href=3D"https://ci.appveyor.=
com/project/lstipakov/openvpn-build/build/openvpn-build-19/job/kl2ky4ncbhiq=
w8gg?fullLog=3Dtrue">https://ci.appveyor.com/project/lstipakov/openvpn-buil=
d/build/openvpn-build-19/job/kl2ky4ncbhiqw8gg?fullLog=3Dtrue</a><o:p></o:p>=
</p></div><div><p class=3DMsoNormal>&nbsp;<o:p></o:p></p></div><blockquote =
style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.=
0pt;margin-left:4.8pt;margin-right:0cm'><p class=3DMsoNormal>Now, I have be=
gun to question the rationale of this patch... If it is too hard <br>to set=
up building environment for me (Visual Studio is my daily working <br>envir=
onment from 1998), <o:p></o:p></p></blockquote><div><p class=3DMsoNormal><o=
:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>We should sort it out. T=
o build with VS you are only supposed to&nbsp;&nbsp;<o:p></o:p></p></div><d=
iv><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNorma=
l>1) clone openvpn-build<o:p></o:p></p></div><div><p class=3DMsoNormal>2) r=
un msvc/build.bat<o:p></o:p></p></div><div><p class=3DMsoNormal>3) (optiona=
lly) open msvc/build.tmp/openvpn-master/openvpn.sln with Visual Studio IDE =
and enjoy coding<o:p></o:p></p></div><div><p class=3DMsoNormal><o:p>&nbsp;<=
/o:p></p></div><blockquote style=3D'border:none;border-left:solid #CCCCCC 1=
.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm'><p class=
=3DMsoNormal>Would have been nice to add Windows 10 ARM64 support, but reme=
mbered somebody <br>needs to compile pre-requisites for ARM64 nightmare...<=
o:p></o:p></p></blockquote><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><=
/div><div><p class=3DMsoNormal>Can TAP driver be compiled for ARM64?<o:p></=
o:p></p></div><div><p class=3DMsoNormal>&nbsp;<o:p></o:p></p></div><blockqu=
ote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0c=
m 6.0pt;margin-left:4.8pt;margin-right:0cm'><p class=3DMsoNormal>BTW, I hav=
e a patch in my forked repo re-establishing Visual Studio 2017 <br>support =
for compiling openvpnserv.exe. I needed it to debug while developing <br>su=
pport for multi-instances<o:p></o:p></p></blockquote><div><p class=3DMsoNor=
mal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>With this and open=
vpn-build patch I was able to debug (run and attach to process) both openvp=
n and openvpnserv.exe<o:p></o:p></p></div><div><p class=3DMsoNormal>&nbsp;<=
o:p></o:p></p></div><blockquote style=3D'border:none;border-left:solid #CCC=
CCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm'><p =
class=3DMsoNormal>Best regards,<br>Simon<o:p></o:p></p></blockquote></div><=
div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><p class=3DMsoNormal>--=
 <o:p></o:p></p><div><p class=3DMsoNormal>-Lev<o:p></o:p></p></div></div></=
div></div></div></div></div></body></html>=

------=_NextPart_001_0007_01D458AA.CDCD5EA0--

------=_NextPart_000_0006_01D458AA.CDCD5EA0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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

------=_NextPart_000_0006_01D458AA.CDCD5EA0--

