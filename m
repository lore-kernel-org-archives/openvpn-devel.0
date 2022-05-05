Date: Thu, 5 May 2022 13:41:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YnO4BuuvhxW605CO@...1296...>
References: <20220502154310.836947-1-arne@...1227...>
 <202205051018.245AIBoB006285@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FtfUxVV70BWphpDK"
Content-Disposition: inline
In-Reply-To: <202205051018.245AIBoB006285@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement stateless
 HMAC-based sesssion-id three-way-handshake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--FtfUxVV70BWphpDK
Content-Type: multipart/mixed; boundary="l5t6XCzIu3UKItul"
Content-Disposition: inline

--l5t6XCzIu3UKItul
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 05, 2022 at 12:18:11PM +0200, Gert Doering wrote:
> All the comments and whitespace bits have been fixed-on-the-fly
> as instructed.  I have also fixed the "Return *true* if this packet..."
> comment before do_pre_decrypt_check() and rewrapped the very long
> comment lines in mudp.c (why did uncrustify not find this?).

I should not have done that, because my tree wasn't set up properly
with pre-commit-check yet - so I introduced new whitespace errors.

These have been fixed in a followup commit, which (it is only whitespace)
I'm not running through the formal process.

The patch is appended below.  It's committed as=20

commit 3282632d9325267c850072db7545a884a1637f51 (HEAD -> master)
Author: Gert Doering <gert@...1296...>
Date:   Thu May 5 13:38:12 2022 +0200

    Fix trailing-whitespace errors in last patch.
=20=20=20=20
    When rewrapping comments and a single code line in b364711486dc6,
    some trailing whitespace escaped.  Fix.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>


sorry,
gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--l5t6XCzIu3UKItul
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-trailing-whitespace-errors-in-last-patch.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 3282632d9325267c850072db7545a884a1637f51 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Thu, 5 May 2022 13:38:12 +0200
Subject: [PATCH] Fix trailing-whitespace errors in last patch.

When rewrapping comments and a single code line in b364711486dc6,
some trailing whitespace escaped.  Fix.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mudp.c | 6 +++---
 src/openvpn/ssl.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5eb1896c..81f36a45 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -178,8 +178,8 @@ multi_get_create_instance_udp(struct multi_context *m, =
bool *floated)
             if (do_pre_decrypt_check(m, &state, real))
             {
                 /* This is an unknown session but with valid tls-auth/tls-=
crypt
-                 * (or no auth at all).  If this is the initial packet of =
a=20
-                 * session, we just send a reply with a HMAC session id an=
d=20
+                 * (or no auth at all).  If this is the initial packet of a
+                 * session, we just send a reply with a HMAC session id and
                  * do not generate a session slot */
=20
                 if (frequency_limit_event_allowed(m->new_connection_limite=
r))
@@ -191,7 +191,7 @@ multi_get_create_instance_udp(struct multi_context *m, =
bool *floated)
                         mi->did_real_hash =3D true;
                         multi_assign_peer_id(m, mi);
                     }
-                    /* If we have a session id already, ensure that the=20
+                    /* If we have a session id already, ensure that the
                      * state is using the same */
                     if (session_id_defined(&state.server_session_id)
                         && session_id_defined((&state.peer_session_id)))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5b0cdcaa..37eee8b9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1285,7 +1285,7 @@ tls_auth_standalone_init(struct tls_options *tls_opti=
ons,
     /* get initial frame parms, still need to finalize */
     tas->frame =3D tls_options->frame;
=20
-    packet_id_init(&tas->tls_wrap.opt.packet_id, tls_options->replay_windo=
w,=20
+    packet_id_init(&tas->tls_wrap.opt.packet_id, tls_options->replay_windo=
w,
                    tls_options->replay_time, "TAS", 0);
=20
     return tas;
--=20
2.36.0


--l5t6XCzIu3UKItul--

--FtfUxVV70BWphpDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJic7gGAAoJEB2Cnv7KVigSksUL/1uCqX5DvN5kY+ugmQnDDSQl
RZdjWKy5aAzlB8SHxB8SGyTIU2ai9kuFbMTRhBE7AlxB9Px1NeptmpvAVsWldvEa
lZD1aIBotpgKIr2Za1yc9HOcwrGS3Nd4UJFLV/dsYtOWLXLTBVTRKgSxERWZLH4m
/5QgZLs6G/R7DimKBkxRM2cxEYEzXjYCBPW60SWBkg8wvdHRpshRFUxfe6IfC02j
n2RxSCDrR8u3n9vhAH4hpHvQWlXnM34Hg3a66Ov045f7ITcETgYXx6JxigmjQsTP
2G1WKG16Pxbc8wmdgAa3ULcIpRbmImE0o/Z2efQHoXa0RvKIAai0B3n/uCK1lZjC
95W3/uc6e1LgSBqGLZLrtZJ3XISktdF77djmzS/e+DVZrYluo29ktSEJUZH66/xx
W4y7caoUsLnYw2J4pCMAj7zBkrdWruIgsdWaPAGXjtIxwRwUzTmRndDLux6ds2zp
xxsCEqQSuGRMLqouP0e0t1GP57eBOoIw+CM6DiCBOQ==
=XDU3
-----END PGP SIGNATURE-----

--FtfUxVV70BWphpDK--

