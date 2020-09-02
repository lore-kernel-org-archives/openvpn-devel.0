MIME-Version: 1.0
References: <20200902123938.188-1-lstipakov@...277...>
In-Reply-To: <20200902123938.188-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 2 Sep 2020 09:11:47 -0400
Message-ID: <CAKuzo_hU94k2kKShBD5v+CB=3jhUT_FvxCHELZxBCMe5X_WDOw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ddd0e105ae5461dd"
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: remove adapter renaming
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000ddd0e105ae5461dd
Content-Type: text/plain; charset="UTF-8"

Hi,

I would suggest to keep this renaming but make it not fatal. A
descriptive name is nice to have and we could even make the name
configurable at some point in future.

Selva

On Wed, Sep 2, 2020 at 8:40 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Renaming doesn't work on some machines (
> https://github.com/OpenVPN/openvpn-build/issues/187)
> and we couldn't find the cause. Also others do not seem to do it, so let's
> get rid of it.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpnmsica/openvpnmsica.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/src/openvpnmsica/openvpnmsica.c
> b/src/openvpnmsica/openvpnmsica.c
> index 31e90bd2..10d4a1cc 100644
> --- a/src/openvpnmsica/openvpnmsica.c
> +++ b/src/openvpnmsica/openvpnmsica.c
> @@ -1094,15 +1094,6 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
>
>              GUID guidAdapter;
>              dwResult = tap_create_adapter(NULL, NULL, szHardwareId,
> &bRebootRequired, &guidAdapter);
> -            if (dwResult == ERROR_SUCCESS)
> -            {
> -                /* Set adapter name. */
> -                dwResult = tap_set_adapter_name(&guidAdapter, szName);
> -                if (dwResult != ERROR_SUCCESS)
> -                {
> -                    tap_delete_adapter(NULL, &guidAdapter,
> &bRebootRequired);
> -                }
> -            }
>          }
>          else if (wcsncmp(szArg[i], L"deleteN=", 8) == 0)
>          {
> --
> 2.17.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000ddd0e105ae5461dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><div>I would suggest to keep this renaming but=
 make it not fatal. A descriptive=C2=A0name is nice to have and we could ev=
en make the name configurable at some point in future.=C2=A0</div></div><di=
v><br></div><div>Selva</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 8:40 AM Lev Stipakov &=
lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stip=
akov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</=
a>&gt;<br>
<br>
Renaming doesn&#39;t work on some machines (<a href=3D"https://github.com/O=
penVPN/openvpn-build/issues/187" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/OpenVPN/openvpn-build/issues/187</a>)<br>
and we couldn&#39;t find the cause. Also others do not seem to do it, so le=
t&#39;s get rid of it.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpnmsica/openvpnmsica.c | 9 ---------<br>
=C2=A01 file changed, 9 deletions(-)<br>
<br>
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c<br>
index 31e90bd2..10d4a1cc 100644<br>
--- a/src/openvpnmsica/openvpnmsica.c<br>
+++ b/src/openvpnmsica/openvpnmsica.c<br>
@@ -1094,15 +1094,6 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GUID guidAdapter;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dwResult =3D tap_create_ada=
pter(NULL, NULL, szHardwareId, &amp;bRebootRequired, &amp;guidAdapter);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dwResult =3D=3D ERROR_SUCCES=
S)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set adapter nam=
e. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dwResult =3D tap_s=
et_adapter_name(&amp;guidAdapter, szName);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dwResult !=3D =
ERROR_SUCCESS)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_=
delete_adapter(NULL, &amp;guidAdapter, &amp;bRebootRequired);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (wcsncmp(szArg[i], L&quot;deleteN=
=3D&quot;, 8) =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-- <br>
2.17.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000ddd0e105ae5461dd--

