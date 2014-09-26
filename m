Message-ID: <54259015.2030005@...1921...>
Date: Fri, 26 Sep 2014 18:11:01 +0200
From: Philipp Hagemeister <phihag@...1921...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="VwFdbpuh9sN9xIlK579ECHbb5qQGvRjQd"
Subject: [Openvpn-devel] [PATCH] Implement on-link route adding for iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VwFdbpuh9sN9xIlK579ECHbb5qQGvRjQd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Currently, when compiling with --enable-iproute2 , OpenVPN does not
create a correct route when the user is connected to the Internet
without a gateway (e.g. via ppp). This patch implements the
corresponding FIXME.

Signed-off-by: Philipp Hagemeister <phihag@...1921...>
---
 src/openvpn/route.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 5428e76..a06c841 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1285,15 +1285,18 @@ add_route (struct route_ipv4 *r,

 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
-  /* FIXME -- add on-link support for ENABLE_IPROUTE */
-  argv_printf (&argv, "%s route add %s/%d via %s",
-             iproute_path,
+  argv_printf (&argv, "%s route add %s/%d",
+             iproute_path,
              network,
-             count_netmask_bits(netmask),
-             gateway);
+             count_netmask_bits(netmask));
+
   if (r->flags & RT_METRIC_DEFINED)
     argv_printf_cat (&argv, "metric %d", r->metric);

+  if (is_on_link (is_local_route, flags, rgi))
+    argv_printf_cat (&argv, "dev %s", rgi->iface);
+  else
+    argv_printf_cat (&argv, "via %s", gateway);
 #else
   argv_printf (&argv, "%s add -net %s netmask %s",
               ROUTE_PATH,
--=20
2.1.1


--VwFdbpuh9sN9xIlK579ECHbb5qQGvRjQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUJZAVAAoJENtLVMukgmoYetkQAKUmxm8uWGZA93/OWUIsaKqy
iFJEhud2gFoS17fIQiNtaa2nCpX1zT1l4Gnq/iNmf6N1jG3StgQvl4LKfHbuE7Km
8Jds30DjWppzf1LZkL1EyQe6P5hplVzQDDze7xfdzq1NwRDhclyevKPiEBVISGx6
OTcq+3Q1QUH+s4uZYF2US7kg8UTrroDZtd7g2Q4qcJUAqxbbRpggCXphezlfxvuH
4A86NFVBjCsk5zLcQVQd1QlQmjGUAN1R46Af2/2Z5rAET38lMeG6i4dijP60NqIN
DkDcrz3Rv1yKOY8zvGeFKDVz7yuVEr3o5ubrOaJX3pyeAamol7UzjCBBW3VjXbDa
GmSCVNbgonNrTOZGMYuTw8Gb0AK7evJwyplwp12unxmUl8a0rcBEELcNaq2ROubk
zwfdakoEQONWRX2ohIu7V3zHnw2Spe7nP5aIX9XRfxN7vSjvMZgq9eY+/2kft2y+
AxU79+5a5L3XQ3DtiOkqe801vCVU53fBqTKPMyecxCEwzcypD6k2JOzvlhGD0nLV
vjsLCO8qCAjrZ/55C9+YNN97kI5hQyCqWIFn1NWk3l1TGgYYEJfFmG4Lz2kMX/JZ
/JsEtt7dyVN5B4fiO1QYfMXl9spJ/VKYdTajqL994qM9u63KSJcip47yYKnYKsG0
G8gtn5dVW2qRCHYtwJ5C
=ZjcH
-----END PGP SIGNATURE-----

--VwFdbpuh9sN9xIlK579ECHbb5qQGvRjQd--

