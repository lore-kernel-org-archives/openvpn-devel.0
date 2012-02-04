Date: Sat, 4 Feb 2012 18:21:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120204172156.GX13929@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Content-Disposition: inline
Subject: [Openvpn-devel] add ipv6 related env variables to openvpn.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ai3I8gwHc37+ASRI
Content-Type: multipart/mixed; boundary="tBhgiDt8dP1efIIJ"
Content-Disposition: inline

--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as discussed today.  Pretty much cut-and-paste from the ipv4 counterparts.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Document-IPv6-related-environment-variables.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 10d6580ad6ebe0e755a7eb164a327fdd6ce8917e Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1541...>
Date: Sat, 4 Feb 2012 18:18:45 +0100
Subject: [PATCH] Document IPv6-related environment variables.

(ifconfig_ipv6_local, ifconfig_ipv6_netbits, ifconfig_ipv6_remote,
route_ipv6_network_{n}, route_ipv6_gateway_{n})

Signed-off-by: Gert Doering <gert@...1296...>
---
 openvpn.8 |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 00acd01..42f98fa 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -5358,6 +5358,49 @@ normally occurs prior to
 script execution.
 .\"*********************************************************
 .TP
+.B ifconfig_ipv6_local
+The local VPN endpoint IPv6 address specified in the
+.B \-\-ifconfig-ipv6
+option (first parameter).
+Set prior to OpenVPN calling the
+.I ifconfig
+or
+.I netsh
+(windows version of ifconfig) commands which
+normally occurs prior to
+.B \-\-up
+script execution.
+.\"*********************************************************
+.TP
+.B ifconfig_ipv6_netbits
+The prefix length of the IPv6 network on the VPN interface.  Derived from
+the /nnn parameter of the IPv6 address in the
+.B \-\-ifconfig-ipv6
+option (first parameter).
+Set prior to OpenVPN calling the
+.I ifconfig
+or
+.I netsh
+(windows version of ifconfig) commands which
+normally occurs prior to
+.B \-\-up
+script execution.
+.\"*********************************************************
+.TP
+.B ifconfig_ipv6_remote
+The remote VPN endpoint IPv6 address specified in the
+.B \-\-ifconfig-ipv6
+option (second parameter).
+Set prior to OpenVPN calling the
+.I ifconfig
+or
+.I netsh
+(windows version of ifconfig) commands which
+normally occurs prior to
+.B \-\-up
+script execution.
+.\"*********************************************************
+.TP
 .B ifconfig_local
 The local VPN endpoint IP address specified in the
 .B \-\-ifconfig
@@ -5557,6 +5600,26 @@ than their names as denoted on the command line
 or configuration file.
 .\"*********************************************************
 .TP
+.B route_ipv6_{parm}_{n}
+A set of variables which define each IPv6 route to be added, and
+are set prior to
+.B \-\-up
+script execution.
+
+.B parm
+will be one of "network" or "gateway" ("netmask" is contained as "/nnn"
+in the route_ipv6_network_{n}, unlike IPv4 where it is passed in a separate
+environment variable).
+
+.B n
+is the OpenVPN route number, starting from 1.
+
+If the network or gateway are resolvable DNS names,
+their IP address translations will be recorded rather
+than their names as denoted on the command line
+or configuration file.
+.\"*********************************************************
+.TP
 .B peer_cert
 Temporary file name containing the client certificate upon
 connection.  Useful in conjunction with --tls-verify
--=20
1.7.6


--tBhgiDt8dP1efIIJ--

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTy1pNKkuBuNlUUl1AQIlwgP/dFTy0v17iasxZnanDRlKPfR90vRTWckT
e2ZDN9/dYaRTMekSQ0SAdwsgpXMFv3LIhHQFWc//BhCmMhi90m9oPOQXcTMgs4ri
L1bRn6eSrZUjv4B326OiMoX8a61N9sgTQ0BuXFiUdpDBbRie/tsf9rLfb6pjonZa
KKZWjk+33yU=
=SRMt
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--

