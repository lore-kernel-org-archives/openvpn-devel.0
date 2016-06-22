MIME-Version: 1.0
In-Reply-To: <1466615164-15527-3-git-send-email-samuli@...515...>
References: <1466615164-15527-1-git-send-email-samuli@...515...>
	<1466615164-15527-3-git-send-email-samuli@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 22 Jun 2016 22:11:39 +0500
Message-ID: <CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
Content-Type: multipart/alternative; boundary=001a114450d8ee4b050535e107cf
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

--001a114450d8ee4b050535e107cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

why "must" for windows 10 ?

2016-06-22 22:06 GMT+05:00 <samuli@...515...>:

> From: Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> ---
>  INSTALL | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index 42f78d8..334d0e6 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:
>
>      http://www.whiteboard.ne.jp/~admin2/tuntap/
>
> -* Windows XP/2003/Vista/7:
> +* Windows
>
>    OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN
> installers
>    include this driver, so installing it separately is not usually
> required.
> -  The driver source code is available here:
> -
> -    https://github.com/OpenVPN/tap-windows
> +  Windows XP/2003 must use the NDIS 5 (tap-windows) driver, whereas more
> recent
> +  Windows versions should (Vista to 8.1) or must (Windows 10) use the
> NDIS 6
> +  driver (tap-windows6) instead.
>
>  *************************************************************************
>
> --
> 2.1.4
>
>
>
> -------------------------------------------------------------------------=
-----
> Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
> Francisco, CA to explore cutting-edge tech and listen to tech luminaries
> present their vision of the future. This family event has something for
> everyone, including kids. Get more information and register today.
> http://sdm.link/attshape
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114450d8ee4b050535e107cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">why &quot;must&quot; for windows 10 ?<br></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-06-22 22:06 GMT+05:00 =
 <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank=
">samuli@...515...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: =
Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">samuli@...2092...=
..</a>&gt;<br>
<br>
Signed-off-by: Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515..."=
>samuli@...515...</a>&gt;<br>
---<br>
=C2=A0INSTALL | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/INSTALL b/INSTALL<br>
index 42f78d8..334d0e6 100644<br>
--- a/INSTALL<br>
+++ b/INSTALL<br>
@@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:<br>
<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.whiteboard.ne.jp/~admin2/tuntap/"=
 rel=3D"noreferrer" target=3D"_blank">http://www.whiteboard.ne.jp/~admin2/t=
untap/</a><br>
<br>
-* Windows XP/2003/Vista/7:<br>
+* Windows<br>
<br>
=C2=A0 =C2=A0OpenVPN on Windows needs a TUN/TAP kernel driver to work. Open=
VPN installers<br>
=C2=A0 =C2=A0include this driver, so installing it separately is not usuall=
y required.<br>
-=C2=A0 The driver source code is available here:<br>
-<br>
-=C2=A0 =C2=A0 <a href=3D"https://github.com/OpenVPN/tap-windows" rel=3D"no=
referrer" target=3D"_blank">https://github.com/OpenVPN/tap-windows</a><br>
+=C2=A0 Windows XP/2003 must use the NDIS 5 (tap-windows) driver, whereas m=
ore recent<br>
+=C2=A0 Windows versions should (Vista to 8.1) or must (Windows 10) use the=
 NDIS 6<br>
+=C2=A0 driver (tap-windows6) instead.<br>
<br>
=C2=A0*********************************************************************=
****<br>
<br>
--<br>
2.1.4<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Attend Shape: An AT&amp;T Tech Expo July 15-16. Meet us at AT&amp;T Park in=
 San<br>
Francisco, CA to explore cutting-edge tech and listen to tech luminaries<br>
present their vision of the future. This family event has something for<br>
everyone, including kids. Get more information and register today.<br>
<a href=3D"http://sdm.link/attshape" rel=3D"noreferrer" target=3D"_blank">h=
ttp://sdm.link/attshape</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br></div>

--001a114450d8ee4b050535e107cf--

