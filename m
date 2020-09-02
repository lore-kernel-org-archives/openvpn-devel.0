MIME-Version: 1.0
References: <20200902133755.308-1-lstipakov@...277...>
In-Reply-To: <20200902133755.308-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 2 Sep 2020 09:49:07 -0400
Message-ID: <CAKuzo_hmoG=MfxsuefwJ5CUMHvXAYCH-n5A-DP4JsJsWBPr-qg@...278...>
Content-Type: multipart/alternative; boundary="0000000000005eca8d05ae54e7f7"
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: make adapter renaming
 non-fatal
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

--0000000000005eca8d05ae54e7f7
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Sep 2, 2020 at 9:39 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> For some users renaming adapter mysteriously fails
> (https://github.com/OpenVPN/openvpn-build/issues/187),
>
> Since renaming is just a a "nice to have", make it not fatail.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpnmsica/openvpnmsica.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpnmsica/openvpnmsica.c
> b/src/openvpnmsica/openvpnmsica.c
> index 31e90bd2..d5b3f09e 100644
> --- a/src/openvpnmsica/openvpnmsica.c
> +++ b/src/openvpnmsica/openvpnmsica.c
> @@ -1100,7 +1100,8 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
>                  dwResult = tap_set_adapter_name(&guidAdapter, szName);
>                  if (dwResult != ERROR_SUCCESS)
>                  {
> -                    tap_delete_adapter(NULL, &guidAdapter,
> &bRebootRequired);
> +                    /* failed renaming is not a fatal error, continue */
> +                    dwResult = ERROR_SUCCESS;
>

This looks strange. If we are going to rewrite dwResult, why set it and
check it at all, just call
tap_set_adapter() without storing the return value and add the comment.

Or, better, print a warning message saying the rename failed.

Selva


>                  }
>              }
>          }
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

--0000000000005eca8d05ae54e7f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 9:39 AM Lev Stipakov &lt;<a =
href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipakov &=
lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt;=
<br>
<br>
For some users renaming adapter mysteriously fails<br>
(<a href=3D"https://github.com/OpenVPN/openvpn-build/issues/187" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/issues/=
187</a>),<br>
<br>
Since renaming is just a a &quot;nice to have&quot;, make it not fatail.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpnmsica/openvpnmsica.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c<br>
index 31e90bd2..d5b3f09e 100644<br>
--- a/src/openvpnmsica/openvpnmsica.c<br>
+++ b/src/openvpnmsica/openvpnmsica.c<br>
@@ -1100,7 +1100,8 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dwResult =3D =
tap_set_adapter_name(&amp;guidAdapter, szName);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dwResult =
!=3D ERROR_SUCCESS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_=
delete_adapter(NULL, &amp;guidAdapter, &amp;bRebootRequired);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* f=
ailed renaming is not a fatal error, continue */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dwRe=
sult =3D ERROR_SUCCESS;<br></blockquote><div><br></div><div>This looks stra=
nge. If we are going to rewrite dwResult, why set it and check it at all, j=
ust call</div><div>tap_set_adapter() without storing the return value and a=
dd the comment.</div><div><br></div><div>Or, better, print a warning messag=
e saying the rename failed.</div><div><br></div><div>Selva</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
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
</blockquote></div></div>

--0000000000005eca8d05ae54e7f7--

