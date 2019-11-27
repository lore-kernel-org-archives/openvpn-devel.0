Date: Wed, 27 Nov 2019 13:43:38 +0000
From: Laurent Fasnacht <l@...2534...>
Reply-To: Laurent Fasnacht <l@...2534...>
Message-ID: <20191127134258.9162-1-l@...2534...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="---------------------3c8a33503b8801de3962a0dfaa5e805d";
 charset=UTF-8
Subject: [Openvpn-devel] [PATCH] Fix IPv6 configuration on Windows using
 netsh
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
-----------------------3c8a33503b8801de3962a0dfaa5e805d
Cc: Laurent Fasnacht <l@...2534...>
Date: Wed, 27 Nov 2019 14:42:58 +0100
From: Laurent Fasnacht <l@...2534...>
Message-Id: <20191127134258.9162-1-l@...2534...>
Mime-Version: 1.0
Subject: [PATCH] Fix IPv6 configuration on Windows using netsh
To: openvpn-devel@lists.sourceforge.net
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Apparently, `netsh interface ipv6 set address ...` defaults to using
a subnet of /64, and therefore adds an onlink route of that size.

When using a tun tunnel, the tap adapter only replies to neighbor
discovery packets for fe80::8. This leads to the unfortunate situation
where all the hosts in the /64 are not reachable.

This patch fixes that situation by specifying a /128 netmask, as the real
route is added afterwards, via the gateway.
---
 src/openvpn/tun.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 599fd817..8b054c80 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -982,15 +982,15 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,
     else
     {
         /* example: netsh interface ipv6 set address interface=3D42
-         *                  2001:608:8003::d store=3Dactive
+         *                  2001:608:8003::d/128 store=3Dactive
          */
         char iface[64];
=20
         openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu",
                          tt->adapter_index);
-        argv_printf(&argv, "%s%sc interface ipv6 set address %s %s store=
=3Dactive",
+        argv_printf(&argv, "%s%sc interface ipv6 set address %s %s/%d stor=
e=3Dactive",
                     get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
-                    ifconfig_ipv6_local);
+                    ifconfig_ipv6_local, 128);
         netsh_command(&argv, 4, M_FATAL);
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifn=
ame);
--=20
2.20.1


-----------------------3c8a33503b8801de3962a0dfaa5e805d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wmgEARYIABAFAl3efYgJEAlUWB7fcm8FAAoJEAlUWB7fcm8FISABAK32tAqV
BL6rDJUbP4gDOxZV7oukAIVHRj+WMkfJFxuRAP0YWqJCDnbM4rWkKwdE5QuA
o8p54NLq2VdKhpS8ThwcBw==
=HHlK
-----END PGP SIGNATURE-----


-----------------------3c8a33503b8801de3962a0dfaa5e805d--


