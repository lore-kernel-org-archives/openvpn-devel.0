References: <1475060898-21462-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f030880b-14d0-a547-bf57-1c9b681b2615@...2080...>
Date: Tue, 18 Oct 2016 15:37:21 +0200
MIME-Version: 1.0
In-Reply-To: <1475060898-21462-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3qSEeEVOlawpWQJGOdlM0lDRqIlwCNVLw"
Subject: Re: [Openvpn-devel] [PATCH] Don't deference type-punned pointers
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3qSEeEVOlawpWQJGOdlM0lDRqIlwCNVLw
Content-Type: multipart/mixed; boundary="xftFu09TT0dOABkU4r4NWsgG3vLQNResk";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <f030880b-14d0-a547-bf57-1c9b681b2615@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Don't deference type-punned pointers
References: <1475060898-21462-1-git-send-email-steffan@...1856...>
In-Reply-To: <1475060898-21462-1-git-send-email-steffan@...1856...>

--xftFu09TT0dOABkU4r4NWsgG3vLQNResk
Content-Type: multipart/mixed; boundary="------------48EF88FE7F6F5DA6A267ED55"

This is a multi-part message in MIME format.
--------------48EF88FE7F6F5DA6A267ED55
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/09/16 13:08, Steffan Karger wrote:
> Fixes compiler warnings (undefined behavior) by making the copy explicit
> to comply to strict aliasing rules.  With newer GCC the old code could
> actually lead to undefined behaviour.
>=20
> See e.g. http://blog.regehr.org/archives/959.

Hmm ... This is an interesting blog post.  And testing the examples
provided there on my own system, and I see the same results.

So I wanted to compare those findings with what happens with our own
code, so I extracted the needed pieces and tried the same (source
attached).  But for us the result is not so clear and obvious at all.

Unless I've overlooked something bloody obvious .... but the result I
get is:

-----------------------------------------
mroute_extract_in_addr_t:
.LFB29:
	.cfi_startproc
	movb	$2, 2(%rdi)
	movb	$0, 3(%rdi)
	movb	$4, (%rdi)
	bswap	%esi
	movl	%esi, 4(%rdi)
	ret
	.cfi_endproc
-----------------------------------------

To test it:

    gcc -O1 -S -c mroute-test.c
    gcc -O1 -S -c mroute-test.c -DPATCHED

I've also tried -O2.  Without -O{1,2} I get a very different result,
which is expected as that's not optimized - but it is again identical -
regardless of which approach being used.  The reason might be that the
example which is clearly obvious in the blog post uses union.

Now ... I do recognise that the type-punned stuff is critical, in fact
my compiler does warn about it with -O2.  So I think moving over to
memcpy() makes sense ... So I do give this a Feature ACK.  But we need
to have some proper testing so we're sure we don't break anything.


--=20
kind regards,

David Sommerseth


--------------48EF88FE7F6F5DA6A267ED55
Content-Type: text/plain; charset=UTF-8;
 name="mroute-test.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="mroute-test.c"

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>

#define MR_MAX_ADDR_LEN 20
#define MR_ADDR_IPV4             2
#define MR_ADDR_MASK             3

struct mroute_addr {
  uint8_t len;      /* length of address */
  uint8_t unused;
  uint8_t type;     /* MR_ADDR/MR_WITH flags */
  uint8_t netbits;  /* number of bits in network part of address,
		       valid if MR_WITH_NETBITS is set */
  uint8_t addr[MR_MAX_ADDR_LEN];  /* actual address */
};


void
mroute_extract_in_addr_t (struct mroute_addr *dest, const in_addr_t src)
{
  dest->type =3D MR_ADDR_IPV4;
  dest->netbits =3D 0;
  dest->len =3D 4;
#ifndef PATCHED
#warning Unpatched version
  *(in_addr_t*)dest->addr =3D htonl (src);
#else
#warning PATCHED/memcpy version
  in_addr_t tmp_addr =3D htonl (src);
  memcpy(dest->addr, &tmp_addr, sizeof(uint32_t));
#endif
}

--------------48EF88FE7F6F5DA6A267ED55--

--xftFu09TT0dOABkU4r4NWsgG3vLQNResk--

--3qSEeEVOlawpWQJGOdlM0lDRqIlwCNVLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYBiWXAAoJEIbPlEyWcf3yxJMP/3zs45Ho+8vfBJpiD5NJbjI1
ejOTJsZDxmnEpgjnpjLutVL/p/dKUI1QqWnRNI8Z3nmEjYsopGSG6frOX12BehDB
O6K+YXR8pzBA5n87DMMDSWA/vT/FzYEnNYfnXsc07GoX7O3ZEnN/X6PztATOIqB1
P/dRk1X7A2BEHf9hS1PaGv7pTCjYaiP0K3cM6vBnXvpR/zJd3Z1AcGzN8fiyfwnl
bFQzlFhtHUNZnFkrmLzgvElu7bhlB78wouaDJu/K2MZcg1ywC2peqInyhK+deQPJ
Jge6O1jFSaDjuxQhUvomr/Zy1dpMDDSaksQv1+hj3JvYeNekVqSX1luzkbTfTMwx
yx1jh9WJwgLGd/cfc7UTedOhfXm8Xqepb04IM2By5Bk0kK5N12HqKuuPkNw+H2ov
rw/bNl5nZw0aSQKd9/6m1/KFZwzhjbsbMQ68ok6cXgv3ceCR/FbwdzqVMsIEBYYX
qp60aUAiKH+KPeXEB9y9Z2es6MiicwaIt4x1DQpWbeJJr7mfuZlU9zMeomHiRBHS
RvIfIdTu4QPBktYuiZVKcp6ttBxb1JCCwSqpRut7aUnisYiYwuGL2bqHn7P9llG1
mhYZqOW6xXO5iJTCyCDG0nW/pYNzh+0rSLJQngHpHJAvPhJlnWHbDMDAsYNMs1Y3
7xDJ8EnDsM/UZpoS/sIO
=vPn0
-----END PGP SIGNATURE-----

--3qSEeEVOlawpWQJGOdlM0lDRqIlwCNVLw--

