MIME-Version: 1.0
References: <20230710112122.576-1-lstipakov@...277...>
 <CAKuzo_hCt3iHo=6tXRLofj0O2rfOwZvjar41MSb0MFP3_4Vv4Q@...278...>
In-Reply-To: <CAKuzo_hCt3iHo=6tXRLofj0O2rfOwZvjar41MSb0MFP3_4Vv4Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 10 Jul 2023 12:57:14 -0400
Message-ID: <CAKuzo_i1NbwVXzWKE9HbBCoSUwT3BAZfCcxO=ZNvK4bL8A=B4Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000c82f17060024e06b"
Subject: [Openvpn-devel] Fwd: [PATCH] tun.c: enclose DNS domain in single
 quotes in WMIC call
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c82f17060024e06b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 10, 2023 at 7:22=E2=80=AFAM Lev Stipakov <lstipakov@...277...> =
wrote:

> From: Lev Stipakov <lev@...515...>
>
> This is needed to support domains with hyphens.
>
> Not using double quotes here, since our code replaces
> them with underbars (see
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/win32.c#L980).
>
> Fixes https://github.com/OpenVPN/openvpn/issues/363


>
> Change-Id: Iab536922d0731635cef529b5caf542f637b8d491
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index d1fd6def..60974208 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -333,7 +333,7 @@ do_dns_domain_wmic(bool add, const struct tuntap *tt)
>      }
>
>      struct argv argv =3D argv_new();
> -    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=3D%ld) call
> SetDNSDomain %s",
> +    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=3D%ld) call
> SetDNSDomain '%s'",
>                  get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index,
> add ? tt->options.domain : "");
>      exec_command("WMIC", &argv, 1, M_WARN);
>

Quoting is required as wmic interprets characters such as hyphen and /.
Double quotes would have been better (as in interactive.c) as there are
some cases where characters within single quotes get interpreted special
(like 'foo>bar' vs "foo>bar").

That said, for valid domain names, the only expected characters are
alpha-numeric, hyphen and period, and single quotes should work. I have
only tested this using wmic command line, not the resulting openvpn.exe.

Acked-by: Selva Nair <selva.nair@...277...>

P.S.
We probably need to sanitize the user-supplied domain name before passing
it to wmic.

--000000000000c82f17060024e06b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">Hi,<br></div><div dir=3D"ltr"><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 7:22=E2=80=AFAM Lev =
Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstip=
akov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." targe=
t=3D"_blank">lev@...515...</a>&gt;<br>
<br>
This is needed to support domains with hyphens.<br>
<br>
Not using double quotes here, since our code replaces<br>
them with underbars (see<br>
<a href=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/win32=
.c#L980" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/op=
envpn/blob/master/src/openvpn/win32.c#L980</a>).<br>
<br>
Fixes <a href=3D"https://github.com/OpenVPN/openvpn/issues/363" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn/issues/363</a>=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Change-Id: Iab536922d0731635cef529b5caf542f637b8d491<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index d1fd6def..60974208 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -333,7 +333,7 @@ do_dns_domain_wmic(bool add, const struct tuntap *tt)<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0struct argv argv =3D argv_new();<br>
-=C2=A0 =C2=A0 argv_printf(&amp;argv, &quot;%s%s nicconfig where (Interface=
Index=3D%ld) call SetDNSDomain %s&quot;,<br>
+=C2=A0 =C2=A0 argv_printf(&amp;argv, &quot;%s%s nicconfig where (Interface=
Index=3D%ld) call SetDNSDomain &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_win_sys_p=
ath(), WMIC_PATH_SUFFIX, tt-&gt;adapter_index, add ? tt-&gt;options.domain =
: &quot;&quot;);<br>
=C2=A0 =C2=A0 =C2=A0exec_command(&quot;WMIC&quot;, &amp;argv, 1, M_WARN);<b=
r></blockquote><div><br></div><div>Quoting is required as wmic interprets c=
haracters such as hyphen and /. Double quotes would have been better (as in=
 interactive.c) as there are some cases where characters within single quot=
es get=C2=A0interpreted special (like &#39;foo&gt;bar&#39; vs &quot;foo&gt;=
bar&quot;).=C2=A0</div><div><br></div><div>That said, for valid domain name=
s, the only expected characters are alpha-numeric, hyphen and period, and s=
ingle quotes should work. I have only tested this using wmic command line, =
not the=C2=A0resulting openvpn.exe.</div><div><br></div><div>Acked-by: Selv=
a Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.=
nair@...277...</a>&gt;</div><div><br></div><div>P.S.</div><div>We probably =
need to sanitize the user-supplied domain name before passing it to wmic.<b=
r></div></div></div>
</div></div>

--000000000000c82f17060024e06b--

