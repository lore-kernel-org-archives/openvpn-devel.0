MIME-Version: 1.0
In-Reply-To: <20180622102110.21888-1-a@...2181...>
References: <20180622102110.21888-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Jun 2018 10:45:21 -0400
Message-ID: <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
Content-Type: multipart/alternative; boundary="00000000000008ac55056f3c16bd"
Subject: Re: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
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

--00000000000008ac55056f3c16bd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Jun 22, 2018 at 6:21 AM, Antonio Quartulli <a@...2181...> wrote:
> %lu is not supported by our tiny argv_printf implementation and will
> trigger an ASSERT() when parsing it. Even though this particular
> ASSERT() is not critical as it happens during shutdown, we still have to
> fix it.
>
> Since in this case the code is trying to use a DWORD variable as
> argument, and we know that DWORD is an unsigned long, which in turn is
> 32bit long on MS Windows (32 and 64bit version)[1][2], simply use
> the already supported %u instead of %lu.
>
> [1]https://msdn.microsoft.com/en-us/library/aa383751(VS.85).aspx
> [2]https://en.wikipedia.org/wiki/Integer_(computer_science)#Long_integer
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index a45a273a..209daeab 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1616,7 +1616,7 @@ add_route(struct route_ipv4 *r, const struct tuntap
*tt, unsigned int flags,
>          if (is_on_link(is_local_route, flags, rgi))
>          {
>              ai = rgi->adapter_index;
> -            argv_printf_cat(&argv, "IF %lu", ai);
> +            argv_printf_cat(&argv, "IF %u", ai);
>          }
>
>          argv_msg(D_ROUTE, &argv);

Thanks for cleaning up my mistake (commit
06ad53e067d9a8be571a27f44005fa7e8038f69e introduced this). One
purpose of that commit was to get rid of -Wformat warnings as those
are not always benign. But this will re-introduce a warning as "ai" is
unsigned long even though its the same size as unsigned.

Currently we do support building with -Werror=format (see
https://patchwork.openvpn.net/patch/234/#463), so I suggest either
cast to (unsigned)  which we know is safe here, or add "%lu" to
argv_printf_arglist().

I would prefer the latter as its easy to overlook the fact that
argv_printf_cat() can't handle %lu which is commonly used
on Windows.

Selva

--00000000000008ac55056f3c16bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On Fri, Jun 22, 2018 at 6:21 AM, Antonio Quartu=
lli &lt;a@...2181...&gt; wrote:<br>&gt; %lu is not supported by our tiny ar=
gv_printf implementation and will<br>&gt; trigger an ASSERT() when parsing =
it. Even though this particular<br>&gt; ASSERT() is not critical as it happ=
ens during shutdown, we still have to<br>&gt; fix it.<br>&gt;<br>&gt; Since=
 in this case the code is trying to use a DWORD variable as<br>&gt; argumen=
t, and we know that DWORD is an unsigned long, which in turn is<br>&gt; 32b=
it long on MS Windows (32 and 64bit version)[1][2], simply use<br>&gt; the =
already supported %u instead of %lu.<br>&gt;<br>&gt; [1]<a href=3D"https://=
msdn.microsoft.com/en-us/library/aa383751(VS.85).aspx" target=3D"_blank">ht=
tps://msdn.microsoft.com/<wbr>en-us/library/aa383751(VS.85).<wbr>aspx</a><b=
r>&gt; [2]<a href=3D"https://en.wikipedia.org/wiki/Integer_(computer_scienc=
e)#Long_integer" target=3D"_blank">https://en.wikipedia.org/wi<wbr>ki/Integ=
er_(computer_science)#<wbr>Long_integer</a><br>&gt;<br>&gt; Signed-off-by: =
Antonio Quartulli &lt;a@...2181...&gt;<br>&gt; ---<br>&gt; =C2=A0src/openvp=
n/route.c | 2 +-<br>&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-=
)<br>&gt;<br>&gt; diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br=
>&gt; index a45a273a..209daeab 100644<br>&gt; --- a/src/openvpn/route.c<br>=
&gt; +++ b/src/openvpn/route.c<br>&gt; @@ -1616,7 +1616,7 @@ add_route(stru=
ct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_on_link(is_local_route, flags, rgi))<=
br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ai =3D rgi-&gt;adapter_index;<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_printf_cat(&amp;argv, &quot;IF %lu&q=
uot;, ai);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_printf_c=
at(&amp;argv, &quot;IF %u&quot;, ai);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_msg(D_ROUTE,=
 &amp;argv);<br><br>Thanks for cleaning up my mistake (commit<br>06ad53e067=
d9a8be571a27f44005fa<wbr>7e8038f69e introduced this). One<br>purpose of tha=
t commit was to get rid of -Wformat warnings as those<br>are not always ben=
ign. But this will re-introduce a warning as &quot;ai&quot; is<br>unsigned =
long even though its the same size as unsigned.<br><br>Currently we do supp=
ort building with -Werror=3Dformat (see<br><a href=3D"https://patchwork.ope=
nvpn.net/patch/234/#463" target=3D"_blank">https://patchwork.openvpn.net/<w=
br>patch/234/#463</a>), so I suggest either<br>cast to (unsigned) =C2=A0whi=
ch we know is safe here, or add &quot;%lu&quot; to<br>argv_printf_arglist()=
.<br><br>I would prefer the latter as its easy to overlook the fact that<br=
>argv_printf_cat() can&#39;t handle %lu which is commonly used<br>on Window=
s.<br><br>Selva<br></div>

--00000000000008ac55056f3c16bd--

