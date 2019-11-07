From: Simon Rozman <simon@...2293...>
Date: Thu, 7 Nov 2019 13:05:53 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10BDA46060@...2294...>
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
 <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
In-Reply-To: <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0000_01D59574.6EDD00A0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Lev Stipakov' <lstipakov@...277...>, 'Gert Doering' <gert@...1296...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>, 'Antonio Quartulli' <a@...2181...>

------=_NextPart_000_0000_01D59574.6EDD00A0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0001_01D59574.6EDD00A0"

------=_NextPart_001_0001_01D59574.6EDD00A0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

We could introduce a master.c file which would include:



#include "argv.c"

#include "auth_token.c"

#include "base64.c"

#include "block_dns.c"

#include "buffer.c"

.

.

.

#include "status.c"

#include "tls_crypt.c"

#include "tun.c"

#include "win32.c"



And then have Makefile.ac and MSVC project files compile the master.c only.



Best regards,

Simon





Besides this, we need to fix this whole MSVC mess - all other platforms
are just done with "add new source file to the Makefile.ac" and done
(including mingw builds), and then MSVC is broken again, and this will
happen again and again.


Is there no reasonable way to build these project files from Makefile.ac?



I see no reasonable way. Selva, Simon - opinions?



We could probably have a templatized project file and script which inserts 
source files to there

based on content of Makefile.ac, but I don't like it. I consider necessity of 
modifying VS project

a lesser evil.



(you open it and it just works)



-Lev


------=_NextPart_001_0001_01D59574.6EDD00A0
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
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
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
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3D"#0563C1" v=
link=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal><a name=3D"=
_MailEndCompose"><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"=
Calibri",sans-serif;color:#1F497D;mso-fareast-language:EN-US'>We could intr=
oduce a master.c file which would include:<o:p></o:p></span></a></p><p clas=
s=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Cal=
ibri",sans-serif;color:#1F497D;mso-fareast-language:EN-US'><o:p>&nbsp;</o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0=
pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-language:EN-U=
S'>#include &quot;argv.c&quot;<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif=
;color:#1F497D;mso-fareast-language:EN-US'>#include &quot;auth_token.c&quot=
;<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'fon=
t-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-la=
nguage:EN-US'>#include &quot;base64.c&quot;<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Cali=
bri",sans-serif;color:#1F497D;mso-fareast-language:EN-US'>#include &quot;bl=
ock_dns.c&quot;<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;=
mso-fareast-language:EN-US'>#include &quot;buffer.c&quot;<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-=
family:"Calibri",sans-serif;color:#1F497D;mso-fareast-language:EN-US'>.<o:p=
></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-siz=
e:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-languag=
e:EN-US'>.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB sty=
le=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-f=
areast-language:EN-US'>.<o:p></o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color=
:#1F497D;mso-fareast-language:EN-US'>#include &quot;status.c&quot;<o:p></o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.=
0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-language:EN-=
US'>#include &quot;tls_crypt.c&quot;<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri",sans=
-serif;color:#1F497D;mso-fareast-language:EN-US'>#include &quot;tun.c&quot;=
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font=
-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-lan=
guage:EN-US'>#include &quot;win32.c&quot;<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri"=
,sans-serif;color:#1F497D;mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;fo=
nt-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-language:EN-US'>An=
d then have Makefile.ac and MSVC project files compile the master.c only.<o=
:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-s=
ize:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-fareast-langu=
age:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN=
-GB style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497=
D'>Best regards,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
GB style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D=
'>Simon<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=
=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:#1F497D;mso-far=
east-language:EN-US'><o:p>&nbsp;</o:p></span></p><div><div><div><p class=3D=
MsoNormal><span lang=3DEN-GB>&nbsp;<o:p></o:p></span></p></div><blockquote =
style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.=
0pt;margin-left:4.8pt;margin-right:0cm'><p class=3DMsoNormal><span lang=3DE=
N-GB>Besides this, we need to fix this whole MSVC mess - all other platform=
s<br>are just done with &quot;add new source file to the Makefile.ac&quot; =
and done<br>(including mingw builds), and then MSVC is broken again, and th=
is will<br>happen again and again.&nbsp; &nbsp;<o:p></o:p></span></p></bloc=
kquote><blockquote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;pad=
ding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm'><p class=3DMsoNo=
rmal><span lang=3DEN-GB><br>Is there no reasonable way to build these proje=
ct files from Makefile.ac?<o:p></o:p></span></p></blockquote><div><p class=
=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p></div><div><p c=
lass=3DMsoNormal><span lang=3DEN-GB>I see no reasonable way. Selva, Simon -=
 opinions?<o:p></o:p></span></p></div><div><p class=3DMsoNormal><span lang=
=3DEN-GB><o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span =
lang=3DEN-GB>We could probably have a templatized project file and script w=
hich inserts source files to there<o:p></o:p></span></p></div><div><p class=
=3DMsoNormal><span lang=3DEN-GB>based on content of Makefile.ac, but I don'=
t like it. I consider necessity of modifying VS project<o:p></o:p></span></=
p></div><div><p class=3DMsoNormal><span lang=3DEN-GB>a lesser evil.&nbsp;<o=
:p></o:p></span></p></div><div><p class=3DMsoNormal><span lang=3DEN-GB><o:p=
>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span lang=3DEN-GB>=
(you open it and it just works)<o:p></o:p></span></p></div><div><p class=3D=
MsoNormal><span lang=3DEN-GB>&nbsp;<o:p></o:p></span></p></div></div><div><=
p class=3DMsoNormal><span lang=3DEN-GB>-Lev<o:p></o:p></span></p></div></di=
v></div></body></html>=

------=_NextPart_001_0001_01D59574.6EDD00A0--

------=_NextPart_000_0000_01D59574.6EDD00A0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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

------=_NextPart_000_0000_01D59574.6EDD00A0--

