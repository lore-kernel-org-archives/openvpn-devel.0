Date: Wed, 20 Jun 2018 17:53:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180620155301.GY57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KGa77y161pGt+fQU"
Content-Disposition: inline
In-Reply-To: <20180613141213.5962-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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

--KGa77y161pGt+fQU
Content-Type: multipart/mixed; boundary="ItuD4UcHtAunF/cq"
Content-Disposition: inline

--ItuD4UcHtAunF/cq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 13, 2018 at 10:12:13PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> This patch ensures that the TAP driver on a windows host is still
> configured, even though no IPv4 has been provided.
>=20
> In this case the TAP driver ioctl will be invoked with a fake
> 0.0.0.0/0.0.0.0 IPv4 which will simply start the interface and
> get it to a working state.
>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>

Well...

> @@ -2642,7 +2642,11 @@ test_routes(const struct route_list *rl, const str=
uct tuntap *tt)
>          ret =3D true;
>          adapter_up =3D true;
>=20=20
> -        if (rl)
> +        /* we do this test only if we have IPv4 routes to install, and if
> +         * the tun/tap interface has seen IPv4 ifconfig - because if we
> +         * have no IPv4, the check will always fail, failing tun init
> +         */
> +        if (rl && c->c1.tuntap->did_ifconfig_setup)

This code is a bit optimstic :-) - there is no "c" here...

route.c: In function 'test_routes':
route.c:2649:19: error: 'c' undeclared (first use in this function)
         if (rl && c->c1.tuntap->did_ifconfig_setup)
                   ^

... because it's just "tt" here, so "tt->did_ifconfig_setup" should
be fine...  at least it compiled :-) - I've sent you a link to an=20
installer for testing.

Amended patch attached

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ItuD4UcHtAunF/cq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-windows-properly-configure-TAP-driver-when-no-IPv4-i.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 7fd30a4c131fa8e45a972b7f312b651bd38f784b Mon Sep 17 00:00:00 2001
=46rom: Antonio Quartulli <antonio@...515...>
Date: Wed, 13 Jun 2018 22:12:13 +0800
Subject: [PATCH] windows: properly configure TAP driver when no IPv4 is
 configured

This patch ensures that the TAP driver on a windows host is still
configured, even though no IPv4 has been provided.

In this case the TAP driver ioctl will be invoked with a fake
0.0.0.0/0.0.0.0 IPv4 which will simply start the interface and
get it to a working state.

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>

Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20180613141213.5962-1-a@...2181...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17=
052.html
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c |  6 +++++-
 src/openvpn/tun.c   | 24 +++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8990a986..f6962848 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2642,7 +2642,11 @@ test_routes(const struct route_list *rl, const struc=
t tuntap *tt)
         ret =3D true;
         adapter_up =3D true;
=20
-        if (rl)
+        /* we do this test only if we have IPv4 routes to install, and if
+         * the tun/tap interface has seen IPv4 ifconfig - because if we
+         * have no IPv4, the check will always fail, failing tun init
+         */
+        if (rl && tt->did_ifconfig_setup)
         {
             struct route_ipv4 *r;
             for (r =3D rl->routes, len =3D 0; r; r =3D r->next, ++len)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2e1c96e6..f9b9c716 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5703,7 +5703,10 @@ open_tun(const char *dev, const char *dev_type, cons=
t char *dev_node, struct tun
             msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
         }
=20
-        if (tt->topology =3D=3D TOP_SUBNET)
+        /* send 0/0/0 to the TAP driver even if we have no IPv4 configured=
 to
+         * ensure it is somehow initialized.
+         */
+        if (!tt->did_ifconfig_setup || tt->topology =3D=3D TOP_SUBNET)
         {
             in_addr_t ep[3];
             BOOL status;
@@ -5716,12 +5719,19 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun
                                      ep, sizeof(ep),
                                      ep, sizeof(ep), &len, NULL);
=20
-            msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet mod=
e network/local/netmask =3D %s/%s/%s [%s]",
-                print_in_addr_t(ep[1], IA_NET_ORDER, &gc),
-                print_in_addr_t(ep[0], IA_NET_ORDER, &gc),
-                print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
-                status ? "SUCCEEDED" : "FAILED");
-
+            if (tt->did_ifconfig_setup)
+            {
+                msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet=
 mode network/local/netmask =3D %s/%s/%s [%s]",
+                    print_in_addr_t(ep[1], IA_NET_ORDER, &gc),
+                    print_in_addr_t(ep[0], IA_NET_ORDER, &gc),
+                    print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
+                    status ? "SUCCEEDED" : "FAILED");
+            }
+            else
+            {
+                msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN with f=
ake IPv4 [%s]",
+                    status ? "SUCCEEDED" : "FAILED");
+            }
         }
         else
         {
--=20
2.17.1


--ItuD4UcHtAunF/cq--

--KGa77y161pGt+fQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKnhdAAoJEB2Cnv7KVigSN0sMAJXMxtox2cCmHHM7eouApY8H
8FKoclI7Xkkig+OFfC87kFwzgxxr3E57NRwme83CBVToXuazfeCD6lgLqh4Wxcp5
+VC6eowFJOzYZFrUKdWycfGC591aRCkZja3ZD4X5FHPKQrdDWQjCSMkOuXjWRHaQ
vkadXD4qTpca6Vn0hwo6v5p886fJqhdaQ1a08XK/ja6Oh6PBoVd6Y0xvqetPoOUA
3VXj8WDfpw/qRp80uZdKZw7jHqQqtafY5LnDr2/GXvRWSjezEcLsfsczA2xxm7Rj
Fbjd+ttIktCqPzfUphZFoMoARVIkbLclpfNchaCnbmQKzLK7K93RrrSj6veOUN22
9iWViU1WZn1obVNvdRY6eaCfuLEvY7Dfybmd1bxLe42YcY2Iesnbb2GucuG1Dlm2
+x7em1lkeZjxtIKyUSPnrqb3ZmEw3rvwKfnq5JyhGhh+r2tFnvkWY4J/nH5dprQS
EAcOozBNw6k2WNoB852qESdbfOmxQkSn9/rs4xRCcA==
=e+Jk
-----END PGP SIGNATURE-----

--KGa77y161pGt+fQU--

