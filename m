MIME-Version: 1.0
References: <20210608194330.1431202-1-arne@...1227...>
 <20210609061532.12774-1-a@...2181...>
In-Reply-To: <20210609061532.12774-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 9 Jun 2021 17:36:55 -0400
Message-ID: <CAKuzo_jTZ8K1m61vKw=vK3ru6N91CAM3pejVdQgcAhXOJSN_-A@...278...>
Content-Type: multipart/alternative; boundary="0000000000001a159c05c45c1614"
Subject: Re: [Openvpn-devel] [PATCH v2] Silence warning about format string
 in check_ca_required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001a159c05c45c1614
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Jun 9, 2021 at 2:15 AM Antonio Quartulli <a@...2181...> wrote:

> From: Arne Schwabe <arne@...1227...>
>
> clang does not like if the format argument of printf like function
> is not a string literal (or constant):
>
> warning: format string is not a string literal (potentially insecure)
>
> Make the format string constant to silence the warning.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>
> Changes from v1:
> * use const string instead of introducing "%s".
>
> @Arne I anticipated this change because I "assumed" you would be ok with
> it (patch is still yours), but feel free to comment of course.
>
>
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 819979b1..086f7b6e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2069,7 +2069,7 @@ check_ca_required(const struct options *options)
>          return;
>      }
>
> -    const char* str = "You must define CA file (--ca)"
> +    const char* const str = "You must define CA file (--ca)"
>  #ifndef ENABLE_CRYPTO_MBEDTLS
>          " or CA path (--capath)"
>  #endif
> --
> 2.31.1
>

Changes from v1:
> * use const string instead of introducing "%s".
> @Arne I anticipated this change because I "assumed" you would be ok with
> it (patch is still yours), but feel free to comment of course.


>
In that spirit, assuming Antonio would have acked this had it been
submitted by Arne, I'm ready to ack this on his behalf..

Acked-by: <selva.nair@...277...> masquerading as "pick-your-name"

Earnestly hoping these lines don't show up again in a patch for a very long
time to come..

Selva

--0000000000001a159c05c45c1614
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Jun 9, 2021 at 2:15 AM Antonio Quartulli &l=
t;a@...2181...&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
<br>
clang does not like if the format argument of printf like function<br>
is not a string literal (or constant):<br>
<br>
warning: format string is not a string literal (potentially insecure)<br>
<br>
Make the format string constant to silence the warning.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>
---<br>
<br>
Changes from v1:<br>
* use const string instead of introducing &quot;%s&quot;.<br>
<br>
@Arne I anticipated this change because I &quot;assumed&quot; you would be =
ok with<br>
it (patch is still yours), but feel free to comment of course.<br>
<br>
<br>
=C2=A0src/openvpn/options.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 819979b1..086f7b6e 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -2069,7 +2069,7 @@ check_ca_required(const struct options *options)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 const char* str =3D &quot;You must define CA file (--ca)&quo=
t;<br>
+=C2=A0 =C2=A0 const char* const str =3D &quot;You must define CA file (--c=
a)&quot;<br>
=C2=A0#ifndef ENABLE_CRYPTO_MBEDTLS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; or CA path (--capath)&quot;<br>
=C2=A0#endif<br>
-- <br>
2.31.1<br></blockquote><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Changes from v1:<br>* use const string instead of introducing =
&quot;%s&quot;.<br>@Arne I anticipated this change because I &quot;assumed&=
quot; you would be ok with<br>it (patch is still yours), but feel free to c=
omment of course.</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br></blockquote><div><br></div><div>In that spirit, assuming Antonio =
would have acked=C2=A0this had it been submitted by Arne, I&#39;m ready to =
ack this on his behalf..</div><div><br></div><div>Acked-by: &lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
 masquerading as &quot;pick-your-name&quot;</div><div><br></div><div>Earnes=
tly hoping these lines don&#39;t show up again in a patch for a very long t=
ime to come..</div><div><br></div><div>Selva</div></div></div>

--0000000000001a159c05c45c1614--

