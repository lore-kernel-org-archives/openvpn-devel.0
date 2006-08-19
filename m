From: "Dave" <dev@...575...>
Date: Fri, 18 Aug 2006 23:28:24 -0500
MIME-Version: 1.0
Message-ID: <000701c6c347$eb982970$16ada8c0@...576...>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0000_01C6C31D.FEE70A20"
In-Reply-To: <9a2102ba0608160040i3f2c8c4aya8f4e2ff7b769c92@...278...>
Subject: Re: [Openvpn-devel] hello,
	everyone.i have a question about tap-win32 driver, thinks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Jon' <comepu@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C6C31D.FEE70A20
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0001_01C6C31D.FEE70A20"

------=_NextPart_001_0001_01C6C31D.FEE70A20
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit



-----Original Message-----
From: openvpn-devel-bounces@lists.sourceforge.net
[mailto:openvpn-devel-bounces@lists.sourceforge.net] On Behalf Of Jon
Sent: Wednesday, August 16, 2006 2:40 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] hello,everyone.i have a question about tap-win32
driver, thinks



I am reading tap-win32/tapdrvr.c code. I found in DriverEntry function，
before call NdisMRegisterMiniport, have two lines:
  l_Properties->TransferDataHandler = AdapterReceive;      /*
DISPATCH_LEVEL */
  l_Properties->SendHandler = AdapterTransmit;             /*
DISPATCH_LEVEL */

But I found AdapterReceive function have nothing, AdapterTransmit function
recv data from  network card。
i can't understand. Who send data in this driver?
thinks
--
It is the tears of the earth that keep here smiles in bloom.

Dont forget:

The top-edge of the Win32 TAP driver connects (though NDIS) to the TCP/IP
stack.  The bottom-edge would normally talk to hardware sending data over
the wire, but instead it goes to a queue which another app, through api
calls, will pick up (namely openvpn) and send out via it's own mechanism.
Bearing that in mind....

AdapterTransmit does indeed do something with the packet.  Instead of
sending it to hardware, it checks for any pending read requests that
openvpn.exe had queued and satisfies them.  This happens around the
comment:

    // Cycle through IRPs and packets, try to satisfy each pending
    // IRP with a queued packet.

OK, that takes care of one direction of data flow (from application X,
through network stack, to tap driver, and on to openvpn).  Then there's
the reverse direction (from openvpn, to tap driver, up network stack, and
on to application X)....

AdapterReceive is for a different purpose than you might think, and is
required to exist by NDIS, but is not used and so is stubbed.  Check out
msdn if you're more curious about the detail.

Transmitting occurs in a slightly less obvious place.  In the function
TapDeviceHook(), at the case IRP_MJ_WRITE, the packet is sent up the
network stack via the calls NdisMEthIndicateReceive() and
NdisMEthIndicateReceiveComplete().

The TAP device is sort of two devices in one:  An NDIS miniport, and also
a typical custom device that you can open and do ReadFile() and
WriteFile() with.  The network stack uses the former interface, and
openvpn.exe uses the later.

-Dave


------=_NextPart_001_0001_01C6C31D.FEE70A20
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-2022-=
jp">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B>=20
  openvpn-devel-bounces@lists.sourceforge.net=20
  [mailto:openvpn-devel-bounces@lists.sourceforge.net] <B>On Behalf Of=20
  </B>Jon<BR><B>Sent:</B> Wednesday, August 16, 2006 2:40 AM<BR><B>To:</B>=
