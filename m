From: "Dave" <dev@...575...>
Date: Thu, 22 Jun 2006 15:27:26 -0500
MIME-Version: 1.0
Message-ID: <000f01c6963a$47746dc0$1601a8c0@...576...>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0008_01C69610.5D2A6360"
In-Reply-To: <184379570606220830q3180ebavcc4a6d624c56525a@...278...>
Subject: Re: [Openvpn-devel] i-mate SP5 & OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Sameh Attia' <sattia@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C69610.5D2A6360
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0009_01C69610.5D2A6360"

------=_NextPart_001_0009_01C69610.5D2A6360
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

For the first three items it's really in my court, the last one you might
look on xda-developers.  Those guys are quite saavy and should know if
there's need to 'unlock' your device to run code that installs/starts
device drivers, and have hacks and stuff for doing that if needed.

On the other hand, if you are a developer yourself, you might not wish to
wait on me and rather cook up your own gui to control the VPN.  Here's a
very brief description of the structure of the 'product':

*  tap-ce.dll is the TAP driver.  I suspect this will work fine as-is on
smartphone (barring privileged execution issues).  I can't know for
certain because I don't have a device to test with, and you need some
programmatic interaction to prove it.
*  openvpn.exe is the port of the OpenVPN.  I suspect this will also work
fine as-is on smartphone (barring privileged execution issues).  It has no
user interface whatsoever, so there needs to be a third part.
*  ovpncmgr.exe is the gui that is used to spawn and control running
instances of the vpn (provided by openvpn.exe).  This is the part that I
know doesn't work on smartphone due to some dependencies not being present
on that platform.  It interacts with the running instances over the
'management' channel, which is essentially a locally bound TCP port with a
simple but custom text-based protocol.

My current working thought is to redesign/implement the GUI in .NET CF or
possibly in native SDK form.  These are supported on smartphone (the
current one is in MFC which is not supported on smartphone).

Lastly, all this is based upon my current understanding without having run
any code, so I could easily be wrong or be missing other additional
issues.

-Dave

-----Original Message-----
From: openvpn-devel-bounces@lists.sourceforge.net
[mailto:openvpn-devel-bounces@lists.sourceforge.net] On Behalf Of Sameh
Attia
Sent: Thursday, June 22, 2006 10:30 AM
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] i-mate SP5 & OpenVPN



Thank you Dave for your fast response, I did not expect to get any reply
today.
Are there any pointers I can start with?


On 6/22/06, Dave < dev@...575... <mailto:dev@...575...> > wrote:


It's fairly different in a couple areas:

*  The installer needs to be marked in some way as supporting smartphone.
This is the problem you are having now.
*  Smartphone devices don't have all the runtime functionality the
PocketPC devices do.  Even if you manually installed it you would still
have missing dependencies.
*  Smartphone GUI is a little different that PocketPC in that it does not
use touchscreen, etc.  The GUI will need to be reworked a little to make
is useable in the Smartphone context.
*  Smartphone devices occaisionally require execution privileges that will
preclude running software not signed by a special 'privileged' code
signing key from the Mobile Operator.  Enforcing this is at the operator's
descretion, so it depends on who you have.

Several folks have asked about Smartphone as of late, and there is some
exploratory work going on.  The first items listed above are doable.  The
last one is more questionable.  There is also the possibility that you can
unlock your device even if it is locked down if you find yourself in that
situation.

So, short story is there is not Smartphone support, but you may wish to
check back in about a month or so.

-----Original Message-----
From: openvpn-devel-bounces@lists.sourceforge.net
[mailto:openvpn-devel-bounces@lists.sourceforge.net] On Behalf Of Sameh
Attia
Sent: Thursday, June 22, 2006 6:46 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] i-mate SP5 & OpenVPN


Hi,
   I bought this phone http://www.imate.com/t-DETAILS_SP5.aspx after
checking your site to make sure it is supported. Unfortunately, when I
attempted to install the client I got the error message of something like
'unsuccessfull installation ....unsupported device'.

I checked the forum to see if there are any workarounds but no avail. Is
the Windows Mobile 5.0 Smart Phone Edition different from the Windows
Mobile 5.0?
Please help.
Regards






--
Sameh Attia
Information Security Manager
Red Hat Certified Engineer
TE Data
--
The two basic principles of Windows system administration:

   * For minor problems, reboot
   * For major problems, reinstall

dc -e
'603178305900664311156641389051003470569569613466992253686426210705237258P
'


