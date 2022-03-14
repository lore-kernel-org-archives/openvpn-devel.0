MIME-Version: 1.0
References: <20220314162048.22955-1-a@...2181...>
In-Reply-To: <20220314162048.22955-1-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 14 Mar 2022 18:48:25 +0200
Message-ID: <CAGyAFMV1cr6n8AH9VenuJ1g0nm9Ua+pWWxOUocU7CB7g8qXLXw@...278...>
Content-Type: multipart/alternative; boundary="000000000000a0788e05da3073a3"
Subject: Re: [Openvpn-devel] [PATCH] remove unused sitnl.h file
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

--000000000000a0788e05da3073a3
Content-Type: text/plain; charset="UTF-8"

I checked that the file is indeed not used and successfully ran GitHub
Actions with this patch.

Acked-by: Lev Stipakov <lstipakov@...277...>

ma 14. maalisk. 2022 klo 18.21 Antonio Quartulli (a@...2181...) kirjoitti:

> sitnl.h must have slipped in when implementing the networking AI and the
> SITNL backend. However it is unused and should simply be removed.
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/sitnl.h | 217 --------------------------------------------
>  1 file changed, 217 deletions(-)
>  delete mode 100644 src/openvpn/sitnl.h
>
> diff --git a/src/openvpn/sitnl.h b/src/openvpn/sitnl.h
> deleted file mode 100644
> index 41a6a0b8..00000000
> --- a/src/openvpn/sitnl.h
> +++ /dev/null
> @@ -1,217 +0,0 @@
> -/*
> - *  Simplified Interface To NetLink
> - *
> - *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program (see the file COPYING included with this
> - *  distribution); if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#ifndef SITNL_H_
> -#define SITNL_H_
> -
> -#ifdef TARGET_LINUX
> -
> -#include <stdbool.h>
> -#include <netinet/in.h>
> -
> -/**
> - * Bring interface up or down.
> - *
> - * @param iface     the interface to modify
> - * @param up        true if the interface has to be brought up, false
> otherwise
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_iface_up(const char *iface, bool up);
> -
> -/**
> - * Set the MTU for an interface
> - *
> - * @param iface     the interface to modify
> - * @param mtru      the new MTU
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_iface_mtu_set(const char *iface, uint32_t mtu);
> -
> -/**
> - * Add an IPv4 address to an interface
> - *
> - * @param iface     the interface where the address has to be added
> - * @param addr      the address to add
> - * @param prefixlen the prefix length of the network associated with the
> address
> - * @param broadcast the broadcast address to configure on the interface
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_addr_v4_add(const char *iface, const in_addr_t *addr, int
> prefixlen,
> -                      const in_addr_t *broadcast);
> -
> -/**
> - * Add an IPv6 address to an interface
> - *
> - * @param iface     the interface where the address has to be added
> - * @param addr      the address to add
> - * @param prefixlen the prefix length of the network associated with the
> address
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -
> -int sitnl_addr_v6_add(const char *iface, const struct in6_addr *addr,
> -                      int prefixlen);
> -
> -/**
> - * Remove an IPv4 from an interface
> - *
> - * @param iface     the interface to remove the address from
> - * @param prefixlen the prefix length of the network associated with the
> address
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_addr_v4_del(const char *iface, const in_addr_t *addr, int
> prefixlen);
> -
> -/**
> - * Remove an IPv6 from an interface
> - *
> - * @param iface     the interface to remove the address from
> - * @param prefixlen the prefix length of the network associated with the
> address
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_addr_v6_del(const char *iface, const struct in6_addr *addr,
> -                      int prefixlen);
> -
> -/**
> - * Add a point-to-point IPv4 address to an interface
> - *
> - * @param iface     the interface where the address has to be added
> - * @param local     the address to add
> - * @param remote    the associated p-t-p remote address
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_addr_ptp_v4_add(const char *iface, const in_addr_t *local,
> -                          const in_addr_t *remote);
> -
> -/**
> - * Remove a point-to-point IPv4 address from an interface
> - *
> - * @param iface     the interface to remove the address from
> - * @param local     the address to remove
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_addr_ptp_v4_del(const char *iface, const in_addr_t *local);
> -
> -
> -/**
> - * Add a route for an IPv4 address/network
> - *
> - * @param dst       the destination of the route
> - * @param prefixlen the length of the prefix of the destination
> - * @param gw        the gateway for this route
> - * @param iface     the interface for this route (can be NULL)
> - * @param table     the table to add this route to (if 0, will be added
> to the
> - *                  main table)
> - * @param metric    the metric associated with the route
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_route_v4_add(const in_addr_t *dst, int prefixlen,
> -                       const in_addr_t *gw, const char *iface, uint32_t
> table,
> -                       int metric);
> -
> -/**
> - * Add a route for an IPv6 address/network
> - *
> - * @param dst       the destination of the route
> - * @param prefixlen the length of the prefix of the destination
> - * @param gw        the gateway for this route
> - * @param iface     the interface for this route (can be NULL)
> - * @param table     the table to add this route to (if 0, will be added
> to the
> - *                  main table)
> - * @param metric    the metric associated with the route
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_route_v6_add(const struct in6_addr *dst, int prefixlen,
> -                       const struct in6_addr *gw, const char *iface,
> -                       uint32_t table, int metric);
> -
> -/**
> - * Delete a route for an IPv4 address/network
> - *
> - * @param dst       the destination of the route
> - * @param prefixlen the length of the prefix of the destination
> - * @param gw        the gateway for this route
> - * @param iface     the interface for this route (can be NULL)
> - * @param table     the table to add this route to (if 0, will be added
> to the
> - *                  main table)
> - * @param metric    the metric associated with the route
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_route_v4_del(const in_addr_t *dst, int prefixlen,
> -                       const in_addr_t *gw, const char *iface, uint32_t
> table,
> -                       int metric);
> -
> -/**
> - * Delete a route for an IPv4 address/network
> - *
> - * @param dst       the destination of the route
> - * @param prefixlen the length of the prefix of the destination
> - * @param gw        the gateway for this route
> - * @param iface     the interface for this route (can be NULL)
> - * @param table     the table to add this route to (if 0, will be added
> to the
> - *                  main table)
> - * @param metric    the metric associated with the route
> - *
> - * @return          0 on success, a negative error code otherwise
> - */
> -int sitnl_route_v6_del(const struct in6_addr *dst, int prefixlen,
> -                       const struct in6_addr *gw, const char *iface,
> -                       uint32_t table, int metric);
> -
> -/**
> - * Retrieve the gateway and outgoing interface for the specified IPv4
> - * address/network
> - *
> - * @param dst           The destination to lookup
> - * @param prefixlen     The length of the prefix of the destination
> - * @param best_gw       Location where the retrieved GW has to be stored
> - * @param best_iface    Location where the retrieved interface has to be
> stored
> - *
> - * @return              0 on success, a negative error code otherwise
> - */
> -int sitnl_route_v4_best_gw(const in_addr_t *dst, int prefixlen,
> -                           in_addr_t *best_gw, char *best_iface);
> -
> -/**
> - * Retrieve the gateway and outgoing interface for the specified IPv6
> - * address/network
> - *
> - * @param dst           The destination to lookup
> - * @param prefixlen     The length of the prefix of the destination
> - * @param best_gw       Location where the retrieved GW has to be stored
> - * @param best_iface    Location where the retrieved interface has to be
> stored
> - *
> - * @return              0 on success, a negative error code otherwise
> - */
> -int sitnl_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
> -                           struct in6_addr *best_gw, char *best_iface);
> -
> -#endif /* TARGET_LINUX */
> -
> -#endif /* SITNL_H_ */
> --
> 2.34.1
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

