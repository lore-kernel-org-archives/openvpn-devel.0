MIME-Version: 1.0
References: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
 <20211109015927.311-1-lstipakov@...277...>
In-Reply-To: <20211109015927.311-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Nov 2021 12:03:54 -0500
Message-ID: <CAKuzo_gkX0n33V_vujnH9biXHEAMnUsgSEgq2Az=tu5QoKuN3Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000caf69905d0865420"
Subject: Re: [Openvpn-devel] [PATCH] Use network address for emulated DHCP
 server as a default
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

--000000000000caf69905d0865420
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Nov 11, 2021 at 4:41 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> This is the rebase of original Selva Nair's patch
> which hasn't been merged:
>
>   https://sourceforge.net/p/openvpn/mailman/message/34674818/


Yes, something I wanted 5 years ago


>
> and documentation change to reflect code changes, which
> is basically a revert of another Selva's patch (which got merged):
>
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13387.html


That was a compromise as the offset patch got no traction..


>
>
> For subnet topology use "offset 0" as default for
> calculating DHCP server address, which makes it equal
> to the network address.
>
> There is no know reason why non-zero default offset
> is needed. Besides, offset -1 breaks subnet /30 case,
> which in some cases is pushed by OpenVPN Cloud product.
>

I could not sell this as a bugfix that time as /30 in subnet mode was not
possible with our server mode as the pool would have been empty in that
case without the patch. Also /30 in subnet mode was considered somewhat
silly.

The reason for the original -1 is probably historical -- the general "rule"
not to use network address as a source address.


