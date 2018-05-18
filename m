References: <20180420111624.7230-1-a@...2181...>
 <20180420111624.7230-2-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <aea2af67-8d3f-9e48-f2da-08e100836fdd@...2181...>
Date: Fri, 18 May 2018 17:34:45 +0800
MIME-Version: 1.0
In-Reply-To: <20180420111624.7230-2-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sBYoNDofOBR5DoRIqh7NWzJR5D3vfDCbj"
Subject: Re: [Openvpn-devel] [PATCH 1/8] implement platform generic
 networking API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sBYoNDofOBR5DoRIqh7NWzJR5D3vfDCbj
Content-Type: multipart/mixed; boundary="ISNHKWSYslrlRTHXwdiAMQzcqOaVvoGzs";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <aea2af67-8d3f-9e48-f2da-08e100836fdd@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/8] implement platform generic networking
 API
References: <20180420111624.7230-1-a@...2181...>
 <20180420111624.7230-2-a@...2181...>
In-Reply-To: <20180420111624.7230-2-a@...2181...>

--ISNHKWSYslrlRTHXwdiAMQzcqOaVvoGzs
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

for the records:

the new networking API has been discussed during our latest community
meeting and some changes have been suggested by other developers.


A new patchset will be sent soonish.


Cheers,

On 20/04/18 19:16, Antonio Quartulli wrote:
> tun.c and route.c contain all the code used by openvpn
> to manage the tun interface and the routing table on all
> the supported platforms.
>=20
> Across the years, this resulted in a longer functions
> and series of ifdefs.
>=20
> This patch introduces a new "networking API" which aims at
> creating a simple abstraction between the tun/route logic
> and the platform dependent code.
>=20
> The is API expected to be implemented outside of tun.c/route.c
> by using platform specific functionalities.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/Makefile.am  |   1 +
>  src/openvpn/networking.h | 225 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 src/openvpn/networking.h
>=20
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index eda08351..c94296d3 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -80,6 +80,7 @@ openvpn_SOURCES =3D \
>  	mtu.c mtu.h \
>  	mudp.c mudp.h \
>  	multi.c multi.h \
> +	networking.h \
>  	ntlm.c ntlm.h \
>  	occ.c occ.h occ-inline.h \
>  	openssl_compat.h \
> diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
> new file mode 100644
> index 00000000..87157dea
> --- /dev/null
> +++ b/src/openvpn/networking.h
> @@ -0,0 +1,225 @@
> +/*
> + *  Generic interface to platform specific networking code
> + *
> + *  Copyright (C) 2016-2018 Antonio Quartulli <a@...2181...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef NETWORKING_H_
> +#define NETWORKING_H_
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#ifdef TARGET_LINUX
> +
> +#include <stdbool.h>
> +#include <netinet/in.h>
> +
> +/**
> + * Bring interface up or down.
> + *
> + * @param iface     the interface to modify
> + * @param up        true if the interface has to be brought up, false ot=
herwise
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_iface_up(const char *iface, bool up);
> +
> +/**
> + * Set the MTU for an interface
> + *
> + * @param iface     the interface to modify
> + * @param mtru      the new MTU
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_iface_mtu_set(const char *iface, uint32_t mtu);
> +
> +/**
> + * Add an IPv4 address to an interface
> + *
> + * @param iface     the interface where the address has to be added
> + * @param addr      the address to add
> + * @param prefixlen the prefix length of the network associated with the=
 address
> + * @param broadcast the broadcast address to configure on the interface
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_addr_v4_add(const char *iface, const in_addr_t *addr, int prefix=
len,
> +                    const in_addr_t *broadcast);
> +
> +/**
> + * Add an IPv6 address to an interface
> + *
> + * @param iface     the interface where the address has to be added
> + * @param addr      the address to add
> + * @param prefixlen the prefix length of the network associated with the=
 address
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +
> +int net_addr_v6_add(const char *iface, const struct in6_addr *addr,
> +                    int prefixlen);
> +
> +/**
> + * Remove an IPv4 from an interface
> + *
> + * @param iface     the interface to remove the address from
> + * @param prefixlen the prefix length of the network associated with the=
 address
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_addr_v4_del(const char *iface, const in_addr_t *addr, int prefix=
len);
> +
> +/**
> + * Remove an IPv6 from an interface
> + *
> + * @param iface     the interface to remove the address from
> + * @param prefixlen the prefix length of the network associated with the=
 address
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_addr_v6_del(const char *iface, const struct in6_addr *addr,
> +                    int prefixlen);
> +
> +/**
> + * Add a point-to-point IPv4 address to an interface
> + *
> + * @param iface     the interface where the address has to be added
> + * @param local     the address to add
> + * @param remote    the associated p-t-p remote address
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_addr_ptp_v4_add(const char *iface, const in_addr_t *local,
> +                        const in_addr_t *remote);
> +
> +/**
> + * Remove a point-to-point IPv4 address from an interface
> + *
> + * @param iface     the interface to remove the address from
> + * @param local     the address to remove
> + * @param remote    the associated p-t-p remote address
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_addr_ptp_v4_del(const char *iface, const in_addr_t *local,
> +                        const in_addr_t *remote);
> +
> +
> +/**
> + * Add a route for an IPv4 address/network
> + *
> + * @param dst       the destination of the route
> + * @param prefixlen the length of the prefix of the destination
> + * @param gw        the gateway for this route
> + * @param iface     the interface for this route (can be NULL)
> + * @param table     the table to add this route to (if 0, will be added =
to the
> + *                  main table)
> + * @param metric    the metric associated with the route
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_route_v4_add(const in_addr_t *dst, int prefixlen,
> +                     const in_addr_t *gw, const char *iface, uint32_t ta=
ble,
> +                     int metric);
> +
> +/**
> + * Add a route for an IPv6 address/network
> + *
> + * @param dst       the destination of the route
> + * @param prefixlen the length of the prefix of the destination
> + * @param gw        the gateway for this route
> + * @param iface     the interface for this route (can be NULL)
> + * @param table     the table to add this route to (if 0, will be added =
to the
> + *                  main table)
> + * @param metric    the metric associated with the route
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_route_v6_add(const struct in6_addr *dst, int prefixlen,
> +                     const struct in6_addr *gw, const char *iface,
> +                     uint32_t table, int metric);
> +
> +/**
> + * Delete a route for an IPv4 address/network
> + *
> + * @param dst       the destination of the route
> + * @param prefixlen the length of the prefix of the destination
> + * @param gw        the gateway for this route
> + * @param iface     the interface for this route (can be NULL)
> + * @param table     the table to add this route to (if 0, will be added =
to the
> + *                  main table)
> + * @param metric    the metric associated with the route
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_route_v4_del(const in_addr_t *dst, int prefixlen,
> +                     const in_addr_t *gw, const char *iface, uint32_t ta=
ble,
> +                     int metric);
> +
> +/**
> + * Delete a route for an IPv4 address/network
> + *
> + * @param dst       the destination of the route
> + * @param prefixlen the length of the prefix of the destination
> + * @param gw        the gateway for this route
> + * @param iface     the interface for this route (can be NULL)
> + * @param table     the table to add this route to (if 0, will be added =
to the
> + *                  main table)
> + * @param metric    the metric associated with the route
> + *
> + * @return          0 on success, a negative error code otherwise
> + */
> +int net_route_v6_del(const struct in6_addr *dst, int prefixlen,
> +                     const struct in6_addr *gw, const char *iface,
> +                     uint32_t table, int metric);
> +
> +/**
> + * Retrieve the gateway and outgoing interface for the specified IPv4
> + * address/network
> + *
> + * @param dst           The destination to lookup
> + * @param prefixlen     The length of the prefix of the destination
> + * @param best_gw       Location where the retrieved GW has to be stored
> + * @param best_iface    Location where the retrieved interface has to be=
 stored
> + *
> + * @return              0 on success, a negative error code otherwise
> + */
> +int net_route_v4_best_gw(const in_addr_t *dst, int prefixlen,
> +                         in_addr_t *best_gw, char *best_iface);
> +
> +/**
> + * Retrieve the gateway and outgoing interface for the specified IPv6
> + * address/network
> + *
> + * @param dst           The destination to lookup
> + * @param prefixlen     The length of the prefix of the destination
> + * @param best_gw       Location where the retrieved GW has to be stored
> + * @param best_iface    Location where the retrieved interface has to be=
 stored
> + *
> + * @return              0 on success, a negative error code otherwise
> + */
> +int net_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
> +                         struct in6_addr *best_gw, char *best_iface);
> +
> +#endif /* TARGET_LINUX */
> +
> +#endif /* NETWORKING_H_ */
>=20

