From: Simon Rozman <simon@...2293...>
Date: Wed, 20 Nov 2019 10:35:32 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
 <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
In-Reply-To: <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_001D_01D59F96.9D45DD50"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Lev Stipakov <lstipakov@...277...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_001D_01D59F96.9D45DD50
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_001E_01D59F96.9D45DD50"

------=_NextPart_001_001E_01D59F96.9D45DD50
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

The Wintun doesn't create its own communication I/O device. Running a separ=
ate NdisRegisterDeviceEx() device came with a big can of worms, so we decid=
ed not to run our own, but rather piggy-back on the existing NDIS one from =
the NdisMRegisterMiniportDriver() that we tap on. Technically, we could lim=
it it to a single client handle, but this device is primarily used by Windo=
ws to manage the adapter, therefore we must not tweak it in this direction.

=20

As Lev said: Wintun adds an IOCTL call to register ring buffers and it is t=
his IOCTL that has a refcounting implemented to deny secondary connection a=
ttempts. Unfortunately for OpenVPN, this IOCTL is restricted to privileged =
processes only. You cannot use it to detect which Wintun adapters are in us=
e by an unprivileged openvpn.exe process. WireGuard is very strict about wh=
ich TUN adapter it will use =E2=80=93 it will never ever use a lottery to p=
ick one.

=20

We have more options here:

=20

A.	Wintun adapter can be explicitly chosen by configuration only (by name o=
r GUID). With tapctl.exe utility users can make an adapter with predefined =
name and put this name into .ovpn. If the Wintun adapter is not specified e=
xplicitly =3D> configuration error. Less lottery; predictable tunnel-adapte=
r mapping when running multiple tunnels; disturbed users because there is a=
n inconsistency between TAP-Windows6 and Wintun adapter selection logic.
B.	The tapctl.exe code is in OpenVPN repo already and could be integrated i=
n openvpn.exe and interactive service to create Wintun adapter on demand. B=
ut, you have to take responsibility to clean what you have created. Pretty =
much the same as A), but nicer for user. In the long term, I'd suggest this=
 "create adapter if doesn't exist" approach even for TAP-Windows6 adapters.
C.	Use adapter media state to see if particular Wintun adapter is already i=
n use or not. Mind that registering buffer also sets MediaConnectStateConne=
cted, and stays connected until its client closes handle or dies. This allo=
ws OpenVPN to extend its "use first available adapter" approach to Wintun a=
dapters.

=20

Best regards,

Simon

=20

From: Selva Nair <selva.nair@...277...>=20
Sent: Tuesday, November 19, 2019 7:03 PM
To: Lev Stipakov <lstipakov@...277...>
Cc: Lev Stipakov <lev@...515...>; openvpn-devel <openvpn-devel@...1659...=
forge.net>
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintu=
n device

=20

Hi Lev,

=20

On Tue, Nov 19, 2019 at 12:23 PM Lev Stipakov <lstipakov@...277... <mailto:=
lstipakov@...277...> > wrote:

Hi,

=20

Apart from the error message, there is a larger issue especially when we us=
e iservice. In that case, we have to preserve privilege separation and allo=
wing a user to open a device handle in use by another has to be avoided.

=20

Do you see it as a security issue when handle can be opened by another proc=
ess?

=20

I don't know the internals of wintun to know that for sure.=20

=20=20

=20

To read / write to tunnel one needs to register ring buffers, and this call=
 will fail for any other process. Am I missing something here?

=20

Hopefully, Simon can confirm whether that provides a sufficient safety net.

=20

Selva


------=_NextPart_001_001E_01D59F96.9D45DD50
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
/* List Definitions */
@list l0
	{mso-list-id:182279862;
	mso-list-type:hybrid;
	mso-list-template-ids:514901922 -1427472230 69468185 69468187 69468175 694=
68185 69468187 69468175 69468185 69468187;}
@list l0:level1
	{mso-level-number-format:alpha-upper;
	mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
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
ast-language:EN-US'>The Wintun doesn't create its own communication I/O dev=
ice. Running a separate NdisRegisterDeviceEx() device came with a big can o=
f worms, so we decided not to run our own, but rather piggy-back on the exi=
sting NDIS one from the NdisMRegisterMiniportDriver() that we tap on. Techn=
ically, we could limit it to a single client handle, but this device is pri=
marily used by Windows to manage the adapter, therefore we must not tweak i=
t in this direction.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'=
>As Lev said: Wintun adds an IOCTL call to register ring buffers and it is =
this IOCTL that has a refcounting implemented to deny secondary connection =
attempts. Unfortunately for OpenVPN, this IOCTL is restricted to privileged=
 processes only. You cannot use it to detect which Wintun adapters are in u=
se by an unprivileged openvpn.exe process. WireGuard is very strict about w=
hich TUN adapter it will use =E2=80=93 it will never ever use a lottery to =
pick one.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB styl=
e=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'>We have more=
 options here:<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB=
 style=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><ol style=
=3D'margin-top:0cm' start=3D1 type=3DA><li class=3DMsoListParagraph style=
=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB style=3D'ms=
o-fareast-language:EN-US'>Wintun adapter can be explicitly chosen by config=
uration only (by name or GUID). With tapctl.exe utility users can make an a=
dapter with predefined name and put this name into .ovpn. If the Wintun ada=
pter is not specified explicitly =3D&gt; configuration error. Less lottery;=
 predictable tunnel-adapter mapping when running multiple tunnels; disturbe=
d users because there is an inconsistency between TAP-Windows6 and Wintun a=
dapter selection logic.<o:p></o:p></span></li><li class=3DMsoListParagraph =
style=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB style=
=3D'mso-fareast-language:EN-US'>The tapctl.exe code is in OpenVPN repo alre=
ady and could be integrated in openvpn.exe and interactive service to creat=
e Wintun adapter on demand. But, you have to take responsibility to clean w=
hat you have created. Pretty much the same as A), but nicer for user. In th=
e long term, I'd suggest this &quot;create adapter if doesn't exist&quot; a=
pproach even for TAP-Windows6 adapters.<o:p></o:p></span></li><li class=3DM=
soListParagraph style=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lan=
g=3DEN-GB style=3D'mso-fareast-language:EN-US'>Use adapter media state to s=
ee if particular Wintun adapter is already in use or not. Mind that registe=
ring buffer also sets MediaConnectStateConnected, and stays connected until=
 its client closes handle or dies. This allows OpenVPN to extend its &quot;=
