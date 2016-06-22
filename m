MIME-Version: 1.0
In-Reply-To: <60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
References: <1466615164-15527-1-git-send-email-samuli@...515...>
	<1466615164-15527-3-git-send-email-samuli@...515...>
	<CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
	<60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 22 Jun 2016 22:19:14 +0500
Message-ID: <CAFHpkQEYAKVACJuRj2+G2SHRWpc7DKCR3v+-__k13BW7=-f0PA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0d48cc0d5b450535e123b2
Subject: Re: [Openvpn-devel] [PATCH 3/3] Clarify which Windows versions
 require which TUN/TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0d48cc0d5b450535e123b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

we use ndis5 on windows 10.

2016-06-22 22:14 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> I have not actually tested tap-windows (NDIS 5) on Windows 10, but I
> believe NDIS 5 support was removed from Windows 10 a while back. If NDIS 5
> drivers still work for Windows 10 then I can definitely reword this part.
>
> why "must" for windows 10 ?
>>
>> 2016-06-22 22:06 GMT+05:00 <samuli@...515... <mailto:samuli@...515...
>> >>:
>>
>>     From: Samuli Sepp=C3=A4nen <samuli@...515... <mailto:samuli@...515...
>> >>
>>
>>     Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...
>>     <mailto:samuli@...515...>>
>>
>>     ---
>>      INSTALL | 8 ++++----
>>      1 file changed, 4 insertions(+), 4 deletions(-)
>>
>>     diff --git a/INSTALL b/INSTALL
>>     index 42f78d8..334d0e6 100644
>>     --- a/INSTALL
>>     +++ b/INSTALL
>>     @@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:
>>
>>          http://www.whiteboard.ne.jp/~admin2/tuntap/
>>
>>     -* Windows XP/2003/Vista/7:
>>     +* Windows
>>
>>        OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN
>>     installers
>>        include this driver, so installing it separately is not usually
>>     required.
>>     -  The driver source code is available here:
>>     -
>>     -    https://github.com/OpenVPN/tap-windows
>>     +  Windows XP/2003 must use the NDIS 5 (tap-windows) driver, whereas
>>     more recent
>>     +  Windows versions should (Vista to 8.1) or must (Windows 10) use
>>     the NDIS 6
>>     +  driver (tap-windows6) instead.
>>
>>
>>  ***********************************************************************=
**
>>
>>     --
>>     2.1.4
>>
>>
>>
>> ------------------------------------------------------------------------=
------
>>     Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in
>> San
>>     Francisco, CA to explore cutting-edge tech and listen to tech
>> luminaries
>>     present their vision of the future. This family event has something
>> for
>>     everyone, including kids. Get more information and register today.
>>     http://sdm.link/attshape
>>     _______________________________________________
>>     Openvpn-devel mailing list
>>     Openvpn-devel@lists.sourceforge.net
>>     <mailto:Openvpn-devel@lists.sourceforge.net>
>>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>>
>
>

--94eb2c0d48cc0d5b450535e123b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>we use ndis5 on windows 10.<br></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-06-22 22:14 GMT+05:00 =
Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...2092...=
.." target=3D"_blank">samuli@...515...</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">I have not actually tested tap-windows (NDIS 5) on Windows 10=
, but I believe NDIS 5 support was removed from Windows 10 a while back. If=
 NDIS 5 drivers still work for Windows 10 then I can definitely reword this=
 part.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">
