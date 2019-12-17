From: Simon Rozman <simon@...2293...>
Date: Tue, 17 Dec 2019 11:18:10 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10D05C6F28@...2294...>
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
 <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
 <CAGyAFMUgY+dj0TD75dsKL1pQqPP4CRcEObijyCHB7wUbehpEtw@...278...>
In-Reply-To: <CAGyAFMUgY+dj0TD75dsKL1pQqPP4CRcEObijyCHB7wUbehpEtw@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_000E_01D5B4D4.0ACD70C0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_000E_01D5B4D4.0ACD70C0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_000F_01D5B4D4.0ACD70C0"

------=_NextPart_001_000F_01D5B4D4.0ACD70C0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,



Lev, unfortunately, the openvpn.exe binary will still contain this hack's 
machine code and might really rise some eyebrows with anti-virus software.



Before the final release the entire SYSTEM token hack should be removed from 
the OpenVPN source.



I think it's okay to make a note in README that "--windows-driver wintun" 
works with iservice only. (Or, if user is responsible to run openvpn.exe as 
SYSTEM user himself somehow.)



Regards,

Simon



From: Lev Stipakov <lstipakov@...277...>
Sent: Tuesday, December 17, 2019 10:35 AM
To: Selva Nair <selva.nair@...277...>
Cc: Simon Rozman <simon@...2293...>; Lev Stipakov <lev@...515...>; 
openvpn-devel <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O



How about compromise - let's add  "--enable-system-elevation" windows specific 
option.



 - When it is set, we print warning and elevate to SYSTEM for the single 
DeviceIOControl call



 - When it is not set and wintun is used, we run openvpn from command line via 
iservice



 - If service is missing, we print error "either use iservice 
or --enable-system-elevation (experts only)"



The ones who want to run openvpn from command line with wintun still could do 
it via psexec and it is

assumed that they know what they are doing. So why not make it simpler and add 
a option

"yes I know what I am doing and I am willing to take risks"? Also, it is safer 
to use system privilege

just for single call rather than run whole process with it.



This also will make debugging / development easier.


------=_NextPart_001_000F_01D5B4D4.0ACD70C0
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
 style=3D'mso-fareast-language:EN-US'>Hi,<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'><o:p>&nbsp=
;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fare=
ast-language:EN-US'>Lev, unfortunately, the openvpn.exe binary will still c=
ontain this hack's machine code and might really rise some eyebrows with an=
ti-virus software.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-GB style=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'>Bef=
ore the final release the entire SYSTEM token hack should be removed from t=
he OpenVPN source.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-GB style=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'>I t=
hink it's okay to make a note in README that &quot;--windows-driver wintun&=
quot; works with iservice only. (Or, if user is responsible to run openvpn.=
exe as SYSTEM user himself somehow.)<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-l=
anguage:EN-US'>Regards,<o:p></o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-GB style=3D'mso-fareast-language:EN-US'>Simon<o:p></o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'=
><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-left:solid bl=
ue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;border-t=
op:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><=
span lang=3DEN-GB>From:</span></b><span lang=3DEN-GB> Lev Stipakov &lt;lsti=
pakov@...277...&gt; <br><b>Sent:</b> Tuesday, December 17, 2019 10:35 AM<br=
><b>To:</b> Selva Nair &lt;selva.nair@...277...&gt;<br><b>Cc:</b> Simon Roz=
man &lt;simon@...2293...&gt;; Lev Stipakov &lt;lev@...515...&gt;; openvpn-d=
evel &lt;openvpn-devel@lists.sourceforge.net&gt;<br><b>Subject:</b> Re: [Op=
envpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O<o:p></o:p></span=
></p></div></div><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p><=
/span></p><div><p class=3DMsoNormal><span lang=3DEN-GB>How about compromise=
 - let's add&nbsp; &quot;--enable-system-elevation&quot; windows specific o=
ption.<o:p></o:p></span></p><div><p class=3DMsoNormal><span lang=3DEN-GB><o=
:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span lang=3DEN-G=
B>&nbsp;- When it is set, we print warning and elevate to SYSTEM for the si=
ngle DeviceIOControl call<o:p></o:p></span></p></div><div><p class=3DMsoNor=
mal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p></div><div><p class=3DMs=
oNormal><span lang=3DEN-GB>&nbsp;- When it is not set and wintun is used, w=
e run openvpn from command line via iservice<o:p></o:p></span></p></div><di=
v><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p></div=
><div><p class=3DMsoNormal><span lang=3DEN-GB>&nbsp;- If service is missing=
, we print error &quot;either use iservice or --enable-system-elevation (ex=
perts only)&quot;<o:p></o:p></span></p></div><div><p class=3DMsoNormal><spa=
n lang=3DEN-GB><o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal>=
<span lang=3DEN-GB>The ones who want to run openvpn from command line with =
wintun still could do it via psexec and it is<o:p></o:p></span></p></div><d=
iv><p class=3DMsoNormal><span lang=3DEN-GB>assumed that they know what they=
 are doing. So why not make it simpler and add a option<o:p></o:p></span></=
p></div><div><p class=3DMsoNormal><span lang=3DEN-GB>&quot;yes I know what =
I am doing and I am willing to take risks&quot;? Also, it is safer to use s=
ystem privilege<o:p></o:p></span></p></div><div><p class=3DMsoNormal><span =
lang=3DEN-GB>just for single call rather than run whole process with it.<o:=
p></o:p></span></p></div><div><p class=3DMsoNormal><span lang=3DEN-GB><o:p>=
&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span lang=3DEN-GB>T=
his also will make debugging / development easier.<o:p></o:p></span></p></d=
iv></div></div></div></body></html>=

------=_NextPart_001_000F_01D5B4D4.0ACD70C0--

------=_NextPart_000_000E_01D5B4D4.0ACD70C0
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
wpoFrTGCAzswggM3AgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggHHMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTIxNzExMTgwOFowLwYJKoZIhvcN
AQkEMSIEIMIwlsx3Q/D0h3yIkH6PDr3iqBd+gZ8rz9fQzy2Z5M0MMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGtBgkqhkiG9w0BCQ8x
gZ8wgZwwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcw
CwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEw
CwYJKoZIhvcNAQEKMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowDQYJKoZIhvcN
AQEBBQAEggEA11rWrt3oDoCVlCezNh6tnsWQApWMe1TFNHmX8aNRynACsj1Zr1bu/1bLHtbnA8Cn
wy+xrgef8xyiQfWnx7Zjjpce75EQ3StVqtr9YnsN2Nf+GcA7QUKIFmsdX1zYQsW7Cf4FHJd7BdM0
Vyyr7f3AsH7+Qnc3JCeESu9RqBAAdFPPbUCqDVdFzncR8j+X703uTyKyXzhRlI9ZDJb34lkhSG3o
o+EeHkJ9ufgSJPdbXupHN8+/UxRpkEqMEsnM2uwF+e9sgyfIP8it4HRECkgzCtaO7aL9H0ewE1oc
E2ThhJhy+7CWQszv/ffMj8Quwn0JPBdQVk09UuFYhK54ar4/FgAAAAAAAA==

------=_NextPart_000_000E_01D5B4D4.0ACD70C0--