use first available adapter&quot; approach to Wintun adapters.<o:p></o:p></=
span></li></ol><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast=
-language:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-GB>Best regards,<o:p></o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-GB>Simon<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'ms=
o-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><div style=3D'border:=
none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div styl=
e=3D'border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'>=
<p class=3DMsoNormal><b><span lang=3DEN-US>From:</span></b><span lang=3DEN-=
US> Selva Nair &lt;selva.nair@...277...&gt; <br><b>Sent:</b> Tuesday, Novem=
ber 19, 2019 7:03 PM<br><b>To:</b> Lev Stipakov &lt;lstipakov@...277...&gt;=
<br><b>Cc:</b> Lev Stipakov &lt;lev@...515...&gt;; openvpn-devel &lt;openvp=
n-devel@lists.sourceforge.net&gt;<br><b>Subject:</b> Re: [Openvpn-devel] [P=
ATCH v2 3/7] wintun: implement opening wintun device<o:p></o:p></span></p><=
/div></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div><p class=3DM=
soNormal>Hi Lev,<o:p></o:p></p></div><p class=3DMsoNormal><o:p>&nbsp;</o:p>=
</p><div><div><p class=3DMsoNormal>On Tue, Nov 19, 2019 at 12:23 PM Lev Sti=
pakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipako=
v@...277...</a>&gt; wrote:<o:p></o:p></p></div><blockquote style=3D'border:=
none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:=
4.8pt;margin-right:0cm'><div><div><div><p class=3DMsoNormal>Hi,<o:p></o:p><=
/p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><blockqu=
ote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0c=
m 6.0pt;margin-left:4.8pt;margin-right:0cm'><div><div><div><p class=3DMsoNo=
rmal>Apart from the error message, there is a larger issue especially when =
we use iservice. In that case, we have to preserve privilege separation and=
 allowing a user to open a device handle in use by another has to be avoide=
d.<o:p></o:p></p></div></div></div></blockquote><div><p class=3DMsoNormal><=
o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Do you see it as a secu=
rity issue when handle can be opened by another process?<o:p></o:p></p></di=
v></div></div></div></blockquote><div><p class=3DMsoNormal><o:p>&nbsp;</o:p=
></p></div><div><p class=3DMsoNormal>I don't know the internals of wintun t=
o know that for sure. <o:p></o:p></p></div><div><p class=3DMsoNormal>&nbsp;=
 <o:p></o:p></p></div><blockquote style=3D'border:none;border-left:solid #C=
CCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm'><=
div><div><div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>To read / write to tunnel one needs to register ring buff=
ers, and this call will fail for any other process. Am I missing&nbsp;somet=
hing here?<o:p></o:p></p></div></div></div></div></blockquote><div><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Hopefully=
, Simon can confirm whether that provides a sufficient safety net.<o:p></o:=
p></p></div></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div=
><p class=3DMsoNormal>Selva<o:p></o:p></p></div></div></div></div></body></=
html>=

------=_NextPart_001_001E_01D59F96.9D45DD50--

------=_NextPart_000_001D_01D59F96.9D45DD50
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTEyMDEwMzUzMFowLwYJKoZIhvcN
AQkEMSIEINSIQqhY2ep6+CVSgBJ/BBbkO9ANTOJowtyMu8NxspQcMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBALF26U0LeTpfjTSeh7uv95/1
ThXAGGJQ22A9MPFQo07EcB3QmmTCdvjVY2xTLfVM+Mefix4AJxHePjIp1OoYLzd1bCRvgGfdsxSa
t7o3MSUTTFtrNX8+6b16mIO2Q89KD/UrE3KplGGsI8QEqqy+emYBcrCUfGbwHJRi59EAiLksXzrO
ExM0/MKKCLkmycPxwxBK/ZtEV2xIOaBsYR8AJeYbM7yyYFiYW+jQTBioQMNj0ZBKtfptIXsbSZM9
lC8jjtkODd+8YUSq2zJQmE8CrHOaBBirmweWxwweijm2I2uC8mqfjFU2DxE94HvPAeSSDDvnrkbC
m8/w506wES4kRuUAAAAAAAA=

------=_NextPart_000_001D_01D59F96.9D45DD50--

