References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-3-a@...2181...>
 <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d963568b-232c-f681-94c7-16e320e244a2@...2181...>
Date: Tue, 27 Nov 2018 11:04:12 +1000
MIME-Version: 1.0
In-Reply-To: <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D9SGoNbS3dL4ItGBxpeu1Ls4JgMpDnQHx"
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D9SGoNbS3dL4ItGBxpeu1Ls4JgMpDnQHx
Content-Type: multipart/mixed; boundary="AieM1AKNsakLY45cj76ziKuNnCR4tZuGY";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <d963568b-232c-f681-94c7-16e320e244a2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] implement networking API for
 iproute2
References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-3-a@...2181...>
 <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>
In-Reply-To: <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>

--AieM1AKNsakLY45cj76ziKuNnCR4tZuGY
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 26/11/2018 22:44, Arne Schwabe wrote:
> Am 11.10.18 um 20:41 schrieb Antonio Quartulli:
>> iproute2 is the first user of the new networking API and
>> its one of the two currently supported functionalities on
>> Linux (the other being net-tools).
>>
>> This patch simply copies the current code from tun.c/route.c
>> to networking_ip.c without introducing any funcional
>> change to the code.
>>
>=20
> I skipped the first patch and added notes about the proposed API in this
> patch.
>=20
>>  create mode 100644 src/openvpn/networking_ip.h
>>
>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>> index 8afc4146..3caad17d 100644
>> --- a/src/openvpn/Makefile.am
>> +++ b/src/openvpn/Makefile.am
>> @@ -80,7 +80,7 @@ openvpn_SOURCES =3D \
>>  	mtu.c mtu.h \
>>  	mudp.c mudp.h \
>>  	multi.c multi.h \
>> -	networking.h \
>> +	networking_ip.c networking_ip.h networking.h \
>=20
> As ip is not really but a linux specific tool, I think naming this
> networking_linuxip.c is better as networking_ip sounds like something
> generic.

I did not want to make any assumption - you never know if iproute will
later be ported to *BSD as well. But I am fine with either name.