--000000000000a0788e05da3073a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I checked that the file is indeed not used and successfull=
y ran GitHub Actions with this patch.<div><br></div><div>Acked-by: Lev Stip=
akov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">ma 14. maalisk. 2022 klo 18.21 Antonio Quartulli (<a href=3D"mailto:a=
@...2181...">a@...2181...</a>) kirjoitti:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">sitnl.h must have slipped in when implementing th=
e networking AI and the<br>
SITNL backend. However it is unused and should simply be removed.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/sitnl.h | 217 -------------------------------------------=
-<br>
=C2=A01 file changed, 217 deletions(-)<br>
=C2=A0delete mode 100644 src/openvpn/sitnl.h<br>
<br>
diff --git a/src/openvpn/sitnl.h b/src/openvpn/sitnl.h<br>
deleted file mode 100644<br>
index 41a6a0b8..00000000<br>
--- a/src/openvpn/sitnl.h<br>
+++ /dev/null<br>
@@ -1,217 +0,0 @@<br>
-/*<br>
- *=C2=A0 Simplified Interface To NetLink<br>
- *<br>
- *=C2=A0 Copyright (C) 2016-2022 Antonio Quartulli &lt;<a href=3D"mailto:a=
@...2181..." target=3D"_blank">a@...2181...</a>&gt;<br>
- *<br>
- *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
- *=C2=A0 it under the terms of the GNU General Public License version 2<br>
- *=C2=A0 as published by the Free Software Foundation.<br>
- *<br>
- *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
- *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
- *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
- *=C2=A0 GNU General Public License for more details.<br>
- *<br>
- *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
- *=C2=A0 along with this program (see the file COPYING included with this<=
br>
- *=C2=A0 distribution); if not, write to the Free Software Foundation, Inc=
.,<br>
- *=C2=A0 59 Temple Place, Suite 330, Boston, MA=C2=A0 02111-1307=C2=A0 USA=
<br>
- */<br>
-<br>
-#ifndef SITNL_H_<br>
-#define SITNL_H_<br>
-<br>
-#ifdef TARGET_LINUX<br>
-<br>
-#include &lt;stdbool.h&gt;<br>
-#include &lt;netinet/in.h&gt;<br>
-<br>
-/**<br>
- * Bring interface up or down.<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface to modify<br>
- * @param up=C2=A0 =C2=A0 =C2=A0 =C2=A0 true if the interface has to be br=
ought up, false otherwise<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_iface_up(const char *iface, bool up);<br>
-<br>
-/**<br>
- * Set the MTU for an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface to modify<br>
- * @param mtru=C2=A0 =C2=A0 =C2=A0 the new MTU<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_iface_mtu_set(const char *iface, uint32_t mtu);<br>
-<br>
-/**<br>
- * Add an IPv4 address to an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface where the address has to =
be added<br>
- * @param addr=C2=A0 =C2=A0 =C2=A0 the address to add<br>
- * @param prefixlen the prefix length of the network associated with the a=
ddress<br>
- * @param broadcast the broadcast address to configure on the interface<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_addr_v4_add(const char *iface, const in_addr_t *addr, int prefix=
len,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const in_addr_t *broadcast);<br>
-<br>
-/**<br>
- * Add an IPv6 address to an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface where the address has to =
be added<br>
- * @param addr=C2=A0 =C2=A0 =C2=A0 the address to add<br>
- * @param prefixlen the prefix length of the network associated with the a=
ddress<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-<br>
-int sitnl_addr_v6_add(const char *iface, const struct in6_addr *addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int prefixlen);<br>
-<br>
-/**<br>
- * Remove an IPv4 from an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface to remove the address fro=
m<br>
- * @param prefixlen the prefix length of the network associated with the a=
ddress<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_addr_v4_del(const char *iface, const in_addr_t *addr, int prefix=
len);<br>
-<br>
-/**<br>
- * Remove an IPv6 from an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface to remove the address fro=
m<br>
- * @param prefixlen the prefix length of the network associated with the a=
ddress<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_addr_v6_del(const char *iface, const struct in6_addr *addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int prefixlen);<br>
-<br>
-/**<br>
- * Add a point-to-point IPv4 address to an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface where the address has to =
be added<br>
- * @param local=C2=A0 =C2=A0 =C2=A0the address to add<br>
- * @param remote=C2=A0 =C2=A0 the associated p-t-p remote address<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_addr_ptp_v4_add(const char *iface, const in_addr_t *local,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const in_addr_t *remote);<br>
-<br>
-/**<br>
- * Remove a point-to-point IPv4 address from an interface<br>
- *<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface to remove the address fro=
m<br>
- * @param local=C2=A0 =C2=A0 =C2=A0the address to remove<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_addr_ptp_v4_del(const char *iface, const in_addr_t *local);<br>
-<br>
-<br>
-/**<br>
- * Add a route for an IPv4 address/network<br>
- *<br>
- * @param dst=C2=A0 =C2=A0 =C2=A0 =C2=A0the destination of the route<br>
- * @param prefixlen the length of the prefix of the destination<br>
- * @param gw=C2=A0 =C2=A0 =C2=A0 =C2=A0 the gateway for this route<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface for this route (can be NU=
LL)<br>
- * @param table=C2=A0 =C2=A0 =C2=A0the table to add this route to (if 0, w=
ill be added to the<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 main tabl=
e)<br>
- * @param metric=C2=A0 =C2=A0 the metric associated with the route<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_route_v4_add(const in_addr_t *dst, int prefixlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const in_addr_t *gw, const char *iface, uint32_t table,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int metric);<br>
-<br>
-/**<br>
- * Add a route for an IPv6 address/network<br>
- *<br>
- * @param dst=C2=A0 =C2=A0 =C2=A0 =C2=A0the destination of the route<br>
- * @param prefixlen the length of the prefix of the destination<br>
- * @param gw=C2=A0 =C2=A0 =C2=A0 =C2=A0 the gateway for this route<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface for this route (can be NU=
LL)<br>
- * @param table=C2=A0 =C2=A0 =C2=A0the table to add this route to (if 0, w=
ill be added to the<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 main tabl=
e)<br>
- * @param metric=C2=A0 =C2=A0 the metric associated with the route<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_route_v6_add(const struct in6_addr *dst, int prefixlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct in6_addr *gw, const char *iface,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t table, int metric);<br>
-<br>
-/**<br>
- * Delete a route for an IPv4 address/network<br>
- *<br>
- * @param dst=C2=A0 =C2=A0 =C2=A0 =C2=A0the destination of the route<br>
- * @param prefixlen the length of the prefix of the destination<br>
- * @param gw=C2=A0 =C2=A0 =C2=A0 =C2=A0 the gateway for this route<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface for this route (can be NU=
LL)<br>
- * @param table=C2=A0 =C2=A0 =C2=A0the table to add this route to (if 0, w=
ill be added to the<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 main tabl=
e)<br>
- * @param metric=C2=A0 =C2=A0 the metric associated with the route<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_route_v4_del(const in_addr_t *dst, int prefixlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const in_addr_t *gw, const char *iface, uint32_t table,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int metric);<br>
-<br>
-/**<br>
- * Delete a route for an IPv4 address/network<br>
- *<br>
- * @param dst=C2=A0 =C2=A0 =C2=A0 =C2=A0the destination of the route<br>
- * @param prefixlen the length of the prefix of the destination<br>
- * @param gw=C2=A0 =C2=A0 =C2=A0 =C2=A0 the gateway for this route<br>
- * @param iface=C2=A0 =C2=A0 =C2=A0the interface for this route (can be NU=
LL)<br>
- * @param table=C2=A0 =C2=A0 =C2=A0the table to add this route to (if 0, w=
ill be added to the<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 main tabl=
e)<br>
- * @param metric=C2=A0 =C2=A0 the metric associated with the route<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a negative erro=
r code otherwise<br>
- */<br>
-int sitnl_route_v6_del(const struct in6_addr *dst, int prefixlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct in6_addr *gw, const char *iface,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t table, int metric);<br>
-<br>
-/**<br>
- * Retrieve the gateway and outgoing interface for the specified IPv4<br>
- * address/network<br>
- *<br>
- * @param dst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The destination to l=
ookup<br>
- * @param prefixlen=C2=A0 =C2=A0 =C2=A0The length of the prefix of the des=
tination<br>
- * @param best_gw=C2=A0 =C2=A0 =C2=A0 =C2=A0Location where the retrieved G=
W has to be stored<br>
- * @param best_iface=C2=A0 =C2=A0 Location where the retrieved interface h=
as to be stored<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a=
 negative error code otherwise<br>
- */<br>
-int sitnl_route_v4_best_gw(const in_addr_t *dst, int prefixlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0in_addr_t *best_gw, char *best_iface);<br>
-<br>
-/**<br>
- * Retrieve the gateway and outgoing interface for the specified IPv6<br>
- * address/network<br>
- *<br>
- * @param dst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The destination to l=
ookup<br>
- * @param prefixlen=C2=A0 =C2=A0 =C2=A0The length of the prefix of the des=
tination<br>
- * @param best_gw=C2=A0 =C2=A0 =C2=A0 =C2=A0Location where the retrieved G=
W has to be stored<br>
- * @param best_iface=C2=A0 =C2=A0 Location where the retrieved interface h=
as to be stored<br>
- *<br>
- * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 on success, a=
 negative error code otherwise<br>
- */<br>
-int sitnl_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct in6_addr *best_gw, char *best_iface);<br>
-<br>
-#endif /* TARGET_LINUX */<br>
-<br>
-#endif /* SITNL_H_ */<br>
-- <br>
2.34.1<br>
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

--000000000000a0788e05da3073a3--

