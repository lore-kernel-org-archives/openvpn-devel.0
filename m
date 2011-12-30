Date: Fri, 30 Dec 2011 21:48:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111230204838.GJ5060@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BfbbJsf3thGkpLcA"
Content-Disposition: inline
Subject: [Openvpn-devel] range-checking bug in route.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--BfbbJsf3thGkpLcA
Content-Type: multipart/mixed; boundary="o/5eNASeIIpuMggS"
Content-Disposition: inline

--o/5eNASeIIpuMggS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

when implementing the missing helpers for saving/restoring ipv6 route
option lists, I noticed that the existing code has safeguards against
buffer overruns, but they do not work in all circumstances.

Imagine:

 - source list: capacity =3D 20, n =3D 5 (only 5 items in there)
 - destination list: capacity =3D 10

the check was "src->n > dst->capacity", which is OK, but then the full
source list of "20 items" is copied over to dst - overrunning the memory.

Change to compare src->capacity to dst->capacity.  (We could change
the logic to copy only src->n items instead, and restore dst->capacity
later on, but that's just another way to fix things :) ).

Applies to master, on top of the previous patch.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--o/5eNASeIIpuMggS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-list-overrun-checks-in-copy_route_-ipv6_-option_.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 95597af44714ccd350e849a0fc14e89db7e1529e Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Fri, 30 Dec 2011 21:42:13 +0100
Subject: [PATCH] Fix list-overrun checks in copy_route_[ipv6_]option_list()

The old code checks how many items are in use(!) in the source
list, but then copies the full list over the destination memory
arena.  Check the source list *capacity*.

Signed-off-by: Gert Doering <gert@...1296...>
---
 route.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/route.c b/route.c
index e95292c..ce17f1f 100644
--- a/route.c
+++ b/route.c
@@ -121,8 +121,8 @@ void
 copy_route_option_list (struct route_option_list *dest, const struct route=
_option_list *src)
 {
   const size_t src_size =3D array_mult_safe (sizeof(struct route_option), =
src->capacity, sizeof(struct route_option_list));
-  if (src->n > dest->capacity)
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in =
src (%d) is greater than route list capacity in dest (%d)", src->n, dest->c=
apacity);
+  if (src->capacity > dest->capacity)
+    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in =
src (%d) is greater than route list capacity in dest (%d)", src->capacity, =
dest->capacity);
   memcpy (dest, src, src_size);
 }
=20
@@ -131,8 +131,8 @@ copy_route_ipv6_option_list (struct route_ipv6_option_l=
ist *dest,
 			     const struct route_ipv6_option_list *src)
 {
   const size_t src_size =3D array_mult_safe (sizeof(struct route_ipv6_opti=
on), src->capacity, sizeof(struct route_ipv6_option_list));
-  if (src->n > dest->capacity)
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in =
src (%d) is greater than route list capacity in dest (%d)", src->n, dest->c=
apacity);
+  if (src->capacity > dest->capacity)
+    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in =
src (%d) is greater than route list capacity in dest (%d)", src->capacity, =
dest->capacity);
   memcpy (dest, src, src_size);
 }
=20
--=20
1.7.3.4


--o/5eNASeIIpuMggS--

--BfbbJsf3thGkpLcA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTv4jpqkuBuNlUUl1AQJrEQQAu19u01LbS4wTbSqHh4VDeFsIpiHlzGRH
sXch5FPYli7CC8+Ajjqjf9gMKxFdpqtGWa/37n48DEHfbasd5K/Nn5YjTOtE1nRi
dlzRv72JDmxFLayCJ3qY1awbmPYdaU/GYnfHxvmaXRMVlUKmX6l2GyctCuYwhCn+
BI+V2dDsWBk=
=HLyh
-----END PGP SIGNATURE-----

--BfbbJsf3thGkpLcA--

