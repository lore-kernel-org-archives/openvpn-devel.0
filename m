MIME-Version: 1.0
In-Reply-To: <1509930876-30728-1-git-send-email-selva.nair@...277...>
References: <1509903249-10979-1-git-send-email-selva.nair@...277...>
 <1509930876-30728-1-git-send-email-selva.nair@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 6 Dec 2017 18:28:09 +0500
Message-ID: <CAFHpkQF2UWhycTjrG2ZXsN3ySM=RxacYdvadKLDV1M5gfvP49A@...278...>
Content-Type: multipart/alternative; boundary="001a114fcda62daf6a055fabecf1"
Subject: Re: [Openvpn-devel] [PATCH v2] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114fcda62daf6a055fabecf1
Content-Type: text/plain; charset="UTF-8"

2017-11-06 6:14 GMT+05:00 <selva.nair@...277...>:

> From: Selva Nair <selva.nair@...277...>
>
> Currently a route addition using IPAPI or service is skipped if the
> route gateway is reachable by multiple interfaces. This changes that
> to use the interface with lowest metric. Implemented by
>
> (i)  Do not over-write the return value with TUN_ADAPTER_INDEX_INVALID in
>      windows_route_find_if_index() if multiple interfaces match a route.
> (ii) Select the interface with lowest metric in adapter_index_of_ip()
>      instead of the first one found when multiple interfaces match.
>
> Reported by Jan Just Keijser <janjust@...1147...>
>
> v2: - A private get_interface_metric() method and better error reporting
>     - Revert an unintented edit of route.c (a_index = ...)
>     - Improve the commit message
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/route.c |  1 -
>  src/openvpn/tun.c   | 59 ++++++++++++++++++++++++++++++
> +++++++++++++++++++++--
>  2 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 8c71e6e..66a8ae3 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2780,7 +2780,6 @@ windows_route_find_if_index(const struct route_ipv4
> *r, const struct tuntap *tt)
>          msg(M_WARN, "Warning: route gateway is ambiguous: %s (%d
> matches)",
>              print_in_addr_t(r->gateway, 0, &gc),
>              count);
> -        ret = TUN_ADAPTER_INDEX_INVALID;
>      }
>
>      dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d
> index=%d",
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 3639718..7603133 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4474,6 +4474,49 @@ is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai,
> const in_addr_t ip, in_addr_t
>      return ret;
>  }
>
> +/**
> + * Given an interface index return the interface metric.
> + *
> + * Arguments:
> + *   index         : The index of the interface
> + *   family        : AF_INET for IPv4 or AF_INET6 for IPv6
> + * On error returns -1
> + */
> +
> +/* function signature missing in mingw iphlpapi.h */
>

that definition apparently present in mingw since 2015

https://sourceforge.net/p/mingw-w64/mingw-w64/ci/ea95d55e3387353e453d6ae8fc5cb8f7503947c2/tree/mingw-w64-headers/include/netioapi.h



