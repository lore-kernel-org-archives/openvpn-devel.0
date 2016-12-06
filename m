MIME-Version: 1.0
In-Reply-To: <1481062251-18349-1-git-send-email-davids@...515...>
References: <1481062251-18349-1-git-send-email-davids@...515...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 7 Dec 2016 00:26:13 +0200
Message-ID: <CAGyAFMVfJL2odSLSBZhQZQs0D3V8TjcG1Z9THkuwLsgWOpHTRA@...278...>
Content-Type: multipart/alternative; boundary=001a1148e9265b7d32054304e4d2
Subject: Re: [Openvpn-devel] [PATCH] Fix wrong configure.ac parsing of
	--enable-async-push
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148e9265b7d32054304e4d2
Content-Type: text/plain; charset=UTF-8

ACK from me

Tested with --disable-async-push, #define does not appear.

2016-12-07 0:10 GMT+02:00 David Sommerseth <davids@...515...>:

> AC_ARG_ENABLE() was used wrong, which led enable_async_push to
> always be set, regardless if --enable-async-push or --disable-async-push
> was used.
>
> Also spotted the exact same patch when writing this commit message as
> GitHub PR#70.
>
> Trac: #786
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index f4073d0..c6c5fa9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -267,7 +267,7 @@ AC_ARG_ENABLE(
>  AC_ARG_ENABLE(
>         [async-push],
>         [AS_HELP_STRING([--enable-async-push], [enable async-push support
> @<:@default=no@:>@])],
> -       [enable_async_push="yes"],
> +        ,
>         [enable_async_push="no"]
>  )
>
> --
> 1.8.3.1
>
>
> ------------------------------------------------------------
> ------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today.http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



-- 
-Lev

--001a1148e9265b7d32054304e4d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ACK from me<div><br></div><div>Tested with --disable-async=
-push, #define does not appear.</div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">2016-12-07 0:10 GMT+02:00 David Sommerseth <span =
dir=3D"ltr">&lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">david=
s@...515...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">AC_ARG_ENABLE=
() was used wrong, which led enable_async_push to<br>
always be set, regardless if --enable-async-push or --disable-async-push<br>
was used.<br>
<br>
Also spotted the exact same patch when writing this commit message as<br>
GitHub PR#70.<br>
<br>
Trac: #786<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515...">dav=
ids@...515...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index f4073d0..c6c5fa9 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -267,7 +267,7 @@ AC_ARG_ENABLE(<br>
=C2=A0AC_ARG_ENABLE(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [async-push],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-<wbr>async-push], [en=
able async-push support @&lt;:@default=3Dno@:&gt;@])],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[enable_async_push=3D&quot;yes&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [enable_async_push=3D&quot;no&quot;]<br>
=C2=A0)<br>
<br>
--<br>
1.8.3.1<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today.<a href=3D"http://sdm.link/xeonphi" rel=3D"norefe=
rrer" target=3D"_blank">http://sdm.link/xeonphi</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</div>
</div>

--001a1148e9265b7d32054304e4d2--

