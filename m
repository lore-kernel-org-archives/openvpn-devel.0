MIME-Version: 1.0
References: <20230905211357.581-1-a@...2181...>
In-Reply-To: <20230905211357.581-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 5 Oct 2023 15:03:14 -0400
Message-ID: <CAKuzo_gi9NMH2-N41pigd345mU3nimZCgtndU6TN=zxSYa3Yvg@...278...>
Content-Type: multipart/alternative; boundary="0000000000009e7c6d0606fcc790"
Subject: Re: [Openvpn-devel] [PATCH] man: extend description for
 "dhcp-option DNS" on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...2726...>

--0000000000009e7c6d0606fcc790
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 5, 2023 at 5:41=E2=80=AFPM Antonio Quartulli <a@...2181...> wro=
te:

> From: Antonio Quartulli <antonio@...2726...>
>
> Add an important detail about the DNS configured via this option
> to be an "interface-specific" DNS. This detail is important when
> troubleshooting DNS issues since this logic will bypass the
> routing table.
>
> Signed-off-by: Antonio Quartulli <antonio@...2726...>
> ---
>  doc/man-sections/vpn-network-options.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/man-sections/vpn-network-options.rst
> b/doc/man-sections/vpn-network-options.rst
> index b7f33acd..17c7d4a2 100644
> --- a/doc/man-sections/vpn-network-options.rst
> +++ b/doc/man-sections/vpn-network-options.rst
> @@ -158,6 +158,12 @@ routing.
>          Set primary domain name server IPv4 or IPv6 address.
>          Repeat this option to set secondary DNS server addresses.
>
> +        On Windows this option sets an "interface-specific" DNS, meaning
> +        that the system will try to reach it via the VPN interface,


even if the routing table says otherwise.


> If the wanted DNS is not
>

If the desired DNS server is not

+        expected to be reached via VPN, please don't use this option, but
>

please don't --> do not


> +        rather set the DNS manually (or via DHCP).
>

delete "rather"


> +
>          Note: DNS IPv6 servers are currently set using netsh (the existi=
ng
>          DHCP code can only do IPv4 DHCP, and that protocol only permits
>          IPv4 addresses anywhere). The option will be put into the
>

That said, I'm not convinced this is the right way to document this. IMO,
using "--dhcp-option DNS n.n.n" to set a DNS server not reachable through
the tunnel is a misuse of that option on any platform.

Even on "non-windows" one shouldn't do that as it's very reasonable for a
script that handles it to set it on the interface, instead of globally, if
the platform permits it. For example, using systemd-resolved on Linux
(though I'm not totally sure how exactly interface-specific DNS works in
this case).

So, if at all, why not state that the DNS server specified here should be
reachable through the tunnel irrespective of the platform?

Regards,

Selva

--0000000000009e7c6d0606fcc790
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Sep 5, 2023 at 5:41=E2=80=AFPM Antonio Qua=
rtulli &lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fr=
om: Antonio Quartulli &lt;<a href=3D"mailto:antonio@...2726..." target=3D"_=
blank">antonio@...2726...</a>&gt;<br>
<br>
Add an important detail about the DNS configured via this option<br>
to be an &quot;interface-specific&quot; DNS. This detail is important when<=
br>
troubleshooting DNS issues since this logic will bypass the<br>
routing table.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:antonio@...2726..." =
target=3D"_blank">antonio@...2726...</a>&gt;<br>
---<br>
=C2=A0doc/man-sections/vpn-network-options.rst | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst<br>
index b7f33acd..17c7d4a2 100644<br>
--- a/doc/man-sections/vpn-network-options.rst<br>
+++ b/doc/man-sections/vpn-network-options.rst<br>
@@ -158,6 +158,12 @@ routing.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set primary domain name server IPv4 or IP=
v6 address.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Repeat this option to set secondary DNS s=
erver addresses.<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Windows this option sets an &quot;interface=
-specific&quot; DNS, meaning<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 that the system will try to reach it via the V=
PN interface,</blockquote><div>=C2=A0</div><div>even if the routing table s=
ays otherwise.</div><div>=C2=A0 =C2=A0 =C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">If the wanted DNS is not<br></blockquote><div><br=
></div><div>If the desired DNS server is not=C2=A0</div><div><br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expected to be reached via VPN, please don&#39=
;t use this option, but<br></blockquote><div><br></div><div>please don&#39;=
t --&gt; do not</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rather set the DNS manually (or via DHCP).<br>=
</blockquote><div><br></div><div>delete &quot;rather&quot;</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Note: DNS IPv6 servers are currently set =
using netsh (the existing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DHCP code can only do IPv4 DHCP, and that=
 protocol only permits<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IPv4 addresses anywhere). The option will=
 be put into the<br></blockquote><div><br></div><div>That said, I&#39;m not=
 convinced this is the right way to document this. IMO, using &quot;--dhcp-=
option DNS n.n.n&quot; to set a DNS server not reachable through the tunnel=
 is a misuse of that option on any platform.</div><div><br></div><div>Even =
on &quot;non-windows&quot; one shouldn&#39;t do that as it&#39;s very reaso=
nable for a script that handles it to set it on the interface, instead of g=
lobally, if the platform permits it. For example, using systemd-resolved on=
 Linux (though I&#39;m not totally sure how exactly interface-specific=C2=
=A0DNS works in this case).</div><div><br></div><div>So, if at all, why not=
 state that the DNS server specified here should be reachable through the t=
unnel irrespective of the platform?</div><div><br></div><div>Regards,</div>=
<div><br></div><div>Selva</div></div></div>

--0000000000009e7c6d0606fcc790--