=20
  openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> [Openvpn-devel]=20
  hello,everyone.i have a question about tap-win32 driver,=20
  thinks<BR><BR></FONT></DIV>
  <DIV><BR clear=3Dall>I am reading tap-win32/tapdrvr.c code. I found in=20
  DriverEntry function=1B$B!$=1B(Bbefore call NdisMRegisterMiniport, have t=
wo=20
  lines:<BR>&nbsp; l_Properties-&gt;TransferDataHandler =3D=20
  AdapterReceive;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DISPATCH_LEVEL */ <BR>&n=
bsp;=20
  l_Properties-&gt;SendHandler =3D=20
  AdapterTransmit;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
  /* DISPATCH_LEVEL */<BR><BR>But I found AdapterReceive function have noth=
ing,=20
  AdapterTransmit function recv data from&nbsp; network card=1B$B!#=1B(B<BR=
>i can't=20
  understand. Who send data in this driver? <BR>thinks<BR>-- <BR>It is the =
tears=20
  of the earth that keep here smiles in bloom.&nbsp;<SPAN=20
  class=3D284492704-19082006><FONT face=3D"Courier New" color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN></DIV></BLOCKQUOTE>
<DIV><SPAN class=3D284492704-19082006>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Dont forget:</FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>The top-edge of the Win32 TAP driver connects (though NDIS) to the=
 TCP/IP=20
stack.&nbsp; The bottom-edge would normally talk to hardware sending data o=
ver=20
the wire, but instead it goes to a queue which another app, through api cal=
ls,=20
will pick up (namely openvpn) and send out via it's own mechanism.&nbsp; Be=
aring=20
that in mind....</FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>AdapterTransmit does indeed do something with the packet.&nbsp; In=
stead=20
of sending it to hardware, it checks for any pending read requests that=20
openvpn.exe had queued and satisfies them.&nbsp; This happens around the=20
comment:</FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>&nbsp;&nbsp;&nbsp; // Cycle through IRPs and packets, try to satis=
fy each=20
pending<BR>&nbsp;&nbsp;&nbsp; // IRP with a queued=20
packet.<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>OK, that takes care of one direction of data flow (from applicatio=
n X,=20
through network stack, to tap driver, and on to openvpn).&nbsp; Then there'=
s the=20
reverse direction (from openvpn, to tap driver, up network stack, and on to=
=20
application X)....</DIV></FONT></SPAN>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>AdapterReceive is for a different purpose than you might think, an=
d is=20
required to exist by NDIS, but is not used and so is stubbed.&nbsp; Check o=
ut=20
msdn if you're more curious about the detail.</FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Transmitting occurs in a slightly less obvious place.&nbsp; In the=
=20
function TapDeviceHook(), at the case </FONT></SPAN><SPAN=20
class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0000ff=20
size=3D2>IRP_MJ_WRITE, the packet is sent up the network stack via the call=
s=20
NdisMEthIndicateReceive() and=20
NdisMEthIndicateReceiveComplete().</FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>The TAP device is sort of two devices in one:&nbsp; An NDIS minipo=
rt, and=20
also a typical custom device that you can open and do ReadFile() and WriteF=
ile()=20
with.&nbsp; The network stack uses the former interface, and openvpn.exe us=
es=20
the later.</FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New"><FONT=20
color=3D#0000ff><FONT size=3D2>-Dave<SPAN=20
class=3D284492704-19082006>&nbsp;</SPAN></FONT></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D767561204-19082006><FONT face=3D"Courier New"><FONT=20
color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D284492704-19082006>&nbsp;</SPAN></FONT></FONT></FONT></SPAN>&nbsp;<=
/SPAN></DIV></DIV></BODY></HTML>

------=_NextPart_001_0001_01C6C31D.FEE70A20--

------=_NextPart_000_0000_01C6C31D.FEE70A20
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNjA4MTkwNDI4MjJaMCMGCSqGSIb3DQEJBDEWBBQOrBym
aWhDW/XpisPqHn/Fx3ZsVjBnBgkqhkiG9w0BCQ8xWjBYMAoGCCqGSIb3DQMHMAcGBSsOAwIaMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAKBggq
hkiG9w0CBTCBiQYJKwYBBAGCNxAEMXwwejBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1
c3QgQUIxHTAbBgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBD
bGFzcyAxIENBIFJvb3QCEQDBvERN0vXSf6IO+bgssFe1MIGLBgsqhkiG9w0BCRACCzF8oHowZTEL
MAkGA1UEBhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMR0wGwYDVQQLExRBZGRUcnVzdCBUVFAg
TmV0d29yazEhMB8GA1UEAxMYQWRkVHJ1c3QgQ2xhc3MgMSBDQSBSb290AhEAwbxETdL10n+iDvm4
LLBXtTANBgkqhkiG9w0BAQEFAASBgI/3yftAB3inek4i3qW0qEfgf1ImYGKCYm9onIymCV/n6XR2
LFheffFE9/a1ReSjGWHSKgyUpWQZUlpEBpkCW90SpOVoOm7gZESbW4hw8XPojH/g1ddCiNEpG0a9
ruAuXHlOOn1rvwhemPbMERytOwE2aMm3Jbmlp1SmgnqSYaJYAAAAAAAA

------=_NextPart_000_0000_01C6C31D.FEE70A20--


