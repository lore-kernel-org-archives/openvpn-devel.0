From: Simon Rozman <simon@...2293...>
Date: Sun, 17 Jun 2018 11:10:56 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE108965EE78@...2294...>
References: <99D61A626FDA8A4B90A270669121BE1089628FC9@...2294...>
 <DM5PR2101MB11127F120677A779CB43A8D4B07D0@...2412...>
 <431d0dae-f48c-a550-a2fc-5e9ec78206e7@...515...>
 <CAFHpkQF8aUA+nbcj-LY5VugUP5Oq8iBsnKWW25CxsgEW05hnpw@...278...>
 <CAFHpkQFCUZ-DW-YHU9b-GL9VbjxW3nmcscXo_eLsnoAAvprLiQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108965E856@...2294...>
 <CAFHpkQG51OrAq2zH6QqQk-M2RRqK123N6vLAx_dtw_Vkd61oHg@...278...>
In-Reply-To: <CAFHpkQG51OrAq2zH6QqQk-M2RRqK123N6vLAx_dtw_Vkd61oHg@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_000E_01D4063C.9FC68920"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] tap-windows6 and AppVeyor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: =?utf-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>, "jkunkee@...2393..." <jkunkee@...2393...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_000E_01D4063C.9FC68920
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_000F_01D4063C.9FC68920"

------=_NextPart_001_000F_01D4063C.9FC68920
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have created a commit at https://github.com/rozmansi/tap-windows6/commit/=
edefe4fbcaa51b756cc069d53c81c8d36de71d08 to throw on command errors. But I'=
m struggling with Git and GitHub to make a PR for this commit alone.

=20

Best regards,

Simon

=20

From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <=
chipitsine@...277...>=20
Sent: Sunday, June 17, 2018 12:58 PM
To: Simon Rozman <simon@...2293...>
Cc: Samuli Sepp=C3=A4nen <samuli@...515...>; jkunkee@...2393...; openvpn-de=
vel <openvpn-devel@lists.sourceforge.net>
Subject: Re: tap-windows6 and AppVeyor

=20

=20

=D0=B2=D1=81, 17 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 14:49, Simon Rozma=
n <simon@...2293... <mailto:simon@...2293...> >:

Please, mind "The system cannot find the path specified." in the output log=
. This basically says: "EWDK not found - not compiling anything". And the a=
rtefact tap6.tar.gz ends up pretty much empty.

=20

We have the same result on AppVeyor already.

=20

=20

sort of. VSTS comes with python 3.X

as of the rest - you are right "The system cannot find ..." --> no errors -=
-> no "*.sys" files

same as App Veyor

=20

I agree that build script should fail on such builds

=20

=20

buildtap.py MUST be upgraded to check error code of each command it invokes=
. Otherwise, you overlook failures of some steps.

=20

Best regards,

Simon

=20

From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <=
chipitsine@...277... <mailto:chipitsine@...277...> >=20
Sent: Saturday, June 16, 2018 11:50 PM
To: Samuli Sepp=C3=A4nen <samuli@...515... <mailto:samuli@...515...> >
Cc: jkunkee@...2393... <mailto:jkunkee@...2393...> ; Simon Rozman <simon@...1186...=
.2293... <mailto:simon@...2293...> >; openvpn-devel <openvpn-devel@...1466...=
urceforge.net <mailto:openvpn-devel@lists.sourceforge.net> >
Subject: Re: tap-windows6 and AppVeyor

=20

not very hard to build on https://visualstudio.com

=20

(still have no idea how to share build logs on web)

=20

=20



=E2=80=8B