> +VOID NETIOAPI_API_
> +InitializeIpInterfaceEntry(PMIB_IPINTERFACE_ROW Row);
> +
> +static int
> +get_interface_metric(NET_IFINDEX index, ADDRESS_FAMILY family)
> +{
> +    DWORD err;
> +    int msglevel = D_ROUTE|M_WARN;
> +    MIB_IPINTERFACE_ROW ipiface;
> +
> +    InitializeIpInterfaceEntry(&ipiface);
> +    ipiface.Family = family;
> +    ipiface.InterfaceIndex = index;
> +
> +    err = GetIpInterfaceEntry(&ipiface);
> +    if (err == NO_ERROR)
> +    {
> +        return ipiface.Metric;
> +    }
> +    else if (err == ERROR_NOT_FOUND)
> +    {
> +        /*
> +         *  This happens if the address family is not enabled for the
> +         *  interface, which is benign -- display only at a debug level
> +         */
> +        msglevel = D_ROUTE_DEBUG;
> +    }
> +    msg(msglevel, "Note: failed to determine metric of interface "
> +                  "<%lu> for %s : (error code = %lu)",
> +                  index, (family == AF_INET)? "ipv4" : "ipv6", err);
> +    return -1;
> +}
> +
>  DWORD
>  adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>                      const in_addr_t ip,
> @@ -4483,6 +4526,7 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>      struct gc_arena gc = gc_new();
>      DWORD ret = TUN_ADAPTER_INDEX_INVALID;
>      in_addr_t highest_netmask = 0;
> +    int lowest_metric = INT_MAX;
>      bool first = true;
>
>      if (count)
> @@ -4496,9 +4540,14 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>
>          if (is_ip_in_adapter_subnet(list, ip, &hn))
>          {
> +            int metric = get_interface_metric(list->Index, AF_INET);
>              if (first || hn > highest_netmask)
>              {
>                  highest_netmask = hn;
> +                if (metric >= 0)
> +                {
> +                    lowest_metric = metric;
> +                }
>                  if (count)
>                  {
>                      *count = 1;
> @@ -4512,16 +4561,22 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>                  {
>                      ++*count;
>                  }
> +                if (metric >= 0 && metric < lowest_metric)
> +                {
> +                    ret = list->Index;
> +                    lowest_metric = metric;
> +                }
>              }
>          }
>          list = list->Next;
>      }
>
> -    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d",
> +    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d
> metric=%d",
>           print_in_addr_t(ip, 0, &gc),
>           print_in_addr_t(highest_netmask, 0, &gc),
>           (int)ret,
> -         count ? *count : -1);
> +         count ? *count : -1,
> +         lowest_metric);
>
>      if (ret == TUN_ADAPTER_INDEX_INVALID && count)
>      {
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

--001a114fcda62daf6a055fabecf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-11-06 6:14 GMT+05:00  <span dir=3D"ltr">&lt;<a href=3D"mailto:selv=
a.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span>:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">F=
rom: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...1665...=
77...</a>&gt;<br>
<br>
Currently a route addition using IPAPI or service is skipped if the<br>
route gateway is reachable by multiple interfaces. This changes that<br>
</span>to use the interface with lowest metric. Implemented by<br>
<br>
(i)=C2=A0 Do not over-write the return value with TUN_ADAPTER_INDEX_INVALID=
 in<br>
=C2=A0 =C2=A0 =C2=A0windows_route_find_if_index() if multiple interfaces ma=
tch a route.<br>
(ii) Select the interface with lowest metric in adapter_index_of_ip()<br>
=C2=A0 =C2=A0 =C2=A0instead of the first one found when multiple interfaces=
 match.<br>
<span class=3D"gmail-"><br>
Reported by Jan Just Keijser &lt;<a href=3D"mailto:janjust@...1147...">janj=
ust@...1147...</a>&gt;<br>
<br>
</span>v2: - A private get_interface_metric() method and better error repor=
ting<br>
=C2=A0 =C2=A0 - Revert an unintented edit of route.c (a_index =3D ...)<br>
=C2=A0 =C2=A0 - Improve the commit message<br>
<span class=3D"gmail-"><br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
---<br>
</span>=C2=A0src/openvpn/route.c |=C2=A0 1 -<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0| 59 ++++++++++++++++++++++++++++++<wbr=
>+++++++++++++++++++++--<br>
=C2=A02 files changed, 57 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index 8c71e6e..66a8ae3 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
<span class=3D"gmail-">@@ -2780,7 +2780,6 @@ windows_route_find_if_index(<w=
br>const struct route_ipv4 *r, const struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;Warning: route gateway =
is ambiguous: %s (%d matches)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_in_addr_t(r-&gt;gatew=
ay, 0, &amp;gc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TUN_ADAPTER_INDEX_INVALID;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0dmsg(D_ROUTE_DEBUG, &quot;DEBUG: route find if: on_tun=
=3D%d count=3D%d index=3D%d&quot;,<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
</span>index 3639718..7603133 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -4474,6 +4474,49 @@ is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai, c=
onst in_addr_t ip, in_addr_t<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/**<br>
+ * Given an interface index return the interface metric.<br>
+ *<br>
+ * Arguments:<br>
+ *=C2=A0 =C2=A0index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: The index of the i=
nterface<br>
+ *=C2=A0 =C2=A0family=C2=A0 =C2=A0 =C2=A0 =C2=A0 : AF_INET for IPv4 or AF_=
INET6 for IPv6<br>
+ * On error returns -1<br>
+ */<br>
+<br>
+/* function signature missing in mingw iphlpapi.h */<br></blockquote><div>=
<br></div><div>that definition apparently present in mingw since 2015<br><b=
r><a href=3D"https://sourceforge.net/p/mingw-w64/mingw-w64/ci/ea95d55e33873=
53e453d6ae8fc5cb8f7503947c2/tree/mingw-w64-headers/include/netioapi.h">http=
s://sourceforge.net/p/mingw-w64/mingw-w64/ci/ea95d55e3387353e453d6ae8fc5cb8=
f7503947c2/tree/mingw-w64-headers/include/netioapi.h</a><br></div><div><br>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+VOID NETIOAPI_API_<br>
+InitializeIpInterfaceEntry(<wbr>PMIB_IPINTERFACE_ROW Row);<br>
+<br>
+static int<br>
+get_interface_metric(NET_<wbr>IFINDEX index, ADDRESS_FAMILY family)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD err;<br>
+=C2=A0 =C2=A0 int msglevel =3D D_ROUTE|M_WARN;<br>
+=C2=A0 =C2=A0 MIB_IPINTERFACE_ROW ipiface;<br>
+<br>
+=C2=A0 =C2=A0 InitializeIpInterfaceEntry(&amp;<wbr>ipiface);<br>
+=C2=A0 =C2=A0 ipiface.Family =3D family;<br>
+=C2=A0 =C2=A0 ipiface.InterfaceIndex =3D index;<br>
+<br>
+=C2=A0 =C2=A0 err =3D GetIpInterfaceEntry(&amp;ipiface);<br>
+=C2=A0 =C2=A0 if (err =3D=3D NO_ERROR)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ipiface.Metric;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (err =3D=3D ERROR_NOT_FOUND)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 This happens if the address fami=
ly is not enabled for the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 interface, which is benign -- di=
splay only at a debug level<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msglevel =3D D_ROUTE_DEBUG;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 msg(msglevel, &quot;Note: failed to determine metric of inte=
rface &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;%=
lu&gt; for %s : (error code =3D %lu)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index, (fam=
ily =3D=3D AF_INET)? &quot;ipv4&quot; : &quot;ipv6&quot;, err);<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
=C2=A0DWORD<br>
=C2=A0adapter_index_of_ip(const IP_ADAPTER_INFO *list,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const in_addr_t ip,<br>
@@ -4483,6 +4526,7 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,<br>
<span class=3D"gmail-">=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();=
<br>
=C2=A0 =C2=A0 =C2=A0DWORD ret =3D TUN_ADAPTER_INDEX_INVALID;<br>
=C2=A0 =C2=A0 =C2=A0in_addr_t highest_netmask =3D 0;<br>
+=C2=A0 =C2=A0 int lowest_metric =3D INT_MAX;<br>
=C2=A0 =C2=A0 =C2=A0bool first =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (count)<br>
</span>@@ -4496,9 +4540,14 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *li=
st,<br>
<span class=3D"gmail-"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ip_in_adapter_subnet(list, ip, &am=
p;hn))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int metric =3D get_interface_met=
ric(list-&gt;<wbr>Index, AF_INET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (first || hn &gt; highes=
t_netmask)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0highest_netma=
sk =3D hn;<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (metric =
&gt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
<span class=3D"gmail-">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 lowest_metric =3D metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
</span><span class=3D"gmail-">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (count)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*count =3D 1;<br>
</span>@@ -4512,16 +4561,22 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *l=
ist,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0++*count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (metric &gt;=3D=
 0 &amp;&amp; metric &lt; lowest_metric)<br>
<span class=3D"gmail-">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =
=3D list-&gt;Index;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lowe=
st_metric =3D metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D list-&gt;Next;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 dmsg(D_ROUTE_DEBUG, &quot;DEBUG: IP Locate: ip=3D%s nm=3D%s =
index=3D%d count=3D%d&quot;,<br>
+=C2=A0 =C2=A0 dmsg(D_ROUTE_DEBUG, &quot;DEBUG: IP Locate: ip=3D%s nm=3D%s =
index=3D%d count=3D%d metric=3D%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(ip, 0, &amp;gc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(highest_<wbr>netmask, 0,=
 &amp;gc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (int)ret,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count ? *count : -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count ? *count : -1,<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lowest_metric);<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D TUN_ADAPTER_INDEX_INVALID &amp;&amp; cou=
nt)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
--<br>
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
</div></div></blockquote></div><br></div></div>

--001a114fcda62daf6a055fabecf1--

