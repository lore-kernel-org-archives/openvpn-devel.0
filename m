References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-3-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>
Date: Mon, 26 Nov 2018 13:44:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181011184200.22175-3-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H7EgWqe5NOElWow4RaUJiIJyqk33uXKpO"
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] implement networking API for
 iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H7EgWqe5NOElWow4RaUJiIJyqk33uXKpO
Content-Type: multipart/mixed; boundary="6yVX6W0oBZdLDmvlukw4t7dTSguGwSlig";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] implement networking API for
 iproute2
References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-3-a@...2181...>
In-Reply-To: <20181011184200.22175-3-a@...2181...>

--6yVX6W0oBZdLDmvlukw4t7dTSguGwSlig
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.10.18 um 20:41 schrieb Antonio Quartulli:
> iproute2 is the first user of the new networking API and
> its one of the two currently supported functionalities on
> Linux (the other being net-tools).
>=20
> This patch simply copies the current code from tun.c/route.c
> to networking_ip.c without introducing any funcional
> change to the code.
>=20

I skipped the first patch and added notes about the proposed API in this
patch.

>  create mode 100644 src/openvpn/networking_ip.h
>=20
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 8afc4146..3caad17d 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -80,7 +80,7 @@ openvpn_SOURCES =3D \
>  	mtu.c mtu.h \
>  	mudp.c mudp.h \
>  	multi.c multi.h \
> -	networking.h \
> +	networking_ip.c networking_ip.h networking.h \

As ip is not really but a linux specific tool, I think naming this
networking_linuxip.c is better as networking_ip sounds like something
generic.


>  	ntlm.c ntlm.h \
>  	occ.c occ.h \
>  	openssl_compat.h \
> diff --git a/src/openvpn/networking_ip.c b/src/openvpn/networking_ip.c
> new file mode 100644
> index 00000000..ae667a9c
> --- /dev/null
> +++ b/src/openvpn/networking_ip.c
> @@ -0,0 +1,386 @@
> +/*
> + *  Networking API implementation for iproute2
> + *
> + *  Copyright (C) 2018 Antonio Quartulli <a@...2181...>

I think since you copied/pasted from other files this should also have
the normal copyrights, right?

> +
> +#if defined(TARGET_LINUX) && defined(ENABLE_IPROUTE)
> +
> +#include "syshead.h"
> +
> +#include "networking.h"
> +#include "networking_ip.h"
> +#include "misc.h"
> +#include "openvpn.h"
> +#include "run_command.h"
> +#include "socket.h"
> +
> +#include <stdbool.h>
> +#include <netinet/in.h>
> +
> +int
> +net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
> +{
> +    ctx->es =3D NULL;
> +    if (c)
> +        ctx->es =3D c->es;
> +
> +    return 0;
> +}

I know that calling our execve with es=3D=3DNULL is valid but should not we
aim here for consistency and always require c to be non NULL aka ASSERT(c)?


> +int
> +net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
> +{
> +    struct argv argv =3D argv_new();
> +
> +    argv_printf(&argv, "%s link set dev %s %s", iproute_path, iface,
> +                up ? "up" : "down");
> +    argv_msg(M_INFO, &argv);
> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set fai=
led");
> +
> +    argv_reset(&argv);
> +
> +    return 0;
> +}
> +
> +int
> +net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mt=
u)
> +{
> +    struct argv argv =3D argv_new();
> +
> +    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, ifa=
ce,
> +                mtu);
> +    argv_msg(M_INFO, &argv);
> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set fai=
led");
> +
> +    return 0;
> +}
> +
> +int
> +net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
> +                const in_addr_t *addr, int prefixlen,
> +                const in_addr_t *broadcast)
> +{
> +    struct argv argv =3D argv_new();
> +
> +    char *addr_str =3D (char *)print_in_addr_t(*addr, 0, NULL);
> +    char *brd_str =3D (char *)print_in_addr_t(*broadcast, 0, NULL);
> +
> +    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_=
path,
> +                iface, addr_str, prefixlen, brd_str);
> +    argv_msg(M_INFO, &argv);
> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add fai=
led");
> +
> +    free(addr_str);
> +    free(brd_str);
> +
> +    argv_reset(&argv);
> +
> +    return 0;
> +}
> +

I initially written a comment that this method removes the ptp variant
of the method but later saw that there is also a ptp variant of the
method. I would suggest to either ranme this method to
net_addr_bcast_v4_add or have a bool ptp paramter and then call out to
two different methods.



> +net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
> +                const struct in6_addr *addr, int prefixlen)

Same comment as for v4.
> +net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
> +                const in_addr_t *addr, int prefixlen)

> +net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface,
> +                const struct in6_addr *addr, int prefixlen)
>
These methods assume that removing ip on ptp and broadcast is the same
for ptp and boradcast on all platforms, is that really a sane assumption?

Arne


--6yVX6W0oBZdLDmvlukw4t7dTSguGwSlig--

--H7EgWqe5NOElWow4RaUJiIJyqk33uXKpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlv76skACgkQFRhsZwKx
RFT7ug//bHkbt+m6b+M5bNTaGAdmqxAxlHTcNQpr5SEQs2uVIbpUwnpPxhz//KjG
zbK8T+YimB7uyULk6J2iEjxbqhm2AFW2ILDY2FilL5A+W6X/2MZ+RUgSb0L7EOOG
+HyRjn7OjxApgvHD+DY7zMyQuTPuAe9BO5kgG/jwJWpw/NThlRUImwSeqapjbbVF
yGqdSN/lPr0jTRMiWSGWjTc5/uYoa9yV6frD0qHZmR/gG3E9XTPwTCu5aLRhCk8J
JlY6/fDsQ050eoQxS76HsYmJS/YbP/OhFHIr1WN8jEZKxTNoEXXma8/MhHhs7kyQ
x2XSyEbWg6oqeqhVWAGzJdf+RIeZowuzc/IEOhqdT2VOn1ScmZLAVXEcj6md8XFL
YExae2eLfY/v/XJ1WmM9pRnPSjmO2n142jcXydelGQZ16PAMkiRDqkDXScIy9ewj
B/IohN+YTfXKDhFdvKQsZXlk5gUW31EB/0H5mU3sgvr7xSxloQUzFIHYEGwDZ6Tv
of01bZRK9Q1nPUyZsEcDDLVYQxckYxNTM2exFwEGgYCTNjhypJJebMfdbWAX+mTr
dmfyB+z2HLmTf7pbpgAcC8IS9uDv7YTs4oAglJYB8+wZuG3ysitZ+QXAueSbuDBJ
u+mE5sZxeqkdFdTQQ5QmMTWiHiZA9b54lUY7Ob4uKt26b8UYJI0=
=QvIN
-----END PGP SIGNATURE-----

--H7EgWqe5NOElWow4RaUJiIJyqk33uXKpO--

