Date: Sat, 19 Dec 2015 11:58:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151219105837.GX24952@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bul0XA1GBm3LpcnT"
Content-Disposition: inline
Subject: [Openvpn-devel] documentation: cherry-pick two polarssl fixes to 2.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Bul0XA1GBm3LpcnT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Steffann just notified me of two master/ fixes that should have gone
to release/2.3 as well - removing unused variables and fixing dead code
in the polarssl bits.  Usually I'd just put the note "also applied to 2.3"
in the commit-and-push reply mail, but that was quite a while ago - so,
git log and diff here, for full transparency regarding code changes.

gert

commit 2b9b3e598dc5bedc638ebc0a1877b36224398f0f
Author: Yegor Yefremov <yegorslists@...1030...>
Date:   Sun Nov 23 13:21:43 2014 +0100

    polarssl: fix unreachable code
=20=20=20=20
    Found via cppcheck and compile-tested.
=20=20=20=20
    Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
    Acked-by: Steffan Karger <steffan.karger@...1435...>
    Message-Id: <1416745303-23641-1-git-send-email-yegorslists@...1030...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9266
    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit 98c5de769d6bcd4822b2fd81ae4f4b05edff5c0e)

commit 029138790b00df54ec98eec04e05b494bcf30a94
Author: Steffan Karger <steffan@...1856...>
Date:   Sun Jan 12 20:39:31 2014 +0100

    Remove unused variables from ssl_verify_polarssl.c's x509_get_serial()
=20=20=20=20
    Signed-off-by: Steffan Karger <steffan@...1856...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1389555572-6210-3-git-send-email-steffan@...1856...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/8222
    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit 7a85a6fafacba186ae2fc495d32e159ea9a57e0e)


diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 562ace0..32566e4 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -815,8 +815,8 @@ key_state_write_plaintext (struct key_state_ssl *ks, st=
ruct buffer *buf)
=20
   if (0 =3D=3D buf->len)
     {
-      return 0;
       perf_pop ();
+      return 0;
     }
=20
   retval =3D ssl_write(ks->ctx, BPTR(buf), buf->len);
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_pol=
arssl.c
index 3a1ef48..c39fc7c 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -127,8 +127,6 @@ x509_get_username (char *cn, int cn_len,
 char *
 backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
-  int ret =3D 0;
-  int i =3D 0;
   char *buf =3D NULL;
   size_t buflen =3D 0;
   mpi serial_mpi =3D { 0 };
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Bul0XA1GBm3LpcnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnU3+qkuBuNlUUl1AQIFJQQAmxbZzaT6NsODlQXZjzK4wNoB95aUupRN
3+gPCCuP69/y4hq8VideHdrg4BKD1tnMdUjdQbCAYcjCQO7zip4qA8FrS5vi4SKN
gBgcEk0b85G+6ksNjTQxcvEtR2bWvaluHD7rG0YOyY3b++Pqep1qM1AMYwiNir1q
o6MdBU0dN0w=
=XHZ7
-----END PGP SIGNATURE-----

--Bul0XA1GBm3LpcnT--