--=20
Antonio Quartulli


--ISNHKWSYslrlRTHXwdiAMQzcqOaVvoGzs--

--sBYoNDofOBR5DoRIqh7NWzJR5D3vfDCbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr+njYACgkQB6U8WA7y
zXSK4xAAg1Xzvr88LjU/yM7JIcbSMvYXVrcsGQ+cWgTSJRV/ykUyHnYlXYoapMG0
44T2ICZ+DaMtzxXlEjKh4W1xJjn9US8OcZq4FP3QQVDNgCnL6XxFfH0EYTqjvcZ5
WyE5XRqI2BFSnO+WqyjdkrTV4GX6Rcps9QIQyQ2e+0nY88yaB5JxzL4ZA/XeIphm
0gRkPYTOVfx7sTyCLyVK//aLJcl8Wz6w6BZBAHEEpnnbB5ftdzsg6o9Lbk28IST+
M09d8o8FYVU2unLarDUabaCq+2KVUVNjeFqLXSFZK7g9j2tintdfu662T7G74Gqa
BVeh9G3gPDQzVYObTEJ1IA6Fp/NoVKz5BI6ITFu+4LiNY+NgM/UJCdBRUVc6nMZU
vdQTfc2uYYPMBVG357gfiYpbYI1+SwOXlDKLKRD5NIMGSB9ECNQ0kKblziAkF4Nm
61/ipF1hb5fhS4rmLZy8C3ArP43/fJs4Kuuwbn41M7oEot2ZOkn73ISEPqZhW+7W
zRUzgZrHema2/i6Oot4GNP2I/AvcJgniZOoVyVXGbZU78jq3wS2g+v1PFPYSXFQA
OK+9L4bq5DsNS6RXBBQI10MhE36Y9vdQekCiWhSewBPk7BIg2xrKfZ6b+HMTUTT9
HPtzbPvQHskdODHiCNL5BvRaYF8jTUvjqmFfI3h28LndJiy7W48=
=NE5m
-----END PGP SIGNATURE-----

--sBYoNDofOBR5DoRIqh7NWzJR5D3vfDCbj--

