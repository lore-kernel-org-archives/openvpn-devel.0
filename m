Message-ID: <511CC1F1.6010409@...1114...>
Date: Thu, 14 Feb 2013 11:52:33 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF08D73B4E315C862E0E481AA"
Subject: [Openvpn-devel] RFC - Usefulness of the --tls-remote semantic
	warning
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF08D73B4E315C862E0E481AA
Content-Type: multipart/mixed; boundary="------------090906050600080601010704"

This is a multi-part message in MIME format.
--------------090906050600080601010704
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Hi,

This is just a minor issue which has been annoying me a little bit.
I've attached a patch which ensures that the --tls-remote semantic
warning is only printed once.

However, I wonder how useful that warning really is these days.  Do
we really need that warning?  The warning comes from this commit [1]:

commit c04bc0223c9b17f203555b933cbeedbf3b343c0e
Author: james <james@...1807...>
Date:   Sun Jul 27 18:20:52 2008 +0000

    Added additional warnings for:
=20=20=20=20
    * --tls-remote -- some people misunderstand the semantics
=20=20=20=20
    * --script-security -- warn if script-security will allow user-defined
      scripts to be called, and also warn separately if passwords may be
      passed to scripts via the environment
=20=20=20=20
It's from 2008.  I see that in some cases this warning is needed, but I
also think people need to read the man pages when things doesn't work as
expected.  Not that we need to hand-hold people the whole way through.

If we find that all of these warnings are not that useful any more, I'd
rather suggest that we revert the commit above.  Otherwise we can also
consider to just remove the --tls-remote warning completely.

Any thoughts?


[1] <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-=
testing.git;a=3Dcommitdiff;
h=3Dc04bc0223c9b17f203555b933cbeedbf3b343c0e>


--=20
kind regards,

David Sommerseth

--------------090906050600080601010704
Content-Type: text/x-patch;
	name="0001-Only-warn-about-tls-remote-semantic-once.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Only-warn-about-tls-remote-semantic-once.patch"

=46rom 1d41a081c299b9839796b0c145217b7d7d3064b9 Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@...1347...>
Date: Thu, 14 Feb 2013 11:40:24 +0100
Subject: [PATCH] Only warn about --tls-remote semantic once

Avoid repeating this message over and over again in log files due to
reconnections.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/init.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 25d8225..5e6d0bf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2413,6 +2413,7 @@ static void
 do_option_warnings (struct context *c)
 {
   const struct options *o =3D &c->options;
+  static int warned_tls_semantic =3D 0;
=20
   if (o->ping_send_timeout && !o->ping_rec_timeout)
     msg (M_WARN, "WARNING: --ping should normally be used with --ping-re=
start or --ping-exit");
@@ -2471,8 +2472,10 @@ do_option_warnings (struct context *c)
       && !(o->ns_cert_type & NS_CERT_CHECK_SERVER)
       && !o->remote_cert_eku)
     msg (M_WARN, "WARNING: No server certificate verification method has=
 been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
-  if (o->tls_remote)
+  if (!warned_tls_semantic && o->tls_remote) {
+    warned_tls_semantic =3D 1;
     msg (M_WARN, "WARNING: Make sure you understand the semantics of --t=
ls-remote before using it (see the man page).");
+  }
 #endif
 #endif
=20
--=20
1.7.10.2


--------------090906050600080601010704--

--------------enigF08D73B4E315C862E0E481AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEcwfQACgkQDC186MBRfrrU0ACbBbVh/QrfFMQs5sjFYhMdnRBu
nTYAn0fM7/QrBxbyWUXHTOGBIjkKB2gp
=ROdV
-----END PGP SIGNATURE-----

--------------enigF08D73B4E315C862E0E481AA--

