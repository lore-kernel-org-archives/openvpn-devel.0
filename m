MIME-Version: 1.0
In-Reply-To: <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
References: <20180622102110.21888-1-a@...2181...>
 <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
 <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Jun 2018 11:37:16 -0400
Message-ID: <CAKuzo_i_n01fsYhxoGMSTGox5qpwkmCC+-BNHQ5RTuoz8otmrw@...278...>
Content-Type: multipart/alternative; boundary="000000000000b22116056f3ccfd7"
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

--000000000000b22116056f3ccfd7
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Jun 22, 2018 at 10:48 AM, Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 22/06/18 22:45, Selva Nair wrote:
> [cut]
> >> --- a/src/openvpn/route.c
> >> +++ b/src/openvpn/route.c
> >> @@ -1616,7 +1616,7 @@ add_route(struct route_ipv4 *r, const struct
> tuntap
> > *tt, unsigned int flags,
> >>          if (is_on_link(is_local_route, flags, rgi))
> >>          {
> >>              ai = rgi->adapter_index;
> >> -            argv_printf_cat(&argv, "IF %lu", ai);
> >> +            argv_printf_cat(&argv, "IF %u", ai);
> >>          }
> >>
> >>          argv_msg(D_ROUTE, &argv);
> >
> > Thanks for cleaning up my mistake (commit
> > 06ad53e067d9a8be571a27f44005fa7e8038f69e introduced this). One
> > purpose of that commit was to get rid of -Wformat warnings as those
> > are not always benign. But this will re-introduce a warning as "ai" is
> > unsigned long even though its the same size as unsigned.
> >
> > Currently we do support building with -Werror=format (see
> > https://patchwork.openvpn.net/patch/234/#463), so I suggest either
> > cast to (unsigned)  which we know is safe here, or add "%lu" to
> > argv_printf_arglist().
> >
> > I would prefer the latter as its easy to overlook the fact that
> > argv_printf_cat() can't handle %lu which is commonly used
> > on Windows.
>
> I was just about to test a v2 of this patch with the explicit cast to
> "unsigned int". I was leaning towards the explicit cast because we
> already print DWORD variables in several spots and we always cast them
> to int or unsigned int.
>

We used to have some printed with even %d and no cast. The last time we
cleaned up the offending ones and removed a few casts nearby.

However, if we believe supporting %lu can be more useful, I can do that.
>
> Last opinion? :)
>

I prefer "%lu" and no cast and have been replacing %u by %lu elsewhere in
the code given a chance.

There are a lots DWORD to (unsigned) in tun.c and elsewhere but there is no
compelling reason to change them. We should get rid of casts to (int) when
possible, though.

Selva

--000000000000b22116056f3ccfd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi,<br><br></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote">On Fri, Jun 22, 2018 at 10:48 A=
M, Antonio Quartulli <span dir=3D"ltr">&lt;<a href=3D"mailto:a@...2181..." =
target=3D"_blank">a@...2181...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
On 22/06/18 22:45, Selva Nair wrote:<br>
[cut]<br>
<span>&gt;&gt; --- a/src/openvpn/route.c<br>
&gt;&gt; +++ b/src/openvpn/route.c<br>
&gt;&gt; @@ -1616,7 +1616,7 @@ add_route(struct route_ipv4 *r, const struct=
 tuntap<br>
&gt; *tt, unsigned int flags,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_on_link(is_local_route, f=
lags, rgi))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ai =3D rgi-&gt;ada=
pter_index;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_printf_cat(&amp;ar=
gv, &quot;IF %lu&quot;, ai);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_printf_cat(&amp;ar=
gv, &quot;IF %u&quot;, ai);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_msg(D_ROUTE, &amp;argv);<br>
&gt; <br>
&gt; Thanks for cleaning up my mistake (commit<br>
&gt; 06ad53e067d9a8be571a27f44005fa<wbr>7e8038f69e introduced this). One<br>
&gt; purpose of that commit was to get rid of -Wformat warnings as those<br>
&gt; are not always benign. But this will re-introduce a warning as &quot;a=
i&quot; is<br>
&gt; unsigned long even though its the same size as unsigned.<br>
&gt; <br>
&gt; Currently we do support building with -Werror=3Dformat (see<br>
&gt; <a href=3D"https://patchwork.openvpn.net/patch/234/#463" rel=3D"norefe=
rrer" target=3D"_blank">https://patchwork.openvpn.net/<wbr>patch/234/#463</=
a>), so I suggest either<br>
&gt; cast to (unsigned)=C2=A0 which we know is safe here, or add &quot;%lu&=
quot; to<br>
&gt; argv_printf_arglist().<br>
&gt; <br>
&gt; I would prefer the latter as its easy to overlook the fact that<br>
&gt; argv_printf_cat() can&#39;t handle %lu which is commonly used<br>
&gt; on Windows.<br>
<br>
</span>I was just about to test a v2 of this patch with the explicit cast t=
o<br>
&quot;unsigned int&quot;. I was leaning towards the explicit cast because w=
e<br>
already print DWORD variables in several spots and we always cast them<br>
to int or unsigned int.<br></blockquote><br>We used to have some printed wi=
th even %d and no cast. The last time we cleaned up the offending ones and =
removed a few casts nearby.<br></div><div class=3D"gmail_quote"><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
However, if we believe supporting %lu can be more useful, I can do that.<br>
<br>
Last opinion? :)<br></blockquote><div><br></div><div>I prefer &quot;%lu&quo=
t; and no cast and have been replacing %u by %lu elsewhere in the code give=
n a chance.<br><br>There are a lots DWORD to (unsigned) in tun.c and elsewh=
ere but there is no compelling reason to change them. We should get rid of =
casts to (int) when possible, though.<br><br></div><div>Selva<br></div></di=
v></div></div>

--000000000000b22116056f3ccfd7--