------=_NextPart_001_0009_01C69610.5D2A6360
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>For the first three items it's really in my court, the last one yo=
u might=20
look on xda-developers.&nbsp; Those guys are quite saavy and&nbsp;should kn=
ow if=20
there's need to 'unlock' your device to run code that installs/starts devic=
e=20
drivers,&nbsp;and have hacks and stuff for doing&nbsp;that if=20
needed.</FONT></SPAN></DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>On the other hand, if you are a developer yourself, you might not =
wish to=20
wait on me and rather cook up your own gui to control the VPN.&nbsp; Here's=
 a=20
very brief description of the structure of the 'product':</FONT></SPAN></DI=
V>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; tap-ce.dll is the TAP driver.&nbsp; I suspect this will wo=
rk fine=20
as-is on smartphone (barring privileged execution issues).&nbsp; I can't kn=
ow=20
for certain because I don't have a device to test with, and you need some=20
programmatic interaction to prove it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; openvpn.exe is the port of the OpenVPN.&nbsp; I suspect th=
is will=20
also work fine as-is on smartphone (barring privileged execution issues).&n=
bsp;=20
It has no user interface whatsoever, so there needs to be a third=20
part.</FONT></SPAN></DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; ovpncmgr.exe is the gui that is used to spawn and control =
running=20
instances of the vpn (provided by openvpn.exe).&nbsp; This is the part that=
 I=20
know doesn't work on smartphone due to some dependencies not being present =
on=20
that platform.&nbsp; It interacts with the running instances over the=20
'management' channel, which is essentially a locally bound TCP port with a=
=20
simple but custom text-based protocol.</FONT></SPAN></DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>My current working thought is to redesign/implement the GUI in .NE=
T CF or=20
possibly in native SDK form.&nbsp; These are supported on smartphone (the=20
current one is in MFC which is not supported on smartphone).</FONT></SPAN><=
/DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Lastly, all this is based upon my current understanding without ha=
ving=20
run any code, so I could easily be wrong or be missing other additional=20
issues.</FONT></SPAN></DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>-Dave</FONT></SPAN></DIV>
<DIV><SPAN class=3D189291620-22062006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><FONT face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B=
>=20
openvpn-devel-bounces@lists.sourceforge.net=20
[mailto:openvpn-devel-bounces@lists.sourceforge.net] <B>On Behalf Of </B>Sa=
meh=20
Attia<BR><B>Sent:</B> Thursday, June 22, 2006 10:30 AM<BR><B>Cc:</B>=20
openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> Re: [Openvpn-devel]=
=20
i-mate SP5 &amp; OpenVPN<BR><BR></FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">Thank=20
  you Dave for your fast response, I did not expect to get any reply=20
  today.<BR>Are there any pointers I can start with?<BR><BR>
  <DIV><SPAN class=3Dgmail_quote>On 6/22/06, <B class=3Dgmail_sendername>Da=
ve</B>=20
  &lt;<A href=3D"mailto:dev@...575..."> dev@...575...</A>&gt;=20
  wrote:</SPAN>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(2=
04,204,204) 1px solid">
    <DIV>
    <DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>It's&nbs=
p;fairly=20
    different in&nbsp;a couple&nbsp;areas:</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff=20
    size=3D2></FONT></SPAN>&nbsp;</DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>*&nbsp; =
The=20
    installer needs to be marked in some way as supporting smartphone.&nbsp=
;=20
    This is the problem you are having now.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>*&nbsp; =
Smartphone=20
    devices don't have all the runtime functionality the PocketPC devices=20
    do.&nbsp; Even if you manually installed it you would still have missin=
g=20
    dependencies.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>*&nbsp; =
Smartphone=20
    GUI is a little different that PocketPC in that it does not use touchsc=
reen,=20
    etc.&nbsp; The GUI will need to be reworked a little to make is useable=
 in=20
    the Smartphone context.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>*&nbsp; =
Smartphone=20
    devices&nbsp;occaisionally require execution privileges that will precl=
ude=20
    running software not signed by a special 'privileged' code signing key =
from=20
    the Mobile Operator.&nbsp; Enforcing this is at the operator's descreti=
on,=20
    so it depends on who you have.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff=20
    size=3D2></FONT></SPAN>&nbsp;</DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>Several =
folks have=20
    asked about Smartphone as of late, and there is some&nbsp;exploratory w=
ork=20
    going on.&nbsp; The first items listed above are doable.&nbsp; The last=
 one=20
    is more questionable.&nbsp; There is also the possibility that you can=