------=_NextPart_001_000F_01D4063C.9FC68920
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 15 (filtered medium)"><!--[if !mso]><style>v\:* {behavior:url(#defaul=
t#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.Code, li.Code, div.Code
	{mso-style-name:Code;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Courier New";}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-GB=
 style=3D'mso-fareast-language:EN-US'>I have created a commit at <a href=3D=
"https://github.com/rozmansi/tap-windows6/commit/edefe4fbcaa51b756cc069d53c=
81c8d36de71d08">https://github.com/rozmansi/tap-windows6/commit/edefe4fbcaa=
51b756cc069d53c81c8d36de71d08</a> to throw on command errors. But I'm strug=
gling with Git and GitHub to make a PR for this commit alone.<o:p></o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-langua=
ge:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
GB style=3D'mso-fareast-language:EN-US'>Best regards,<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US=
'>Simon<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=
=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><div style=3D'b=
order:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><di=
v style=3D'border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm=
 0cm'><p class=3DMsoNormal><b><span lang=3DEN-US>From:</span></b><span lang=
=3DEN-US> =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD &lt;chipitsine@...277...&gt; <br><b>Sent:</b> Sunday, June 17, 2018 12:=
58 PM<br><b>To:</b> Simon Rozman &lt;simon@...2293...&gt;<br><b>Cc:</b> Sam=
uli Sepp=C3=A4nen &lt;samuli@...515...&gt;; jkunkee@...2393...; openvpn-dev=
el &lt;openvpn-devel@lists.sourceforge.net&gt;<br><b>Subject:</b> Re: tap-w=
indows6 and AppVeyor<o:p></o:p></span></p></div></div><p class=3DMsoNormal>=
<o:p>&nbsp;</o:p></p><div><p class=3DMsoNormal style=3D'margin-bottom:12.0p=
t'><o:p>&nbsp;</o:p></p><div><div><p class=3DMsoNormal>=D0=B2=D1=81, 17 =D0=
=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 14:49, Simon Rozman &lt;<a href=3D"mai=
lto:simon@...2293...">simon@...2293...</a>&gt;:<o:p></o:p></p></div><blockq=
uote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0=
cm 6.0pt;margin-left:4.8pt;margin-right:0cm'><div><div><p class=3DMsoNormal=
 style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span lang=3D=
EN-GB>Please, mind &quot;The system cannot find the path specified.&quot; i=
n the output log. This basically says: &quot;EWDK not found - not compiling=
 anything&quot;. And the artefact tap6.tar.gz ends up pretty much empty.</s=
pan><o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;ms=
o-margin-bottom-alt:auto'><span lang=3DEN-GB>&nbsp;</span><o:p></o:p></p><p=
 class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:a=
uto'><span lang=3DEN-GB>We have the same result on AppVeyor already.</span>=
<o:p></o:p></p></div></div></blockquote><div><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div=
><p class=3DMsoNormal>sort of. VSTS comes with python 3.X<o:p></o:p></p></d=
iv><div><p class=3DMsoNormal>as of the rest - you are right &quot;The syste=
m cannot find ...&quot; --&gt; no errors --&gt; no &quot;*.sys&quot; files<=
o:p></o:p></p></div><div><p class=3DMsoNormal>same as App Veyor<o:p></o:p><=
/p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=
=3DMsoNormal>I agree that build script should fail on such builds<o:p></o:p=
></p></div><div><p class=3DMsoNormal>&nbsp;<o:p></o:p></p></div><blockquote=
 style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6=
.0pt;margin-left:4.8pt;margin-right:0cm'><div><div><p class=3DMsoNormal sty=
le=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span lang=3DEN-G=
B>&nbsp;</span><o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-=
alt:auto;mso-margin-bottom-alt:auto'><span lang=3DEN-GB>buildtap.py MUST be=
 upgraded to check error code of each command it invokes. Otherwise, you ov=
erlook failures of some steps.</span><o:p></o:p></p><p class=3DMsoNormal st=
yle=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span lang=3DEN-=
GB>&nbsp;</span><o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top=
-alt:auto;mso-margin-bottom-alt:auto'><span lang=3DEN-GB>Best regards,</spa=
n><o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto'><span lang=3DEN-GB>Simon</span><o:p></o:p></p><p cl=
ass=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto=
'><span lang=3DEN-GB>&nbsp;</span><o:p></o:p></p><div style=3D'border:none;=
border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'=
border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p cl=
ass=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto=
'><b><span lang=3DEN-US>From:</span></b><span lang=3DEN-US> =D0=98=D0=BB=D1=
=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:=
chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt; <br><b=
>Sent:</b> Saturday, June 16, 2018 11:50 PM<br><b>To:</b> Samuli Sepp=C3=A4=
nen &lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...2146...=
...</a>&gt;<br><b>Cc:</b> <a href=3D"mailto:jkunkee@...2393..." target=3D"_=
blank">jkunkee@...2393...</a>; Simon Rozman &lt;<a href=3D"mailto:simon@...493...=
2293..." target=3D"_blank">simon@...2293...</a>&gt;; openvpn-devel &lt;<a h=
ref=3D"mailto:openvpn-devel@lists.sourceforge.net" target=3D"_blank">openvp=
n-devel@lists.sourceforge.net</a>&gt;<br><b>Subject:</b> Re: tap-windows6 a=
nd AppVeyor</span><o:p></o:p></p></div></div><p class=3DMsoNormal style=3D'=
mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>&nbsp;<o:p></o:p></p><d=
iv><div><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bo=
ttom-alt:auto'>not very hard to build on <a href=3D"https://visualstudio.co=
m" target=3D"_blank">https://visualstudio.com</a><o:p></o:p></p></div><div>=
<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt=
:auto'>&nbsp;<o:p></o:p></p></div><div><p class=3DMsoNormal style=3D'mso-ma=
rgin-top-alt:auto;mso-margin-bottom-alt:auto'>(still have no idea how to sh=
are build logs on web)<o:p></o:p></p></div><div><p class=3DMsoNormal style=
=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>&nbsp;<o:p></o:p></=
p></div><div><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-marg=
in-bottom-alt:auto'>&nbsp;<o:p></o:p></p></div><div><div><p class=3DMsoNorm=
al style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><img border=
=3D0 width=3D566 height=3D406 style=3D'width:5.8958in;height:4.2291in' id=
=3D"m_-3788277345559681912_x005f_x0000_i1025" src=3D"cid:image001.png@...2416...=
15..." alt=3Dvsbs.png><o:p></o:p></p></div><p class=3DMsoNormal style=3D'ms=
o-margin-top-alt:auto;mso-margin-bottom-alt:auto'>=E2=80=8B<o:p></o:p></p><=
/div></div></div></div></div></blockquote></div></div></div></div></body></=
html>=

