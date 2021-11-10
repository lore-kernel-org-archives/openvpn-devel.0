MIME-Version: 1.0
References: <20211108135314.148-1-lstipakov@...277...>
In-Reply-To: <20211108135314.148-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Nov 2021 13:46:00 -0500
Message-ID: <CAKuzo_jCzuJ3xvwAdM_YHz6Zu-kHr19kZV-vmvP3k1_2UAE+hw@...278...>
Content-Type: multipart/alternative; boundary="0000000000000c8d3b05d073a4f1"
Subject: Re: [Openvpn-devel] [PATCH] tun: improve DHCP server address
 calculation for small subnets
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

--0000000000000c8d3b05d073a4f1
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Nov 10, 2021 at 6:01 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> When /30 subnet is pushed (like in the case of OpenVPN Cloud),
> DHCP server address is calculated to be the same as local address,
> which causes collision and therefore connection is not established.
>
> To fix that, use openvpn3 approach, which sets DHCP server
> address to a network address for small subnets
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 28f803ec..994e3751 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6363,7 +6363,9 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char
> *device_guid)
>              }
>              else
>              {
> -                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, -1);
> +                int prefix_len = netmask_to_netbits2(tt->adapter_netmask);
> +                /* use network address as DHCP server for small subnets,
> otherwise last address before broadcast */
> +                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask,
> prefix_len < 28 ? -1 : 0);
>              }
>          }
>          else
> --


Why not just use 0 offset always? Perpetuating this dance of 0 offset in
some cases, -1 otherwise is not a way forward. Also see my patch from 2015
that never got any traction. I have lost touch with the context, so, I'm
not sure whether this addresses the same (apart from code changes) or
something related.

https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/1449454660-20050-1-git-send-email-selva.nair%40gmail.com/#msg34674818

Also:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13413.html
and other messages in that thread.

Selva

--0000000000000c8d3b05d073a4f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 10, 2021 at 6:01 AM Lev St=
ipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipak=
ov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=
=3D"_blank">lev@...515...</a>&gt;<br>
<br>
When /30 subnet is pushed (like in the case of OpenVPN Cloud),<br>
DHCP server address is calculated to be the same as local address,<br>
which causes collision and therefore connection is not established.<br>
<br>
To fix that, use openvpn3 approach, which sets DHCP server<br>
address to a network address for small subnets<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/tun.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 28f803ec..994e3751 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6363,7 +6363,9 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char =
*device_guid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[2] =3D dhcp_mas=
q_addr(tt-&gt;local, tt-&gt;remote_netmask, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int prefix_len =3D=
 netmask_to_netbits2(tt-&gt;adapter_netmask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use network add=
ress as DHCP server for small subnets, otherwise last address before broadc=
ast */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[2] =3D dhcp_mas=
q_addr(tt-&gt;local, tt-&gt;remote_netmask, prefix_len &lt; 28 ? -1 : 0);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
--</blockquote><div><br></div><div>Why not just use 0 offset always? Perpet=
uating this dance of 0 offset in some cases, -1 otherwise is not a way forw=
ard. Also see my patch from 2015 that never got any traction. I have lost t=
ouch with the context, so, I&#39;m not sure whether this addresses the same=
 (apart from code changes) or something related.</div><div><br></div><div><=
a href=3D"https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/14=
49454660-20050-1-git-send-email-selva.nair%40gmail.com/#msg34674818">https:=
//sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/1449454660-20050-1=
-git-send-email-selva.nair%40gmail.com/#msg34674818</a><br></div><div><br><=
/div><div>Also: <a href=3D"https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg13413.html">https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg13413.html</a> and other messages in that thread.<=
/div><div><br></div><div>Selva</div></div></div>

--0000000000000c8d3b05d073a4f1--

