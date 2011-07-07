From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 7 Jul 2011 09:09:25 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901269D8E721@...1436...>
References: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>
	<4E14B584.9040905@...515...>
In-Reply-To: <4E14B584.9040905@...515...>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1CED409804E2164C8104F9E623B08B901269D8E721FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PolarSSL patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_1CED409804E2164C8104F9E623B08B901269D8E721FOXDFT02FOXlo_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Samuli,

Since plugins have support for X.509 certificates, they need to enable eith=
er USE_OPENSSL or USE_POLARSSL, and include the appropriate X.509 backend (=
ssl_verify_*.h). Since neither was defined, the file was not included and t=
herefore the build failed.

This is part of a larger problem, where if USE_SSL is not defined a depende=
ncy to OpenSSL's x509 header still exists for plugins. I've fixed this in a=
 patch that I'll upload and mail soon.

Adriaan

From: Samuli Sepp=E4nen [mailto:samuli@...515...]
Sent: woensdag 6 juli 2011 21:21
To: Adriaan de Jong
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] PolarSSL patches

Hi Adriaan,

I tried building your tree on Debian 5 (amd64) VM and got this error:

#make plugins
/usr/bin/make -C plugin/auth-pam/
make[1]: Entering directory `/home/buildslave/andj-openvpn-ssl-refactoring-=
4970f14/plugin/auth-pam'
gcc -O2 -Wall -DDLOPEN_PAM=3D0 -fPIC -c -I../.. auth-pam.c
In file included from auth-pam.c:49:
../../openvpn-plugin.h:283: error: expected specifier-qualifier-list before=
 'x509_cert_t'
make[1]: *** [auth-pam.o] Error 1
make[1]: Leaving directory `/home/buildslave/andj-openvpn-ssl-refactoring-4=
970f14/plugin/auth-pam'
make: *** [build-stamp] Error 2

The same VM has been used to successfully build the official release packag=
es.

Samuli



Hi everyone,

During last week's meeting we decided to temporarily create a github tree f=
or OpenVPN. It can be found at https://github.com/andj/openvpn-ssl-refactor=
ing . The version found there is now ready for testing, and will (hopefully=
) be included in the 2.3 alpha versions.

Could interested parties please have a look and provide me with feedback (t=
hrough IRC/e-mail?).

Thanks!

Adriaan de Jong

PS. Note that due to limitations in PolarSSL, it is still missing a number =
of features:

 * PKCS#12 file support
 * --capath support - Loading certificate authorities from a directory
 * Windows CryptoAPI support
 * Management external key support
 * X.509 alternative username fields (must be "CN")

Plugin/Script features:

 * X.509 Serial number is in hex, not decimal as with OpenSSL
 * X.509 subject line has a different format than the OpenSSL subject line
 * X.509 certificate export does not work
 * X.509 certificate tracking

Fox-IT    ...for a more secure society
I www.fox-it.com<http://www.fox-it.com/>





--_000_1CED409804E2164C8104F9E623B08B901269D8E721FOXDFT02FOXlo_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Micr=
osoft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
</o:shapelayout></xml><![endif]--></head><body bgcolor=3Dwhite lang=3DNL li=
nk=3Dblue vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><sp=
an style=3D'color:#1F497D'>Hi Samuli,<o:p></o:p></span></p><p class=3DMsoNo=
rmal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-GB style=3D'color:#1F497D'>Since plugins have supp=
ort for X.509 certificates, they need to enable either USE_OPENSSL or USE_P=
OLARSSL, and include the appropriate X.509 backend (ssl_verify_*.h). Since =
neither was defined, the file was not included and therefore the build fail=
ed.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'c=
olor:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'color:#1F497D'>This is part of a larger problem, where if=
 USE_SSL is not defined a dependency to OpenSSL&#8217;s x509 header still e=