why &quot;must&quot; for windows 10 ?<br>
<br></span>
2016-06-22 22:06 GMT+05:00 &lt;<a href=3D"mailto:samuli@...515..." target=
=3D"_blank">samuli@...515...</a> &lt;mailto:<a href=3D"mailto:samuli@...2146...=
..." target=3D"_blank">samuli@...515...</a>&gt;&gt;:<br>
<br>
=C2=A0 =C2=A0 From: Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...1387...=
5..." target=3D"_blank">samuli@...515...</a> &lt;mailto:<a href=3D"mailto:s=
amuli@...515..." target=3D"_blank">samuli@...515...</a>&gt;&gt;<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:sam=
uli@...515..." target=3D"_blank">samuli@...515...</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:samuli@...515..." target=3D"_bla=
nk">samuli@...515...</a>&gt;&gt;<div><div class=3D"h5"><br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0INSTALL | 8 ++++----<br>
=C2=A0 =C2=A0 =C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
=C2=A0 =C2=A0 diff --git a/INSTALL b/INSTALL<br>
=C2=A0 =C2=A0 index 42f78d8..334d0e6 100644<br>
=C2=A0 =C2=A0 --- a/INSTALL<br>
=C2=A0 =C2=A0 +++ b/INSTALL<br>
=C2=A0 =C2=A0 @@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.whiteboard.ne.jp/~a=
dmin2/tuntap/" rel=3D"noreferrer" target=3D"_blank">http://www.whiteboard.n=
e.jp/~admin2/tuntap/</a><br>
<br>
=C2=A0 =C2=A0 -* Windows XP/2003/Vista/7:<br>
=C2=A0 =C2=A0 +* Windows<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0OpenVPN on Windows needs a TUN/TAP kernel driver=
 to work. OpenVPN<br>
=C2=A0 =C2=A0 installers<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0include this driver, so installing it separately=
 is not usually<br>
=C2=A0 =C2=A0 required.<br>
=C2=A0 =C2=A0 -=C2=A0 The driver source code is available here:<br>
=C2=A0 =C2=A0 -<br>
=C2=A0 =C2=A0 -=C2=A0 =C2=A0 <a href=3D"https://github.com/OpenVPN/tap-wind=
ows" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/tap-wi=
ndows</a><br>
=C2=A0 =C2=A0 +=C2=A0 Windows XP/2003 must use the NDIS 5 (tap-windows) dri=
ver, whereas<br>
=C2=A0 =C2=A0 more recent<br>
=C2=A0 =C2=A0 +=C2=A0 Windows versions should (Vista to 8.1) or must (Windo=
ws 10) use<br>
=C2=A0 =C2=A0 the NDIS 6<br>
=C2=A0 =C2=A0 +=C2=A0 driver (tap-windows6) instead.<br>
<br>
=C2=A0 =C2=A0 =C2=A0*******************************************************=
******************<br>
<br>
=C2=A0 =C2=A0 --<br>
=C2=A0 =C2=A0 2.1.4<br>
<br>
<br>
=C2=A0 =C2=A0 -------------------------------------------------------------=
-----------------<br>
=C2=A0 =C2=A0 Attend Shape: An AT&amp;T Tech Expo July 15-16. Meet us at AT=
&amp;T Park in San<br>
=C2=A0 =C2=A0 Francisco, CA to explore cutting-edge tech and listen to tech=
 luminaries<br>
=C2=A0 =C2=A0 present their vision of the future. This family event has som=
ething for<br>
=C2=A0 =C2=A0 everyone, including kids. Get more information and register t=
oday.<br>
=C2=A0 =C2=A0 <a href=3D"http://sdm.link/attshape" rel=3D"noreferrer" targe=
t=3D"_blank">http://sdm.link/attshape</a><br>
=C2=A0 =C2=A0 _______________________________________________<br>
=C2=A0 =C2=A0 Openvpn-devel mailing list<br>
=C2=A0 =C2=A0 <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=
=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br></div></div>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:Openvpn-devel@...290...=
net" target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a>&gt;<br>
=C2=A0 =C2=A0 <a href=3D"https://lists.sourceforge.net/lists/listinfo/openv=
pn-devel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.ne=
t/lists/listinfo/openvpn-devel</a><br>
<br>
<br>
</blockquote>
<br>
<br>
</blockquote></div><br></div>

--94eb2c0d48cc0d5b450535e123b2--

