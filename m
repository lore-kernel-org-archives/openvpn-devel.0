From: Simon Rozman <simon@...2293...>
Date: Mon, 9 Mar 2020 13:42:23 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10D0819030@...2294...>
References: <20200205183841.1118-1-simon@...2293...>
 <CAGyAFMX=RosZ7mddKEwwRgLTqF3uXL5qdaGQUE3tt_Z7Qm6o0Q@...278...>
In-Reply-To: <CAGyAFMX=RosZ7mddKEwwRgLTqF3uXL5qdaGQUE3tt_Z7Qm6o0Q@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_003E_01D5F620.F0C709A0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] wintun: upgrade error message in case
 of ring registration failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_003E_01D5F620.F0C709A0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_003F_01D5F620.F0C709A0"

------=_NextPart_001_003F_01D5F620.F0C709A0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I believe M_ERRNO should handle this=E2=80=A6

=20

After the register_ring_buffers() exits, the Win32 error code is left in Ge=
tLastError().

msg(M_ERRNO) picks it from there and formats a human-readable message.

=20

Regards, Simon

=20

From: Lev Stipakov <lstipakov@...277...>=20
Sent: Wednesday, February 5, 2020 8:38 PM
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] [PATCH] wintun: upgrade error message in case =
of ring registration failure

=20

Hi,

=20

-            msg(M_NONFATAL, "Failed to register ring buffers: %lu", GetLas=
tError());

<skip>=20

+            switch (GetLastError())

<skip>=20

+                default:
+                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring buf=
fers");

=20

I think it would make sense to print the error code / error message (with s=
trerror_win32) in the "default" case.


------=_NextPart_001_003F_01D5F620.F0C709A0
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
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3D"#0563C1" v=
link=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'mso-fareast-language:EN-US'>Hi,<o:p></o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'><o=
:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'=
mso-fareast-language:EN-US'>I believe M_ERRNO should handle this=E2=80=A6<o=
:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fa=
reast-language:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-GB style=3D'mso-fareast-language:EN-US'>After the register_ring=
_buffers() exits, the Win32 error code is left in GetLastError().<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-la=
nguage:EN-US'>msg(</span>M_ERRNO<span lang=3DEN-GB style=3D'mso-fareast-lan=
guage:EN-US'>) picks it from there and formats a human-readable message.<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-far=
east-language:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-GB style=3D'mso-fareast-language:EN-US'>Regards, Simon<o:p></o:p=
></span></p><p class=3DMsoNormal><span style=3D'mso-fareast-language:EN-US'=
><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-left:solid bl=
ue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;border-t=
op:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><=
span lang=3DEN-US>From:</span></b><span lang=3DEN-US> Lev Stipakov &lt;lsti=
pakov@...277...&gt; <br><b>Sent:</b> Wednesday, February 5, 2020 8:38 PM<br=
><b>To:</b> Simon Rozman &lt;simon@...2293...&gt;<br><b>Cc:</b> openvpn-dev=
el &lt;openvpn-devel@lists.sourceforge.net&gt;<br><b>Subject:</b> Re: [Open=
vpn-devel] [PATCH] wintun: upgrade error message in case of ring registrati=
on failure<o:p></o:p></span></p></div></div><p class=3DMsoNormal><o:p>&nbsp=
;</o:p></p><div><div><div><p class=3DMsoNormal>Hi,<o:p></o:p></p><div><p cl=
ass=3DMsoNormal><o:p>&nbsp;</o:p></p></div></div><div><blockquote style=3D'=
border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margi=
n-left:4.8pt;margin-right:0cm'><p class=3DMsoNormal>-&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; msg(M_NONFATAL, &quot;Failed to register ring buffers: =
%lu&quot;, GetLastError());<o:p></o:p></p></blockquote><div><p class=3DMsoN=
ormal>&lt;skip&gt;&nbsp;<o:p></o:p></p></div><blockquote style=3D'border:no=
ne;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.=
8pt;margin-right:0cm'><p class=3DMsoNormal>+&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; switch (GetLastError())<o:p></o:p></p></blockquote><div><p class=
=3DMsoNormal>&lt;skip&gt;&nbsp;<o:p></o:p></p></div><blockquote style=3D'bo=
rder:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-=
left:4.8pt;margin-right:0cm'><p class=3DMsoNormal>+&nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; default:<br>+&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; msg(M_NONFATAL | M_ERRNO, &quot;Fai=
led to register ring buffers&quot;);<o:p></o:p></p></blockquote><div><p cla=
ss=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>I think=
 it would make sense to print the error code / error message (with strerror=
_win32) in the &quot;default&quot; case.<o:p></o:p></p></div></div></div></=
div></div></div></body></html>=

------=_NextPart_001_003F_01D5F620.F0C709A0--

------=_NextPart_000_003E_01D5F620.F0C709A0
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDMwOTEzNDIyMVowLwYJKoZIhvcN
AQkEMSIEIKO27/uFMWkz/r6VzdVtGln6mhkesMJPhoTB0jDNqL6FMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAIvcB4Pvi3sSxEHFsW1jseub
E6ghgEOFU4lgbBmvEN9Quz+rrCTyCDiPqAm1I1BNE4I3xA0L5uylHpjhtybQtIznoFbtwVjO1q0K
5LpMlgr+J6bhXN9JMTq7LhY1Hlx6pj1nzqcfAvUGqmlH133bTNhIF9eI8kUpwxCYrKtyDntMMiXX
8G/EARI/WPKS1wcOVgdvvWHSG8NC8NxFNLxw+xZH8gWPTbHCCG8Lb6BpUwsdx9IYQO6WekaNZ2Ea
iKwVVSK6V5E31PdGCnyZ+1hmO8jkogxwV4yv6RcUR4ZOAO8tJfQ7K6Ff5+o7dPZJYVOdqXDbMFhM
75p0HvybxAqnzAoAAAAAAAA=

------=_NextPart_000_003E_01D5F620.F0C709A0--

