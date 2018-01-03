MIME-Version: 1.0
In-Reply-To: <1514952123-26616-1-git-send-email-selva.nair@...277...>
References: <1514952123-26616-1-git-send-email-selva.nair@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 3 Jan 2018 13:12:57 +0500
Message-ID: <CAFHpkQEqyeC=tugSVxbMsVFkeDz77fdNcJ-8NC+NeWK_KtsExw@...278...>
Content-Type: multipart/alternative; boundary="001a113ed26a80ec9a0561dac8d6"
Subject: Re: [Openvpn-devel] [PATCH] Return NULL if GetAdaptersInfo fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--001a113ed26a80ec9a0561dac8d6
Content-Type: text/plain; charset="UTF-8"

is it related to trac#973 ?

2018-01-03 9:02 GMT+05:00 <selva.nair@...277...>:

> From: Selva Nair <selva.nair@...277...>
>
> - Currently a pointer to potentially uninitialized IP_ADAPTER_INFO
>   struct is returned on error causing ill-defined behaviour.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>
> There have been some reports of unexpected failure in GetAdaptersInfo.
> When and why that happens is still unclear but this bug could explain
> why the process goes into a tailspin in such occasions.
>
>  src/openvpn/tun.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 25831ce..6e16348 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4178,15 +4178,12 @@ get_adapter_info_list(struct gc_arena *gc)
>      else
>      {
>          pi = (PIP_ADAPTER_INFO) gc_malloc(size, false, gc);
> -        if ((status = GetAdaptersInfo(pi, &size)) == NO_ERROR)
> -        {
> -            return pi;
> -        }
> -        else
> +        if ((status = GetAdaptersInfo(pi, &size)) != NO_ERROR)
>          {
>              msg(M_INFO, "GetAdaptersInfo #2 failed (status=%u) : %s",
>                  (unsigned int)status,
>                  strerror_win32(status, gc));
> +            pi = NULL;
>          }
>      }
>      return pi;
> --
> 2.1.4
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a113ed26a80ec9a0561dac8d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">is it related to trac#973 ?<br></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">2018-01-03 9:02 GMT+05:00  <span dir=
=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selv=
a.nair@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Se=
lva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</=
a>&gt;<br>
<br>
- Currently a pointer to potentially uninitialized IP_ADAPTER_INFO<br>
=C2=A0 struct is returned on error causing ill-defined behaviour.<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
---<br>
<br>
There have been some reports of unexpected failure in GetAdaptersInfo.<br>
When and why that happens is still unclear but this bug could explain<br>
why the process goes into a tailspin in such occasions.<br>
<br>
=C2=A0src/openvpn/tun.c | 7 ++-----<br>
=C2=A01 file changed, 2 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 25831ce..6e16348 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -4178,15 +4178,12 @@ get_adapter_info_list(struct gc_arena *gc)<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pi =3D (PIP_ADAPTER_INFO) gc_malloc(size,=
 false, gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((status =3D GetAdaptersInfo(pi, &amp;size)=
) =3D=3D NO_ERROR)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pi;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((status =3D GetAdaptersInfo(pi, &amp;size)=
) !=3D NO_ERROR)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;GetAdapte=
rsInfo #2 failed (status=3D%u) : %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigned int=
)status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror_win3=
2(status, gc));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pi =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return pi;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div>

--001a113ed26a80ec9a0561dac8d6--