>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  doc/man-sections/windows-options.rst | 2 +-
>  src/openvpn/helper.c                 | 4 ++--
>  src/openvpn/tun.c                    | 9 +--------
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/doc/man-sections/windows-options.rst
> b/doc/man-sections/windows-options.rst
> index eacb9af8..c389fbc4 100644
> --- a/doc/man-sections/windows-options.rst
> +++ b/doc/man-sections/windows-options.rst
> @@ -93,7 +93,7 @@ Windows-Specific Options
>          server to masquerade as if it were coming from the remote
> endpoint.
>
>          The optional offset parameter is an integer which is >
> :code:`-256`
> -        and < :code:`256` and which defaults to -1. If offset is positive,
> +        and < :code:`256` and which defaults to 0. If offset is positive,
>          the DHCP server will masquerade as the IP address at network
>          address + offset. If offset is negative, the DHCP server will
>          masquerade as the IP address at broadcast address + offset.
> diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
> index 032a71e8..4ac1cf8e 100644
> --- a/src/openvpn/helper.c
> +++ b/src/openvpn/helper.c
> @@ -237,7 +237,7 @@ helper_client_server(struct options *o)
>       * if tap OR (tun AND topology == subnet):
>       *   ifconfig 10.8.0.1 255.255.255.0
>       *   if !nopool:
> -     *     ifconfig-pool 10.8.0.2 10.8.0.253 255.255.255.0
> +     *     ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
>       *   push "route-gateway 10.8.0.1"
>       *   if route-gateway unset:
>       *     route-gateway 10.8.0.2
> @@ -340,7 +340,7 @@ helper_client_server(struct options *o)
>                  {
>                      o->ifconfig_pool_defined = true;
>                      o->ifconfig_pool_start = o->server_network + 2;
> -                    o->ifconfig_pool_end = (o->server_network |
> ~o->server_netmask) - 2;
> +                    o->ifconfig_pool_end = (o->server_network |
> ~o->server_netmask) - 1;
>                      ifconfig_pool_verify_range(M_USAGE,
> o->ifconfig_pool_start, o->ifconfig_pool_end);
>                  }
>                  o->ifconfig_pool_netmask = o->server_netmask;
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 28f803ec..75d5eaf7 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6357,14 +6357,7 @@ tuntap_dhcp_mask(const struct tuntap *tt, const
> char *device_guid)
>      {
>          if (tt->topology == TOP_SUBNET)
>          {
> -            if (tt->options.dhcp_masq_custom_offset)
> -            {
> -                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask,
> tt->options.dhcp_masq_offset);
> -            }
> -            else
> -            {
> -                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, -1);
> -            }
> +            ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask,
> tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
>          }
>          else
>          {
> --
> 2.23.0.windows.1
>

Looks good to me based on my recollection of testing this a long time ago
-- I have not re-tested this version of the patch.

(An ACK from me may look like an attempt to get in via the backdoor, so
resisting that..).

Selva

--000000000000caf69905d0865420
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Nov 11, 2021 at 4:41 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">F=
rom: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">le=
v@...515...</a>&gt;<br>
<br>
This is the rebase of original Selva Nair&#39;s patch<br>
which hasn&#39;t been merged:<br>
<br>
=C2=A0 <a href=3D"https://sourceforge.net/p/openvpn/mailman/message/3467481=
8/" rel=3D"noreferrer" target=3D"_blank">https://sourceforge.net/p/openvpn/=
mailman/message/34674818/</a></blockquote><div><br></div><div>Yes, somethin=
g I wanted 5 years ago</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
<br>
and documentation change to reflect code changes, which<br>
is basically a revert of another Selva&#39;s patch (which got merged):<br>
<br>
=C2=A0 <a href=3D"https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg13387.html" rel=3D"noreferrer" target=3D"_blank">https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg13387.html</a></blockq=
uote><div><br></div><div>That was a compromise as the offset patch got no t=
raction..</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><br>
<br>
For subnet topology use &quot;offset 0&quot; as default for<br>
calculating DHCP server address, which makes it equal<br>
to the network address.<br>
<br>
There is no know reason why non-zero default offset<br>
is needed. Besides, offset -1 breaks subnet /30 case,<br>
which in some cases is pushed by OpenVPN Cloud product.<br></blockquote><di=
v><br></div><div>I could not sell this as a bugfix that time as /30 in subn=
et mode was not possible with our server mode as the pool would have been e=
mpty in that case without the patch. Also /30 in subnet mode was considered=
 somewhat silly.</div><div><br></div><div>The reason for the original -1 is=
 probably historical -- the general &quot;rule&quot; not to use network add=
ress as a source address.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0doc/man-sections/windows-options.rst | 2 +-<br>
=C2=A0src/openvpn/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 4 ++--<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 9 +--------<br>
=C2=A03 files changed, 4 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/window=
s-options.rst<br>
index eacb9af8..c389fbc4 100644<br>
--- a/doc/man-sections/windows-options.rst<br>
+++ b/doc/man-sections/windows-options.rst<br>
@@ -93,7 +93,7 @@ Windows-Specific Options<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server to masquerade as if it were coming=
 from the remote endpoint.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The optional offset parameter is an integ=
er which is &gt; :code:`-256`<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 and &lt; :code:`256` and which defaults to -1.=
 If offset is positive,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 and &lt; :code:`256` and which defaults to 0. =
If offset is positive,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the DHCP server will masquerade as the IP=
 address at network<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0address + offset. If offset is negative, =
the DHCP server will<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0masquerade as the IP address at broadcast=
 address + offset.<br>
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c<br>
index 032a71e8..4ac1cf8e 100644<br>
--- a/src/openvpn/helper.c<br>
+++ b/src/openvpn/helper.c<br>
@@ -237,7 +237,7 @@ helper_client_server(struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0 * if tap OR (tun AND topology =3D=3D subnet):<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0ifconfig 10.8.0.1 255.255.255.0<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0if !nopool:<br>
-=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0ifconfig-pool 10.8.0.2 10.8.0.253=
 255.255.255.0<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0ifconfig-pool 10.8.0.2 10.8.0.254=
 255.255.255.0<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0push &quot;route-gateway 10.8.0.1&quot;<=
br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0if route-gateway unset:<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0route-gateway 10.8.0.2<br>
@@ -340,7 +340,7 @@ helper_client_server(struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0o-&gt;ifconfig_pool_defined =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0o-&gt;ifconfig_pool_start =3D o-&gt;server_network + 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&g=
t;ifconfig_pool_end =3D (o-&gt;server_network | ~o-&gt;server_netmask) - 2;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&g=
t;ifconfig_pool_end =3D (o-&gt;server_network | ~o-&gt;server_netmask) - 1;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ifconfig_pool_verify_range(M_USAGE, o-&gt;ifconfig_pool_start, o-&gt;ifc=
onfig_pool_end);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o-&gt;ifconfi=
g_pool_netmask =3D o-&gt;server_netmask;<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 28f803ec..75d5eaf7 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6357,14 +6357,7 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char=
 *device_guid)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;topology =3D=3D TOP_SUBNET)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.dhcp_masq_cus=
tom_offset)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[2] =3D dhcp_mas=
q_addr(tt-&gt;local, tt-&gt;remote_netmask, tt-&gt;options.dhcp_masq_offset=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[2] =3D dhcp_mas=
q_addr(tt-&gt;local, tt-&gt;remote_netmask, -1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ep[2] =3D dhcp_masq_addr(tt-&gt;=
local, tt-&gt;remote_netmask, tt-&gt;options.dhcp_masq_custom_offset ? tt-&=
gt;options.dhcp_masq_offset : 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-- <br>
2.23.0.windows.1<br></blockquote><div><br></div><div>Looks good to me based=
 on my recollection of testing this a long time ago -- I have not re-tested=
 this version of the patch.</div><div><br></div><div>(An ACK from me may lo=
ok like an attempt to get in via the backdoor, so resisting that..).</div><=
div><br></div><div>Selva=C2=A0</div></div></div>

--000000000000caf69905d0865420--

