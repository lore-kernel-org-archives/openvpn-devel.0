Date: Tue, 16 Jul 2019 21:34:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190716193424.GV1097@...1296...>
References: <20190714200227.GG1097@...1296...>
 <20190715144609.19616-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RS1722//baS0C3Tp"
Content-Disposition: inline
In-Reply-To: <20190715144609.19616-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5] route.c: use sitnl to implement
 get_default_gateway_ipv6()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--RS1722//baS0C3Tp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 15, 2019 at 04:46:09PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> get_default_gateway_ipv6() has always been implemented using
> netlink, however, now that we have sitnl, we can re-use the
> latter and get rid of the netlink code from route.c.
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>

Yeah, thanks.

This particular patch is ok now, but it is calling functions that are
no save to call.  So, fixing needed.  (I considered on whether to
NAK this again, but since it is safe *today*, this is more for the
work queue of cleanup to do).


Down in networking_sitnl.c, in sitnl_route_best_gw(), you do

    strcpy(best_iface, res.iface);

which *today* is safe, because best_iface is "char[16]" and=20
res.iface is "char[IFNAMSIZ]", which happens to be 16 on linux
*today*.  Now what if folks decide "we need longer names, because
docker? or anything?" - bam.  This needs to be a strncpy().  Or
"struct route_ipv6_gateway_info" -> iface needs to be [IFNAMSIZ]=20
with an preceding "#ifndef IFNAMSIZ, #define IFNAMSIZ 16" for=20
platforms that do not have said define...

Or something else to guarantee that you never overflow *best_iface.


Then, I'm a bit sad that your sitnl_route_best_gw() code pretty much
lacks all documentation about what it *does*.  My code in route.c that
talks to netlink had quite a bit of explanations on "why a certain value=20
is set in a certain way"...

    rtreq.nh.nlmsg_type =3D RTM_GETROUTE;
    rtreq.nh.nlmsg_flags =3D NLM_F_REQUEST;       /* best match only */
    rtreq.rtm.rtm_family =3D AF_INET6;
    rtreq.rtm.rtm_src_len =3D 0;                  /* not source dependent */
    rtreq.rtm.rtm_dst_len =3D 128;                /* exact dst */
    rtreq.rtm.rtm_table =3D RT_TABLE_MAIN;
    rtreq.rtm.rtm_protocol =3D RTPROT_UNSPEC;

while your code leaves off initialization for "anything that is default
anyway" and just magically copies in values for the rest - including
"0" for "rtm_dst_len" (both callers pass in "0" for prefixlen, which
doesn't match the documentation I've read, back then, that says you must=20
pass in a full prefix length for an exact route match - and if you pass
in 0 anyway, why carry a prefixlen argument at all??).

The rtm_dst_len puzzles me, to be honest...  either I misread the
documentation, or this is ignored by the kernel...  the way I understood
this, it's the number of bits that is matched in the address, so "0"
would pretty much mean "match any route" - but what it returns is
correct, so it's not doing "match any".  *scratch head*.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--RS1722//baS0C3Tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdLia/AAoJEB2Cnv7KVigSOYkL/jCHETOHtzRkS+oz7KTG27uF
fr017Uvc5JTeTWMOa1CMq2f1u3jCChd6Eksk5fNu7ighYr0PrZtX335M54E367r0
UdZfREA0/PCb6+2NnuVpNZzy9NeKA89Xb6MyPSzJydntdBoUWYuLonRiNLvctzzH
DJdHRKGGTDXAykBAHKweV85+5Mf3bRbhFoywu9RFFggIgj8zNDYYqMOJe8woaNPA
Rn1AK9LSNkaWa9usljOJEd3Q2X+Hy6+ImDTFiZt1tuDGErFA3At/z0NuT5+1mJSg
wGNi5Gk50vqb49pw4aU2Qm9rPbqARn22RRhoiZ9qSZf3xV54+aJnBwYEV5vsadGp
LFuaGbyOxbeiCltwHBcX8Cf3JfR08g+rjGYL+7WxjJuJIBDSISFNTqvb0yHLU9nz
9AqV5i2omsILATumBzUgeMI2kIcykzqdev1wQi4OZ1U37kXpg9TZKztvaJbmELxx
8nadcnDOLU8I0jnYFhkJWJCt5r4dFt9LvcsPFyPjrA==
=XCPr
-----END PGP SIGNATURE-----

--RS1722//baS0C3Tp--