=20
    unlock your device even if it is locked down if you find yourself in th=
at=20
    situation.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff=20
    size=3D2></FONT></SPAN>&nbsp;</DIV>
    <DIV><SPAN><FONT face=3D"Courier New" color=3D#0000ff size=3D2>So, shor=
t story is=20
    there is not Smartphone support, but you may wish to check back in abou=
t a=20
    month or so.</FONT></SPAN></DIV>
    <BLOCKQUOTE=20
    style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(0,0,255)=
 2px solid; MARGIN-RIGHT: 0px">
      <DIV></DIV>
      <DIV lang=3Den-us dir=3Dltr align=3Dleft><FONT face=3DTahoma size=3D2=
>-----Original=20
      Message-----<BR><B>From:</B> <A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:openvpn-devel-bounces@lists.sourceforge.net"=20
      target=3D_blank>openvpn-devel-bounces@lists.sourceforge.net</A> [mail=
to:<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:openvpn-devel-bounces@lists.sourceforge.net"=20
      target=3D_blank>openvpn-devel-bounces@lists.sourceforge.net</A>] <B>O=
n=20
      Behalf Of </B>Sameh Attia<BR><B>Sent:</B> Thursday, June 22, 2006 6:4=
6=20
      AM<BR><B>To:</B> <A onclick=3D"return top.js.OpenExtLink(window,event=
,this)"=20
      href=3D"mailto:openvpn-devel@lists.sourceforge.net"=20
      target=3D_blank>openvpn-devel@lists.sourceforge.net</A><BR><B>Subject=
:</B>=20
      [Openvpn-devel] i-mate SP5 &amp;=20
      OpenVPN<BR><BR></FONT></DIV>Hi,<BR>&nbsp;&nbsp; I bought this phone <=
A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://www.imate.com/t-DETAILS_SP5.aspx"=20
      target=3D_blank>http://www.imate.com/t-DETAILS_SP5.aspx</A> after che=
cking=20
      your site to make sure it is supported. Unfortunately, when I attempt=
ed to=20
      install the client I got the error message of something like=20
      'unsuccessfull installation ....unsupported device'. <BR><BR>I checke=
d the=20
      forum to see if there are any workarounds but no avail. Is the Window=
s=20
      Mobile 5.0 Smart Phone Edition different from the Windows Mobile=20
      5.0?<BR>Please help.<BR>Regards<BR></BLOCKQUOTE></DIV></DIV><BR=20
  clear=3Dall></BLOCKQUOTE></DIV><BR><BR clear=3Dall><BR>-- <BR>Sameh=20
  Attia<BR>Information Security Manager<BR>Red Hat Certified Engineer<BR>TE=
=20
  Data<BR>--<BR>The two basic principles of Windows system administration:=
=20
  <BR><BR>&nbsp;&nbsp; * For minor problems, reboot<BR>&nbsp;&nbsp; * For m=
ajor=20
  problems, reinstall<BR><BR>dc -e=20
  '603178305900664311156641389051003470569569613466992253686426210705237258=
P'=20
</BLOCKQUOTE></BODY></HTML>

------=_NextPart_001_0009_01C69610.5D2A6360--

