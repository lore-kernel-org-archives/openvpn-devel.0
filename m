MIME-Version: 1.0
In-Reply-To: <576B9C82.6050209@...2080...>
References: <1466615164-15527-1-git-send-email-samuli@...515...>
	<1466615164-15527-3-git-send-email-samuli@...515...>
	<CAFHpkQEvabwhSHjmA1c_bQk=sh8OiHWqMpc-MujZuvR8GGKowA@...278...>
	<60375091-e617-d87c-bda3-c9bcab78eb02@...515...>
	<CAFHpkQEYAKVACJuRj2+G2SHRWpc7DKCR3v+-__k13BW7=-f0PA@...278...>
	<576B9C82.6050209@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 23 Jun 2016 13:29:07 +0500
Message-ID: <CAFHpkQGt2SAW4epgP0b1N+d1Q=1Kqm2+Ykgt1JVPr5xd1RQ=og@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0d48cc08de090535edd964
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0d48cc08de090535edd964
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

we still use NDIS5, however we observe some issues with Windows 10.
sometimes (currently just 3 users) see messages regarding "tap adapter not
ready" in logs. And issue is resolved by upgrading to NDIS6.

it is not clear evidence that NDIS5 does not work well on Win10 (it works
for 800 users and does not work for 3 of them), but it is definetly a sign
to start upgrading.

2016-06-23 13:23 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 22/06/16 19:19, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > we use ndis5 on windows 10.
>
> If the rumours I've heard are right, NDIS5 support will disappear in
> some Windows updates.  The very first rumours was that it would
> disappear in Win 8.2 (whatever that version ended up as), but Microsoft
> might have delayed the deprecation a bit longer.
>
> On a more general note, please use the NDIS6 (tap6) driver instead, as
> that is what gets most of the attention these days and it does need far
> more testing.  We really do want the old NDIS5 drive to die.  My opinion
> is that once OpenVPN 2.4 will be released, we should stop shipping the
> NDIS5 driver when git master begins to target for
> OpenVPN 2.5.
>
>
> --
> kind regards,
>
> David Sommerseth
>
>
> > 2016-06-22 22:14 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> > <mailto:samuli@...515...>>:
> >
> >     I have not actually tested tap-windows (NDIS 5) on Windows 10, but I
> >     believe NDIS 5 support was removed from Windows 10 a while back. If
> >     NDIS 5 drivers still work for Windows 10 then I can definitely
> >     reword this part.
> >
> >         why "must" for windows 10 ?
> >
> >         2016-06-22 22:06 GMT+05:00 <samuli@...515...
> >         <mailto:samuli@...515...> <mailto:samuli@...515...
> >         <mailto:samuli@...515...>>>:
> >
> >             From: Samuli Sepp=C3=A4nen <samuli@...515...
> >         <mailto:samuli@...515...> <mailto:samuli@...515...
> >         <mailto:samuli@...515...>>>
> >
> >             Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...
> >         <mailto:samuli@...515...>
> >             <mailto:samuli@...515... <mailto:samuli@...515...>>>
> >
> >             ---
> >              INSTALL | 8 ++++----
> >              1 file changed, 4 insertions(+), 4 deletions(-)
> >
> >             diff --git a/INSTALL b/INSTALL
> >             index 42f78d8..334d0e6 100644
> >             --- a/INSTALL
> >             +++ b/INSTALL
> >             @@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:
> >
> >                  http://www.whiteboard.ne.jp/~admin2/tuntap/
> >
> >             -* Windows XP/2003/Vista/7:
> >             +* Windows
> >
> >                OpenVPN on Windows needs a TUN/TAP kernel driver to work.
> >         OpenVPN
> >             installers
> >                include this driver, so installing it separately is not
> >         usually
> >             required.
> >             -  The driver source code is available here:
> >             -
> >             -    https://github.com/OpenVPN/tap-windows
> >             +  Windows XP/2003 must use the NDIS 5 (tap-windows) driver,
> >         whereas
> >             more recent
> >             +  Windows versions should (Vista to 8.1) or must (Windows
> >         10) use
> >             the NDIS 6
> >             +  driver (tap-windows6) instead.
> >
> >
> >
> *************************************************************************
> >
> >             --
> >             2.1.4
> >
>
>
>

--94eb2c0d48cc08de090535edd964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>we still use NDIS5, however we observe some issues wi=
th Windows 10. sometimes (currently just 3 users) see messages regarding &q=
uot;tap adapter not ready&quot; in logs. And issue is resolved by upgrading=
 to NDIS6.<br><br></div>it is not clear evidence that NDIS5 does not work w=
