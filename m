Message-ID: <53BF9998.5020906@...1921...>
Date: Fri, 11 Jul 2014 10:00:24 +0200
From: Philipp Hagemeister <phihag@...1921...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="9sRaQTumRfRHI0L728SrkV00L0xITJXw0"
Subject: [Openvpn-devel] [PATCH] Add topology in sample server configuration
	file
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
--9sRaQTumRfRHI0L728SrkV00L0xITJXw0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On modern systems, topology subnet should always be set, but it's
missing in the configuration file.
Add it with a short explanation.

Signed-off-by: Philipp Hagemeister <phihag@...1921...>
---
 sample/sample-config-files/server.conf | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sample/sample-config-files/server.conf
b/sample/sample-config-files/server.conf
index f483b6b..6a2b4c2 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -86,6 +86,13 @@ key server.key  # This file should be kept secret
 # 2048 bit keys.
 dh dh1024.pem

+# Network topology
+# Should be subnet (addressing via IP)
+# unless Windows clients v2.0.9 and lower have to
+# be supported (then net30, i.e. a /30 per client)
+# Defaults to net30 (not recommended)
+;topology subnet
+
 # Configure server mode and supply a VPN subnet
 # for OpenVPN to draw client addresses from.
 # The server will take 10.8.0.1 for itself,
--=20
2.0.1



--9sRaQTumRfRHI0L728SrkV00L0xITJXw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTv5mYAAoJENtLVMukgmoYLroQALZTkMiiPrrdldeRtEUx6h1z
O55MsdAy8+gBNYflKl/h6tFh5+xaBdKcXb8b8iCM/cQR+WOxRIWykDiTLUbf4f7+
VqigUfwy/ssOZGpi4ABSMxNFA6cJ25IBo123W8ZKoSG3P8M5XPQN0/8Tfvlbep5n
uhC2r1qE119pEULMfyLwhfZWqkipdjnkEDjSn3I2UbHVSj4xRsNFUceHpVmtZ0LR
NC/7B+7hzuFx3auDLtdDz/UBY6Xjp80OXejTQKZi4gNQr/ffcBahFQ6oOYgVVMYT
LMzWFplks5DnLHss4cgE6/flEthxrDcOxocsrDUmgByhmSbBHQzZ6h1x10xFVs8X
L/kv2vJqp/PgMSdA+68xjodSvrGMzWiqFmBQAo5fuuk+GQ2tLFznbJQXtpybSKk5
C6LQrl7egglQ9eIX2amBzEjZP+WkS1wEQtHdSpvKndyiBA05w/wIWKBmwGdS5Err
LQEHdMf2JXJIHaZ6fVKznnGSPru1+xYJ7yu/ksZjPhBCZlNNdTdMty0m71DXsZPz
yFctxQ17MouBdNT2MbdEWrP3Y3wIXzUiYOp1aaYh6eIefLPKj4MXieULrUQ3DZo1
DIsFtbFwMzD/sP2kgbviU5PBCmkK5fMujfVKJ1wJf/BXGz3EWuBjN2I085BsgbOC
Nx3EOGKzJjXlkA/z9czr
=o9uf
-----END PGP SIGNATURE-----

--9sRaQTumRfRHI0L728SrkV00L0xITJXw0--

