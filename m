MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
 <20191219223917.1614-7-simon@...2293...>
In-Reply-To: <20191219223917.1614-7-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 14:06:07 +0200
Message-ID: <CAGyAFMU9t+mUtuzmVeXLz5MO+xMZ3-1fJAQUdMDSCtoViSam6g@...278...>
Content-Type: multipart/alternative; boundary="0000000000005106cb059a21817c"
Subject: Re: [Openvpn-devel] [PATCH 7/7] tun.c: reword the
 at_least_one_tap_win() error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000005106cb059a21817c
Content-Type: text/plain; charset="UTF-8"

Makes sense, since we now support both tap-windows and wintun.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 20. jouluk. 2019 klo 0.40 Simon Rozman (simon@...2293...) kirjoitti:

> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 8508b9c0..14ff0259 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4031,7 +4031,7 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
>  {
>      if (!tap_reg)
>      {
> -        msg(M_FATAL, "There are no TAP-Windows adapters on this system.
> You should be able to create a TAP-Windows adapter by going to Start -> All
> Programs -> TAP-Windows -> Utilities -> Add a new TAP-Windows virtual
> ethernet adapter.");
> +        msg(M_FATAL, "There are no TAP-Windows nor Wintun adapters on
> this system.  You should be able to create an adapter by using tapctl.exe
> utility.");
>      }
>  }
>
> --
> 2.24.1.windows.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--0000000000005106cb059a21817c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Makes sense, since we now support both tap-windows and win=
tun.<div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipa=
kov@...277...">lstipakov@...277...</a>&gt;</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">pe 20. jouluk. 2019 klo 0.4=
0 Simon Rozman (<a href=3D"mailto:simon@...2293...">simon@...2293...</a>) k=
irjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed=
-off-by: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=3D"_bl=
ank">simon@...2293...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 8508b9c0..14ff0259 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -4031,7 +4031,7 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (!tap_reg)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;There are no TAP-Windows ad=
apters on this system.=C2=A0 You should be able to create a TAP-Windows ada=
pter by going to Start -&gt; All Programs -&gt; TAP-Windows -&gt; Utilities=
 -&gt; Add a new TAP-Windows virtual ethernet adapter.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;There are no TAP-Windows no=
r Wintun adapters on this system.=C2=A0 You should be able to create an ada=
pter by using tapctl.exe utility.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.24.1.windows.2<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--0000000000005106cb059a21817c--