ell on Win10 (it works for 800 users and does not work for 3 of them), but =
it is definetly a sign to start upgrading.<br></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">2016-06-23 13:23 GMT+05:00 David Sommers=
eth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_=
blank">openvpn@...2080...</a>&gt;</span>:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><span class=3D"">On 22/06/16 19:19, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt; we use ndis5 on windows 10.<br>
<br>
</span>If the rumours I&#39;ve heard are right, NDIS5 support will disappea=
r in<br>
some Windows updates.=C2=A0 The very first rumours was that it would<br>
disappear in Win 8.2 (whatever that version ended up as), but Microsoft<br>
might have delayed the deprecation a bit longer.<br>
<br>
On a more general note, please use the NDIS6 (tap6) driver instead, as<br>
that is what gets most of the attention these days and it does need far<br>
more testing.=C2=A0 We really do want the old NDIS5 drive to die.=C2=A0 My =
opinion<br>
is that once OpenVPN 2.4 will be released, we should stop shipping the<br>
NDIS5 driver when git master begins to target for<br>
OpenVPN 2.5.<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
<span class=3D""><br>
<br>
&gt; 2016-06-22 22:14 GMT+05:00 Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:=
samuli@...515...">samuli@...515...</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:samuli@...515...">samuli@...515...=
</a>&gt;&gt;:<br>
<span class=3D"">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I have not actually tested tap-windows (NDIS 5) on =
Windows 10, but I<br>
&gt;=C2=A0 =C2=A0 =C2=A0believe NDIS 5 support was removed from Windows 10 =
a while back. If<br>
&gt;=C2=A0 =C2=A0 =C2=A0NDIS 5 drivers still work for Windows 10 then I can=
 definitely<br>
&gt;=C2=A0 =C2=A0 =C2=A0reword this part.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0why &quot;must&quot; for windows 10 ?=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02016-06-22 22:06 GMT+05:00 &lt;<a hre=
f=3D"mailto:samuli@...515...">samuli@...515...</a><br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:s=
amuli@...515...">samuli@...515...</a>&gt; &lt;mailto:<a href=3D"mailto:samu=
li@...515...">samuli@...515...</a><br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=
=3D"mailto:samuli@...515...">samuli@...515...</a>&gt;&gt;&gt;:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0From: Samuli Sepp=C3=A4=
nen &lt;<a href=3D"mailto:samuli@...515...">samuli@...515...</a><br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:s=
amuli@...515...">samuli@...515...</a>&gt; &lt;mailto:<a href=3D"mailto:samu=
li@...515...">samuli@...515...</a><br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=
=3D"mailto:samuli@...515...">samuli@...515...</a>&gt;&gt;&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Samuli S=
epp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">samuli@...515...</a><b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:samuli@...220...=
..515...">samuli@...515...</a>&gt;<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a hr=
ef=3D"mailto:samuli@...515...">samuli@...515...</a> &lt;mailto:<a href=3D"m=
ailto:samuli@...515...">samuli@...515...</a>&gt;&gt;&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INSTALL | 8 ++++----<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 file changed, 4 inse=
rtions(+), 4 deletions(-)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/INSTALL b/=
INSTALL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index 42f78d8..334d0e6 =
100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/INSTALL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/INSTALL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -298,13 +298,13 @@ T=
UN/TAP Driver Configuration:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=
=3D"http://www.whiteboard.ne.jp/~admin2/tuntap/" rel=3D"noreferrer" target=
=3D"_blank">http://www.whiteboard.ne.jp/~admin2/tuntap/</a><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-* Windows XP/2003/Vist=
a/7:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+* Windows<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenVPN on Wind=
ows needs a TUN/TAP kernel driver to work.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenVPN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0installers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 include this dr=
iver, so installing it separately is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usually<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=C2=A0 The driver sour=
ce code is available here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 <a href=
=3D"https://github.com/OpenVPN/tap-windows" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/OpenVPN/tap-windows</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 Windows XP/2003=
 must use the NDIS 5 (tap-windows) driver,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0whereas<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0more recent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 Windows version=
s should (Vista to 8.1) or must (Windows<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010) use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the NDIS 6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 driver (tap-win=
dows6) instead.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ************************************=
*************************************<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02.1.4<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br></div>

--94eb2c0d48cc08de090535edd964--

