From: Josh Cepek <josh.cepek@...1085...>
Date: Thu, 22 Aug 2013 02:24:56 -0500
Message-ID: <kv4ece$s8s$1@...1062...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="H0d0KEvO70Sfokwm7GJ01xDoKhP0S3W5d"
Subject: [Openvpn-devel] [PATCH] Correct error text when no Windows TAP
	device is present
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
--H0d0KEvO70Sfokwm7GJ01xDoKhP0S3W5d
Content-Type: multipart/mixed; boundary="------------060709070808050903080907"

This is a multi-part message in MIME format.
--------------060709070808050903080907
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Patch/description attached; this resolves bug #320.

On an unrelated note, I'm trying out OpenPGP/MIME (RFCs 4880 & 3156) in
this submission since it appears the only non-broken way to sign
patches. Sane clients should eat this fine (Outlook Express may not.) If
this poses a particular problem for you or an archiving service (sf.net,
gmane, etc) I'd like to know about it.

--
Josh Cepek

--------------060709070808050903080907
Content-Type: text/x-diff;
 name="win-tap-err-text.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="win-tap-err-text.patch"

=46rom 24be21ea2f1d02631685a0a11bf187372cf10fa4 Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Wed, 21 Aug 2013 16:20:30 -0500
Subject: [PATCH] Correct error text when no Windows TAP device is present=


Starting with the 2.3-series, the TAP-Windows driver/utilities and
OpenVPN are separately installed components. The error message given to
users without available TAP devices uses the pre-2.3 path that does not
exist. The path should be listed under the TAP-Windows program group
that the tap-windows project installer uses.

Resolves bug #320

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 src/openvpn/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f0ea2c4..86a43f2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3403,7 +3403,7 @@ static void
 at_least_one_tap_win (const struct tap_reg *tap_reg)
 {
   if (!tap_reg)
-    msg (M_FATAL, "There are no TAP-Windows adapters on this system.  Yo=
u should be able to create a TAP-Windows adapter by going to Start -> All=
 Programs -> " PACKAGE_NAME " -> Add a new TAP-Windows virtual ethernet a=
dapter.");
+    msg (M_FATAL, "There are no TAP-Windows adapters on this system.  Yo=
u should be able to create a TAP-Windows adapter by going to Start -> All=
 Programs -> TAP-Windows -> Utilities -> Add a new TAP-Windows virtual et=
hernet adapter.");
 }
=20
 /*
--=20
1.8.1.5


--------------060709070808050903080907--

--H0d0KEvO70Sfokwm7GJ01xDoKhP0S3W5d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSFbzVAAoJENcx2Xpgb9RjhDkMAJJKeDQbX5KpERiU9fHdMomC
kWqmfUM6RvH8hNOVa5OlslKuFQuVXj9h5LQSXQFMLlDdYj7Jf/b9TWVIEWJs0Tgh
xbrg+YmD57ct2ZLxv8kE31BKAScUngZZn9JuwhQixeyOUWyFa79O2nBbBvnC+iw9
VK7EEtGoVuLZC0dRhYMhsgvVitLriuL6Gc7tqs1aif2u0T92KWSFONjV/YEvAPHn
j03GE28vNR4KTkGS9SqbrkbHfxhT7p3y5otN23KK7AjSx5WkWK2XKaV2ncWK58x7
220g6NQpAZtFH4Upr66yA6gTtwDfJ1IuSggptpwZ7k8YHma29GsCgw1C3ayBp1aD
jbT7+boIvNz8L/Q760uEb39XJ92D+E/h61nAN5/OjozJBttat39ZOw1djB5MJTEU
3fAF2mRgfQ5U5xhoc6vBiDwkXMxgrYo5nFNNLHZCQJRGEe2hqZLw2NnrMFmqOOX1
LLa5LdhR0Ic5BMPs68oM6sNOCNE4aDqyTmQSXVODHA==
=+etE
-----END PGP SIGNATURE-----

--H0d0KEvO70Sfokwm7GJ01xDoKhP0S3W5d--