xists for plugins. I&#8217;ve fixed this in a patch that I&#8217;ll upload =
and mail soon. <o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-GB style=3D'color:#1F497D'>Adriaan<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-GB style=3D'color:#1F497D'><o:p>&nbsp;</o=
:p></span></p><div style=3D'border:none;border-left:solid blue 1.5pt;paddin=
g:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;border-top:solid #B5C4D=
F 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span lang=3DEN-=
US style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:window=
text'>From:</span></b><span lang=3DEN-US style=3D'font-size:10.0pt;font-fam=
ily:"Tahoma","sans-serif";color:windowtext'> Samuli Sepp=E4nen [mailto:samu=
li@...515...] <br><b>Sent:</b> woensdag 6 juli 2011 21:21<br><b>To:</b> Adr=
iaan de Jong<br><b>Cc:</b> openvpn-devel@lists.sourceforge.net<br><b>Subjec=
t:</b> Re: [Openvpn-devel] PolarSSL patches<o:p></o:p></span></p></div></di=
v><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Hi Adriaan=
,<br><br>I tried building your tree on Debian 5 (amd64) VM and got this err=
or:<br><br>#make plugins<br>/usr/bin/make -C plugin/auth-pam/<br>make[1]: E=
ntering directory `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/pl=
ugin/auth-pam'<br>gcc -O2 -Wall -DDLOPEN_PAM=3D0 -fPIC -c -I../.. auth-pam.=
c<br>In file included from auth-pam.c:49:<br>../../openvpn-plugin.h:283: er=
ror: expected specifier-qualifier-list before &#8216;x509_cert_t&#8217;<br>=
make[1]: *** [auth-pam.o] Error 1<br>make[1]: Leaving directory `/home/buil=
dslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'<br>make: *** [=
build-stamp] Error 2<br><br>The same VM has been used to successfully build=
 the official release packages.<br><br>Samuli<br><br><br><br><o:p></o:p></p=
><p class=3DMsoNormal>Hi everyone,<o:p></o:p></p><p class=3DMsoNormal>&nbsp=
;<o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>During last week&#8=
217;s meeting we decided to temporarily create a github tree for OpenVPN. I=
t can be found at <a href=3D"https://github.com/andj/openvpn-ssl-refactorin=
g">https://github.com/andj/openvpn-ssl-refactoring</a> . The version found =
there is now ready for testing, and will (hopefully) be included in the 2.3=
 alpha versions.</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-=
GB>&nbsp;</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>Coul=
d interested parties please have a look and provide me with feedback (throu=
gh IRC/e-mail?). </span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN=
-GB>&nbsp;</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>Tha=
nks!</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>&nbsp;</s=
pan><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>Adriaan de Jong<=
/span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>&nbsp;</span><=
o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>PS. Note that due to =
limitations in PolarSSL, it is still missing a number of features:</span><o=
:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.=
0pt'>&nbsp;</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB st=
yle=3D'font-size:10.0pt'>&nbsp;* PKCS#12 file support</span><o:p></o:p></p>=
<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* =
--capath support - Loading certificate authorities from a directory</span><=
o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10=
.0pt'>&nbsp;* Windows CryptoAPI support</span><o:p></o:p></p><p class=3DMso=
Normal><span lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* Management ext=
ernal key support</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN=
-GB style=3D'font-size:10.0pt'>&nbsp;* X.509 alternative username fields (m=
ust be &quot;CN&quot;)</span><o:p></o:p></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;</span><o:p></o:p></p><p class=3D=
MsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'>Plugin/Script featu=
res:</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'=
font-size:10.0pt'>&nbsp;</span><o:p></o:p></p><p class=3DMsoNormal><span la=
ng=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* X.509 Serial number is in hex=
, not decimal as with OpenSSL</span><o:p></o:p></p><p class=3DMsoNormal><sp=
an lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* X.509 subject line has a=
 different format than the OpenSSL subject line</span><o:p></o:p></p><p cla=
ss=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* X.509 =
certificate export does not work</span><o:p></o:p></p><p class=3DMsoNormal>=
<span lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* X.509 certificate tra=
cking</span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>&nbsp;</=
span><o:p></o:p></p><p class=3DMsoNormal><b><span lang=3DEN-US style=3D'fon=
t-size:9.0pt;font-family:"Verdana","sans-serif";color:navy'>Fox-IT</span></=
b><span lang=3DEN-US style=3D'font-size:9.0pt;font-family:"Verdana","sans-s=
erif";color:navy'>&nbsp;&nbsp;&nbsp;&nbsp;<i>...for a more secure society</=
i> </span><o:p></o:p></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'f=
ont-size:8.0pt;font-family:"Verdana","sans-serif"'>I <a href=3D"http://www.=
fox-it.com/">www.fox-it.com</a><br><br><br></span><o:p></o:p></p><p class=
=3DMsoNormal><span lang=3DEN-GB>&nbsp;</span><o:p></o:p></p><p class=3DMsoN=
ormal><span style=3D'font-size:12.0pt;font-family:"Times New Roman","serif"=
'><o:p>&nbsp;</o:p></span></p></div></div></body></html>=

--_000_1CED409804E2164C8104F9E623B08B901269D8E721FOXDFT02FOXlo_--