------=_NextPart_000_0008_01C69610.5D2A6360
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIORjCCBHAw
ggNYoAMCAQICEB+0zZj6uUmxQ2K5VZ1P12EwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMDUwNjA3
MDgwOTEwWhcNMTkwNzA5MTczNjU4WjBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3Qg
QUIxHTAbBgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBDbGFz
cyAxIENBIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWltQhSWDia+hBBwze
xODcEyPNwTXH+9ZOEQpnXvUGW2ulCDtbKRY654eyNAbFvAWlA3yCyykQruGIgb3WntP+LVbBFc7j
Jp0VLhD7Bo8wBN6ntGO0/7Gcrjyvd7ZWxbWroulpOj0OM3kyP3CCkplhbY0wCI9xP6ZIVxn4JdxL
ZlyldI+Yrsj5wAYi56xz36Uu+1LcsRVlIPo1Zmne3yzxbrww2ywkEtvrNTVokMsAsJchPXQhI2U0
K7t4WaPW4XY5mqRJjox0r26kmqPZm9I4XJuiGMx1I4S+6+JNM3GOGvDC+Mcdoq0Dlyz4zyXG9rgk
MbFjXZJ/Y/AlyVMuH79NAgMBAAGjgdEwgc4wHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4E
bn0wHQYDVR0OBBYEFJWxtPCUtr3H2tERCSG+wa9J/RB7MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGCWCGSAGG+EIBAQQEAwIAATBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWls
LmNybDANBgkqhkiG9w0BAQUFAAOCAQEAaenDt4Gwt0ps0AgcIC5PrbDFLtmGHU116Z2Ok+MEWh9p
Lgv/mvP50iMHmRqHMGGiIngTqsioHxNL64GxQF6EfG7tEpPCUr6dj4iW4XZvYFF0nT7/3AoLtP27
1e7/k+Dh7/LJxMN9flJEjrQZF5vTiDM1G5g5EMXVLk31lpzXfbxMV6X2iD9BrSNLmk7bZ69/EsDz
W7Y44lu6XPYCWRWdZAuSfoopDa0AdQxf1MzGzSfdlSTlOEV9Y81qezrb2rXVR4y3DQPhCxjzImQo
KXoyoBzj+hY78e3nhaNU4eI8IfyjqXjrzFTM9B8aFinNgbqmbMWOnmDn/WFJQN50NCXR9TCCBKIw
ggOKoAMCAQICEES+DItQACS0EdM2JSVnyYkwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNOTkwNzA5
MTcyODUwWhcNMTkwNzA5MTczNjU4WjCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYD
VQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYD
VQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALI5haTyfatBO2JGN67NwWB1vDll+UoaR6K5zEjMapjVTTUZuaRC5c5J4oovHnzSMQfHTrSD
ZJ0uKdWiZMSFvYVRNXmkTmiQexx6pJKoF/KYFfKTzMmkMpW7DE8wvZigC4vlbhuiRvp4vKJvq1le
pS/Pytptqi/rrKGzaqq3Lmc1i3nhHmmI4uZGzaCl6r4LznY6eg6b6vzaJ1s9cx8i5khhxkzzabGo
Lhu21DEgLLyCio6kDqXXiUP8FlqvHXHXEVnauocNr/rz4cLwpMVnjNbWVDreCqS6A3ezZcj9HtN0
YqoYymiTHqGFfvVHZcv4TVcodNI0/zC27vZiMBSMLOsCAwEAAaOBuTCBtjALBgNVHQ8EBAMCAcYw
DwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUiYJnfcSdJnAAS7RQSHzePa4Ebn0wWAYDVR0fBFEw
TzBNoEugSYZHaHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0
aGVudGljYXRpb25hbmRFbWFpbC5jcmwwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0G
CSqGSIb3DQEBBQUAA4IBAQCxbWFdphp/fKtK5DD8U28lJMbK7eIxXCsO7u5hVW8EPs853sUbSZTk
6yBMtOaeUC5y2Y31qqOzStpWHGCXgNyCoq1KvYor/wsJtMbXIARF5M2AAbq6K27OqteS/uSv6/Qm
HRYqf2wwlTcvMxKsf93H0RGMUZiy0KOR0K32n56Dkx4dQrhGr2tm8Jt/6uMDAuUCUcGq1TWdckAD
iboxHcUQaFKe36KFxVwIpnjmU0+x6LfTFJ6TpsNk46x+cc28n+kDG8z76awxwa98FXQCmcOyR6bC
MmHXx29IJFEnodWHVfJ7j5g9Fp7udbb40I7y88auKFun8PM2F/zDBdPKA0pUMIIFKDCCBBCgAwIB
AgIRAMG8RE3S9dJ/og75uCywV7UwDQYJKoZIhvcNAQEFBQAwZTELMAkGA1UEBhMCU0UxFDASBgNV
BAoTC0FkZFRydXN0IEFCMR0wGwYDVQQLExRBZGRUcnVzdCBUVFAgTmV0d29yazEhMB8GA1UEAxMY
QWRkVHJ1c3QgQ2xhc3MgMSBDQSBSb290MB4XDTA2MDQwNDAwMDAwMFoXDTA3MDQwNDIzNTk1OVow
gdoxNTAzBgNVBAsTLENvbW9kbyBUcnVzdCBOZXR3b3JrIC0gUEVSU09OQSBOT1QgVkFMSURBVEVE
MUYwRAYDVQQLEz1UZXJtcyBhbmQgQ29uZGl0aW9ucyBvZiB1c2U6IGh0dHA6Ly93d3cuY29tb2Rv
Lm5ldC9yZXBvc2l0b3J5MR8wHQYDVQQLExYoYykyMDAzIENvbW9kbyBMaW1pdGVkMRUwEwYDVQQD
EwxEYXZpZCBMZW1sZXkxITAfBgkqhkiG9w0BCQEWEmRldkB6aWdndXJhdDI5LmNvbTCBnzANBgkq
hkiG9w0BAQEFAAOBjQAwgYkCgYEAtrXbIaDGSLg2sPMFfJva/5mxeVed9ru1+qRM7L/uY+Uc/wII
DqDVQlk9SQHTzMS8QPNelPvPeM9tucHou9QVsLVdbtslheWVmOUWlZxs2QWHMn4jatSni0xdQ3oN
F1D99+ZRoGdoWhmA437/jKa7c66T8Il4weagkjp3sc+6cH8CAwEAAaOCAd8wggHbMB0GA1UdDgQW
BBTHFuRlq1bxmiJjz6BFhcl7iRWVhDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNV
HSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/
MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5u
ZXQvQ1BTMHcGA1UdHwRwMG4wNqA0oDKGMGh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FkZFRydXN0
Q2xhc3MxQ0FSb290LmNybDA0oDKgMIYuaHR0cDovL2NybC5jb21vZG8ubmV0L0FkZFRydXN0Q2xh
c3MxQ0FSb290LmNybDCBhgYIKwYBBQUHAQEEejB4MDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNv
bW9kb2NhLmNvbS9BZGRUcnVzdFVUTkNsaWVudENBLmNydDA5BggrBgEFBQcwAoYtaHR0cDovL2Ny
dC5jb21vZG8ubmV0L0FkZFRydXN0VVROQ2xpZW50Q0EuY3J0MB0GA1UdEQQWMBSBEmRldkB6aWdn
dXJhdDI5LmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAX0YHky/KnTJyfx744x0g3UMjkRBbLShe37oD
VAJXUgICeJZlvdO50qM/Wr7AFNM+mdN0WZBbnH4vtGgULvJqHPUCvmEy/LKPZt8DH0hmiSH2naUl
h7NVvqvv4qIr+WTStb/huyALe2AgnFzV5eOOQHsXK3yo3puXzw1vGlhvN2bj7+UJPDdU+D61uQeW
xRND3SBTPGpM0dIDGKyNzbzYN2zVKqw1MHFB79dhTw4ZMmAKbtoL2GiMeugo0DTbh1cFWwNs8Jhw
ONTjqY5I/jSGgTwKxTM5bmuwmhu6MF7X0bc/7hGoh46PjGzQKqMg7jIO0p27ilrFfCuvkXSVhYHw
nDGCAwQwggMAAgEBMHowZTELMAkGA1UEBhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMR0wGwYD
VQQLExRBZGRUcnVzdCBUVFAgTmV0d29yazEhMB8GA1UEAxMYQWRkVHJ1c3QgQ2xhc3MgMSBDQSBS
b290AhEAwbxETdL10n+iDvm4LLBXtTAJBgUrDgMCGgUAoIIB4DAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNjA2MjIyMDI3MjVaMCMGCSqGSIb3DQEJBDEWBBRqbIfY
YNFbttk1eiMrckNgGoGOpDBnBgkqhkiG9w0BCQ8xWjBYMAoGCCqGSIb3DQMHMAcGBSsOAwIaMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAKBggq
hkiG9w0CBTCBiQYJKwYBBAGCNxAEMXwwejBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1
c3QgQUIxHTAbBgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBD
bGFzcyAxIENBIFJvb3QCEQDBvERN0vXSf6IO+bgssFe1MIGLBgsqhkiG9w0BCRACCzF8oHowZTEL
MAkGA1UEBhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMR0wGwYDVQQLExRBZGRUcnVzdCBUVFAg
TmV0d29yazEhMB8GA1UEAxMYQWRkVHJ1c3QgQ2xhc3MgMSBDQSBSb290AhEAwbxETdL10n+iDvm4
LLBXtTANBgkqhkiG9w0BAQEFAASBgD35ILmrRT4/i2wRtYsoKmxyl0G6C++zGfh7OWhaTthiaj76
BwCPLKJl3EhAcC+wnK4/slADeRVpN5kKwVZZYy1Re587v9sRNmQBAZj9KORsZ9Z6wXdhBzzOU4fP
vLKrvvYfVOLq/qSA+gJRsAAG8L4A4VxfEb1tE+Ip7D01NYqWAAAAAAAA

------=_NextPart_000_0008_01C69610.5D2A6360--


