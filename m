Date: Tue, 20 Feb 2018 15:35:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220143502.GL69387@...1296...>
References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
 <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
 <663a0e1d-0d21-6f40-851e-78d770bec68f@...1147...>
 <CAKuzo_i4Ge=3cbg3zZY61ps+wDi8eCC1M4dopNJKGoB-LmT0Qw@...278...>
 <cba28408-81d0-5295-c882-f4bfdfcc20c3@...1147...>
 <CAKuzo_gCvfSYi+u4XJd88te-B_XbW1AkEQ3LxsuHaAH29EDVrw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+Ccw6gpuJ1V99M/T"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gCvfSYi+u4XJd88te-B_XbW1AkEQ3LxsuHaAH29EDVrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
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
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+Ccw6gpuJ1V99M/T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 26, 2018 at 10:26:58AM -0500, Selva Nair wrote:
> The mystery (at least for me)  is where that host part is coming
> from... Its zeroed out before setting the route, and I thought the
> same (?) route list pointer is
> passed in while deleting routes.

So.  Staring a bit at the code (while sf.net is refusing to forward my
last mail to patchwork... so I can't go ahead and commit & close more
patches).

The clearing of the route happens in=20

route.c: route_ipv6_clear_host_bits()

which is only called from add_route_ipv6().

route_ipv6_clear_host_bits() does clear the "call by reference" route_ipv6=
=20
structure, though, so it really should bubble up the call chain to
add_routes(), zeroeing out the bits in the "rl6->routes_ipv6" IPv6 route
list.

Testing this on linux with "--route-ipv6 2001:db8::1234:abcd/112" I can=20
see that this seems to work correctly...

Tue Feb 20 15:19:02 2018 add_route_ipv6(2001:db8::1234:0/112 -> fd00:abcd:1=
94:4::1 metric -1) dev tap3
Tue Feb 20 15:19:02 2018 /bin/route -A inet6 add 2001:db8::1234:0/112 dev t=
ap3 gw fd00:abcd:194:4::1

Tue Feb 20 15:19:15 2018 delete_route_ipv6(2001:db8::1234:0/112)
Tue Feb 20 15:19:15 2018 /bin/route -A inet6 del 2001:db8::1234:0/112 dev t=
ap3 gw fd00:abcd:194:4::1

(just grabbing a random test config, "tap" has no significance here, works=
=20
the same with "tun")


"master" behaves the same here as release/2.4.


Re-reading the thread, I can now see where this is coming from - this=20
is not "normal routes" but "on-link interface routes", and this is=20
something that got broken on introducing the iservice (where the zeroeing
of the host bits was changed from "zap the local copy" to "zap the=20
upstream copy, and do not zap it in delete_route() again, because, not=20
needed") - commit a24dd2e31.


The on-link route is installed by tun.c:add_route_connected_v6_net(),
which operates on a on-stack instance of "struct route_ipv6"...

void
add_route_connected_v6_net(struct tuntap *tt,
                           const struct env_set *es)
{
    struct route_ipv6 r6;

    CLEAR(r6);
    r6.network =3D tt->local_ipv6;
    r6.netbits =3D tt->netbits_ipv6;
    r6.gateway =3D tt->local_ipv6;
    r6.metric  =3D 0;                     /* connected route */
    r6.flags   =3D RT_DEFINED | RT_METRIC_DEFINED;
    add_route_ipv6(&r6, tt, 0, es);
}

... so the zero'ing in add_route_ipv6() does not "stick".

On termination, we call delete_route_connected_v6_net(), which sets up
a new "route_ipv6" copy... with all bits set.


Jan Just, could you please test the following patch?  This will explicitly
clear the host bits for the "on-link" route again.

Fully untested :-)

gert


diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ebb15bd3..79453665 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -839,6 +839,7 @@ delete_route_connected_v6_net(struct tuntap *tt,
     r6.gateway =3D tt->local_ipv6;
     r6.metric  =3D 0;                     /* connected route */
     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
+    route_ipv6_clear_host_bits(&r6);
     delete_route_ipv6(&r6, tt, 0, es);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_N=
ETBSD) || defined(TARGET_OPENBSD) */
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--+Ccw6gpuJ1V99M/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajDIWAAoJEB2Cnv7KVigSwdcMAISF4AiS/G/jq/6ogfVgTvsi
uMp4CLOnnG5b5PkNItbXPnsohzkx/bd2fcqisBzteD+ROTGOdblxMCoUv5B/WTgE
39FG8VEEyN8aWMRZtGzbb8Uzi5doImmD82WyWOQdd3jo9h1EbM5A4qgaNtwREb5M
hbJf7h9ijMwOYDtXPlOz/tRCF7kZXOzo62Uvgr8bGyi5Nb79imZT2uyGJV+IaUok
TZ2wTMkE5ui0e/dp3hrTBgl5KNZVG7qwJAda6JeImGym3w8v3L4GUvf6JpPcAYZN
40i1lWou6ND9apxSAOvrKKw202nR0E+hYDquIzxcCS8lW4aRXAm4Ce0HsnYoJMVV
6e6OmG+2wwXoZ8D+BGquJXRgEbUCnLrvB9VkR11ctFGmhaC+AshAxrAMklHYgm5I
GwzP0jxmmI0Yv6T6s2YD9xSbCTpEp7G7ZQVzzixoVm9X/jDFC+hmYsJjxrdGiPzf
qZB+ogyyf8fy/LSqSoV5H6ovgjNBGZ1q2F4SVVLryA==
=BxYF
-----END PGP SIGNATURE-----

--+Ccw6gpuJ1V99M/T--