------=_NextPart_001_000F_01D4063C.9FC68920--

------=_NextPart_000_000E_01D4063C.9FC68920
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwMwJzAlBggrBgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzAIBgYEAIswAQIwGAYI
KwYBBQUHAQMEDDAKMAgGBgQAjkYBATAaBgNVHREEEzARgQ9zaW1vbkByb3ptYW4uc2kwge4GA1Ud
HwSB5jCB4zBWoFSgUqRQME4xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlv
bnMxETAPBgNVBAsTCHNpZ2VuLWNhMQ8wDQYDVQQDEwZDUkw0NTUwgYiggYWggYKGV2xkYXA6Ly94
NTAwLmdvdi5zaS9vdT1zaWdlbi1jYSxvPXN0YXRlLWluc3RpdHV0aW9ucyxjPXNpP2NlcnRpZmlj
YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYYnaHR0cDovL3d3dy5zaWdlbi1jYS5zaS9jcmwvc2lnZW4t
Y2EuY3JsMCsGA1UdEAQkMCKADzIwMTYwMjE5MTc1NDQxWoEPMjAyMTAyMTkyMTM4MTVaMB8GA1Ud
IwQYMBaAFHF7igYfMQVVq2ASd0cgHgOIGOyJMB0GA1UdDgQWBBS7/7AHyQYI0e8GOPmwTc1ZTNw5
lzAJBgNVHRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjEDAgOoMA0GCSqGSIb3DQEBBQUAA4IB
AQBBUL4KG1Z1oBIIdKIZs9yJxnJg/LfEPVvzNH8+CCqegq0D6k48Doo72oVEiskjqggdbUGj30uA
H8PjCD5kLGVoDwh5a2atQ3qQzaYA/lj2Js2f4fdXNn60vRp7XzbGsQdwYYecIrKzO5x6XVAIRb+T
HZNjXL3VX6vOozwBQv/+dx1P9H/rMUn7d8ci7v4PeqShbWbWwi6ez19cZvSKSkz/lWf4tj8QbA0n
WeUBlk3Bx6/TRda7kwXzcFExt+ROGt0YJjbZCN3kd7swcRvRT6gEi9L6n1XLghwPSYhzZjaL5fXv
I11JuSoQCy13XWBkq35Moo4iY19wanS1W6UM8Yq0MIIF5TCCBE2gAwIBAgINAKZovVEAAAAAVx3Q
6DANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3Zl
bmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QwHhcN
MTYwNTI0MTE1ODI3WhcNMjEwNjI3MjIwMDAwWjA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3Rh
dGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALDlZbLArGSW8ogbs+2e5ALGTyuIzi6KUYB1rxBb8ss4ZpuiDm00R5alkhGv9jVH
onciDM4WiGKq00luGLwuRNi+xp7CGhmsQY78MAcC8sZq1FsjAO9BNNikc2PfIpIzhAGljfODXPq4
1Ho13+z4bQ/gTO2tnDp9htalCJS+fXoRH/6FP1RaiGOHnKWxp07Nt0Rzr8+KSWsf483XSU1aKxfm
XHazu3K5byfSm4kViN8QX3YhAWrHFTEK0ZxY+CgWBW3ZTtmh1wcgy0smiU2Ssqe6lujjWI8inAGW
WsT3MU0LSbXheGHiVBgGu55UNH4MPuvutYAf3RaEHWg4Zmdz+JECAwEAAaOCAkMwggI/MBIGA1Ud
EwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEwLwYEVR0gADAnMCUGCCsG
AQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUFBwEBBF0wWzA2BggrBgEF
BQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJvb3QuY3J0MCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwHQYDVR0OBBYEFHF7igYfMQVVq2ASd0cgHgOIGOyJ
MIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9zaS10
cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qsb3Jn
YW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zlbmlq
YSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJTSTEc
MBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAU
BgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4IAmMw
DQYJKoZIhvcNAQELBQADggGBAHuvNSPhY4qcirWJkTwkqaOPqOSV06J/ZepFQfUEJ87TlrGjp4XR
5FLktTAEY/7R4Sgeb2K8OWEl/Koc1BbH6+uyZYvfa+WnnJEWeWOmyPy/vooO7eZyOVvaORxurWOL
CCVDW2wBkbtUoKZaUyzgP+ZPPGRV8GFlbZLCzGmArMGXJXe8t/XNiJDLehGqSWT49NYjyYQdIgI+
qi9W+A6BSUQ9jsMdYJqKhXQcosfH51sc6gZVxTKMr3PsItsa8XFiNazECAAFr0ms7HB6zb8QvHRF
eBGk/CLrW4VkZEBN/JtuyhvgktQ2BvuGtauEvHZQAYpMSh35D7pwtavRMpmhaAsQb4yPqhIMcztw
RqsKPBhWoaFEVZ+Vn3wxap5h/oAhocifNzkWJTNWjxnoPM2eNz2uWFJsgsNhlwteUvnq7+bKTNte
SKWKr6pI+GUsZhmCh5URpUnqUanp0Uie0MD9f3tiOLOp711sNb0xwi+VdDuDB37IddOIsfhPBood
wpoFrTGCAyEwggMdAgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggGtMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDYxNzExMTA1NFowLwYJKoZIhvcN
AQkEMSIEIOygCs555yqL3g5FwcdRGyWmQx+kUh+C0qRMIcU0/xVTMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAPvrtdkqJDlsgdrc8w3kb8k2
Llukzd4NiVr/KISUcn4rIgOvPfAEzitS2K6R6CwrqqEfUZ6vcqjh5aSQ/171NppIsUK+8t83bS5l
G82b/nF9f170P9gJVYALiKoveduKTk3yjj0zVRM/zNIuDyEWPRTarczoQr9r66n980IvYkVK3VDx
H6fMEsi45WK9mWZl9/A/zTtZwybzB9OByvm+nrnjrGy49vmZWTrGlCqQSSo475h3jhF9iL+iv8Z+
MxyQJXtwLWhlvOJ+NLqcHsa4yUQ0G+/cT6nzskAe69dFRGEQPrkb40TGwIDZPSjnlkvibP/qTyYH
+G6kScALJOTBsYIAAAAAAAA=

------=_NextPart_000_000E_01D4063C.9FC68920--

