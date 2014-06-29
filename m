MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 29 Jun 2014 12:09:01 -0400
Message-ID: <CAEsd45Q1Ow+pasP0FhtJEkV-WW-yFA4dfKzx6QEKgnJf+m5Dtg@...278...>
Content-Type: multipart/alternative; boundary=047d7b342eac2f4e2f04fcfbc5f5
Subject: [Openvpn-devel] Recently-disclosed LZO vulnerability and OpenVPN's
	use of LZO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b342eac2f4e2f04fcfbc5f5
Content-Type: text/plain; charset=UTF-8

A recent *"Lab Mouse Security research blog" entry*
<http://blog.securitymouse.com/2014/06/raising-lazarus-20-year-old-bug-that.html>
claimed
that a bug exists in several implementations of the LZO algorithm commonly
used by OpenVPN and that the bug causes a security vulnerability.

A rebuttal on the "RealTime Data Compression" blog
<http://fastcompression.blogspot.co.uk/2014/06/lets-move-on.html> points
out that the circumstances required to exploit the vulnerability make
exploitation unlikely. Among other requirements, the rebuttal says that a
problem only happens with block sizes larger than 8MB.

Am I correct to assume that OpenVPN's use of LZO is restricted to much
smaller block sizes? I assume the block sizes that OpenVPN uses LZO for are
limited to the maximum packet size, which would be on the order of 1500
bytes or so (because of MTU size limits).

Or does OpenVPN ever use LZO on larger amounts of data? Is there any
possibility of OpenVPN using LZO on 8MB?

* Also see the discussion on the LZ4 discussion board
<https://code.google.com/p/lz4/issues/detail?id=52>; the vulnerability was
actually discovered by Ludvig Strigeus
<https://en.wikipedia.org/wiki/Ludvig_Strigeus> eighteen months ago.

--047d7b342eac2f4e2f04fcfbc5f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:Arial,Helvetica,sans-serif;font=
-size:13px">A recent=C2=A0</span><a href=3D"http://blog.securitymouse.com/2=
014/06/raising-lazarus-20-year-old-bug-that.html" style=3D"margin:0px;paddi=
ng:0px;border:0px;vertical-align:baseline;text-decoration:none;color:rgb(10=
2,17,204);font-family:Arial,Helvetica,sans-serif;font-size:13px" target=3D"=
_blank"><u>&quot;Lab Mouse Security research blog&quot; entry</u></a><font =
face=3D"Arial, Helvetica, sans-serif">=C2=A0claimed that a bug exists in se=
veral implementations of the LZO algorithm commonly used by OpenVPN and tha=
t the bug causes a security vulnerability.</font><div>

<font face=3D"Arial, Helvetica, sans-serif"><br></font></div><div><font fac=
e=3D"Arial, Helvetica, sans-serif">A=C2=A0<a href=3D"http://fastcompression=
.blogspot.co.uk/2014/06/lets-move-on.html">rebuttal on the &quot;RealTime D=
ata Compression&quot; blog</a>=C2=A0points out that the </font><font face=
=3D"Arial, Helvetica, sans-serif">circumstances required to exploit the vul=
nerability make exploitation unlikely. Among other requirements,=C2=A0</fon=
t><span style=3D"font-size:13px;font-family:Arial,Helvetica,sans-serif">the=
 rebuttal says that a problem only happens with block sizes larger than 8MB=
.</span></div>

<div><div style=3D"margin:0px;padding:0px;border:0px;vertical-align:baselin=
e;font-family:Arial,Helvetica,sans-serif;font-size:13px">
<br></div><div style=3D"margin:0px;padding:0px;border:0px;vertical-align:ba=
seline;font-family:Arial,Helvetica,sans-serif;font-size:13px">Am I correct =
to assume that OpenVPN&#39;s use of LZO is restricted to much smaller block=
 sizes? I assume the block sizes that OpenVPN uses LZO for are limited to t=
he maximum packet size, which would be on the order of 1500 bytes or so (be=
cause of MTU size limits).</div>

<div style=3D"margin:0px;padding:0px;border:0px;vertical-align:baseline;fon=
t-family:Arial,Helvetica,sans-serif;font-size:13px"><br></div><div style=3D=
"margin:0px;padding:0px;border:0px;vertical-align:baseline;font-family:Aria=
l,Helvetica,sans-serif;font-size:13px">

Or does OpenVPN ever use LZO on larger amounts of data? Is there any possib=
ility of OpenVPN using LZO on 8MB?</div><div style=3D"margin:0px;padding:0p=
x;border:0px;vertical-align:baseline;font-family:Arial,Helvetica,sans-serif=
;font-size:13px">

<br></div><div style=3D"margin:0px;padding:0px;border:0px;vertical-align:ba=
seline;font-family:Arial,Helvetica,sans-serif;font-size:13px">* Also see th=
e=C2=A0<a href=3D"https://code.google.com/p/lz4/issues/detail?id=3D52">disc=
ussion on the LZ4 discussion board</a>; the=C2=A0<font face=3D"Arial, Helve=
tica, sans-serif" style=3D"font-size:small">vulnerability was actually disc=
overed by=C2=A0</font><font color=3D"#000000" style=3D"font-family:arial;fo=
nt-size:small"><span style=3D"font-size:12px;white-space:pre-wrap"><a href=
=3D"https://en.wikipedia.org/wiki/Ludvig_Strigeus">Ludvig Strigeus</a></spa=
n></font><font face=3D"Arial, Helvetica, sans-serif" style=3D"font-size:sma=
ll">=C2=A0eighteen months ago</font>.<br>

</div></div></div>

--047d7b342eac2f4e2f04fcfbc5f5--