>=20
>=20
>>  	ntlm.c ntlm.h \
>>  	occ.c occ.h \
>>  	openssl_compat.h \
>> diff --git a/src/openvpn/networking_ip.c b/src/openvpn/networking_ip.c
>> new file mode 100644
>> index 00000000..ae667a9c
>> --- /dev/null
>> +++ b/src/openvpn/networking_ip.c
>> @@ -0,0 +1,386 @@
>> +/*
>> + *  Networking API implementation for iproute2
>> + *
>> + *  Copyright (C) 2018 Antonio Quartulli <a@...2181...>
>=20
> I think since you copied/pasted from other files this should also have
> the normal copyrights, right?

Yeah, it makes sense because in this file there is code coming from the
current implementation.

>=20
>> +
>> +#if defined(TARGET_LINUX) && defined(ENABLE_IPROUTE)
>> +
>> +#include "syshead.h"
>> +
>> +#include "networking.h"
>> +#include "networking_ip.h"
>> +#include "misc.h"
>> +#include "openvpn.h"
>> +#include "run_command.h"
>> +#include "socket.h"
>> +
>> +#include <stdbool.h>
>> +#include <netinet/in.h>
>> +
>> +int
>> +net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
>> +{
>> +    ctx->es =3D NULL;
>> +    if (c)
>> +        ctx->es =3D c->es;
>> +
>> +    return 0;
>> +}
>=20
> I know that calling our execve with es=3D=3DNULL is valid but should not =
we
> aim here for consistency and always require c to be non NULL aka ASSERT(c=
)?

No, because this can be invoked when calling openvpn with "--show-gateway".
In that case we need to talk to the network stack but there is no context.

>=20
>=20
>> +int
>> +net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
>> +{
>> +    struct argv argv =3D argv_new();
>> +
>> +    argv_printf(&argv, "%s link set dev %s %s", iproute_path, iface,
>> +                up ? "up" : "down");
>> +    argv_msg(M_INFO, &argv);
>> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set fa=
iled");
>> +
>> +    argv_reset(&argv);
>> +
>> +    return 0;
>> +}
>> +
>> +int
>> +net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t m=
tu)
>> +{
>> +    struct argv argv =3D argv_new();
>> +
>> +    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, if=
ace,
>> +                mtu);
>> +    argv_msg(M_INFO, &argv);
>> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set fa=
iled");
>> +
>> +    return 0;
>> +}
>> +
>> +int
>> +net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
>> +                const in_addr_t *addr, int prefixlen,
>> +                const in_addr_t *broadcast)
>> +{
>> +    struct argv argv =3D argv_new();
>> +
>> +    char *addr_str =3D (char *)print_in_addr_t(*addr, 0, NULL);
>> +    char *brd_str =3D (char *)print_in_addr_t(*broadcast, 0, NULL);
>> +
>> +    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute=
_path,
>> +                iface, addr_str, prefixlen, brd_str);
>> +    argv_msg(M_INFO, &argv);
>> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add fa=
iled");
>> +
>> +    free(addr_str);
>> +    free(brd_str);
>> +
>> +    argv_reset(&argv);
>> +
>> +    return 0;
>> +}
>> +
>=20
> I initially written a comment that this method removes the ptp variant
> of the method but later saw that there is also a ptp variant of the
> method. I would suggest to either ranme this method to
> net_addr_bcast_v4_add or have a bool ptp paramter and then call out to
> two different methods.

To me it feels like the PtP case is a special case, therefore I
preferred to keep the "standard & simple" name for the non-PtP case and
then add a special function just for PtP.

Actually this function may even be called without a broadcast address.

Mh..dunno to be honest. Maybe somebody else has an opinion?

>=20
>=20
>=20
>> +net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
>> +                const struct in6_addr *addr, int prefixlen)
>=20
> Same comment as for v4.
>> +net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
>> +                const in_addr_t *addr, int prefixlen)
>=20
>> +net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface,
>> +                const struct in6_addr *addr, int prefixlen)
>>
> These methods assume that removing ip on ptp and broadcast is the same
> for ptp and boradcast on all platforms, is that really a sane assumption?
>=20

Good point ! It is a sane assumption at least for netlink and iproute. I
am not sure about nettols.
How about Android?


Regards,

--=20
Antonio Quartulli


--AieM1AKNsakLY45cj76ziKuNnCR4tZuGY--

--D9SGoNbS3dL4ItGBxpeu1Ls4JgMpDnQHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlv8mAwACgkQ9FVsWUWD
Dm0jvQ/9EK4gbkpzURWd0CBkmj/AQiZ7IBBLhp9MTzbA/lnwJ2x823tvDlqqSzBa
5uM1UUKuLJjMLat/Ns5HG6UPoOPHfSd5F+an+f5sX/SGJaqPD91D3FlXeQOLo9sa
C8G+VKkE0StHBzXyrmg5nR3tbgPRTyjHspl3tpMt7lIgMtcOsz1NMVFRCLQJnwZJ
4ociEkXAJ0VMeKuAB7wZB7uP3ZJOafkAWtJLzjKuwmBUXfX/xiv7SvqNsPXMb9Hv
yDxlkkUjdW7FXrztwxq/kapKFvVslkOLCafd1Y091SL71M2t7c+WtEhdf5EF2xKm
cnTBdODIEliayVJvqMG+24BsxYT+hFRREGdVCCGrkp+cf/A/jhAhdhE4GhjKkH/d
HSTOPBrRtmQBz/tgk6VSYwDeD2R09bZe0kRK/djtN4sWhNgYIgbpkuO90eo0lDlt
P5Q9Tid93Oxc0E1xeUd3IH2OQ1WVBR8CLev/0GJxndscPRQMY7Fb0SzH1MG5VA/v
l3AqFMwe10yk3M+G/hijM9HFBNpRrcp+V/FHDBfZS0fDA5AWkQajcTck8gqMeHPY
WdyqLIERS5z6cC6lcRkJaUL03LOS6yIN/SG9JYhqyCaGHZEHixyuqY3EoU+OZ3w3
K37jtL9WOWuCROB7AkQ2KKPxm0QYg0Gc2I6FoNmO2ec70rxaG2w=
=IL7K
-----END PGP SIGNATURE-----

--D9SGoNbS3dL4ItGBxpeu1Ls4JgMpDnQHx--

