Date: Thu, 12 May 2022 08:55:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ynyva2Kt9n52YDvE@...1296...>
References: <20220503002840.295-1-lstipakov@...277...>
 <202205120632.24C6Wn76014604@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vT453ZjpIaSzzc5F"
Content-Disposition: inline
In-Reply-To: <202205120632.24C6Wn76014604@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix M_ERRNO behavior on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--vT453ZjpIaSzzc5F
Content-Type: multipart/mixed; boundary="jRwJxC6RrmwDJ2QP"
Content-Disposition: inline

--jRwJxC6RrmwDJ2QP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 12, 2022 at 08:32:49AM +0200, Gert Doering wrote:
> I have come late to the party, but really, code like this should be
> avoided:
>=20
> +        bool unreachable =3D error_code =3D=3D
> +#ifdef _WIN32
> +            WSAENETUNREACH;
> +#else
> +            ENETUNREACH;
> +#endif

Even worse, this is also uncrustify-noncompliant...  and I forgot to
double check.

I have fixed the whitespace errors introduced in the M_ERRNO patch
in commit 28557b50c6c9, as attached (and already pushed).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jRwJxC6RrmwDJ2QP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-non-compliant-whitespace-introduced-by-commit-54.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 28557b50c6c9354fa50b4a18374c064dc547ac25 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Thu, 12 May 2022 08:53:04 +0200
Subject: [PATCH] Fix non-compliant whitespace introduced by commit
 54800aa975418fe35.

Uncrustify fix.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/error.c   | 2 +-
 src/openvpn/error.h   | 2 +-
 src/openvpn/forward.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 1b7f5cde..49ed1dbc 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -220,7 +220,7 @@ x_msg(const unsigned int flags, const char *format, ...)
     va_end(arglist);
 }
=20
-static const char*
+static const char *
 openvpn_strerror(int err, bool crt_error, struct gc_arena *gc)
 {
 #ifdef _WIN32
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index be8d97e5..972619fe 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -399,7 +399,7 @@ openvpn_errno_maybe_crt(bool *crt_error)
         *crt_error =3D true;
         err =3D errno;
     }
-#else
+#else  /* ifdef _WIN32 */
     *crt_error =3D true;
     err =3D errno;
 #endif
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 04828a5c..6afe152b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1663,9 +1663,9 @@ process_outgoing_link(struct context *c)
=20
         bool unreachable =3D error_code =3D=3D
 #ifdef _WIN32
-            WSAENETUNREACH;
+                           WSAENETUNREACH;
 #else
-            ENETUNREACH;
+                           ENETUNREACH;
 #endif
         if (size < 0 && unreachable && c->c2.tls_multi
             && !tls_initial_packet_received(c->c2.tls_multi) && c->options=
=2Emode =3D=3D MODE_POINT_TO_POINT)
--=20
2.36.0


--jRwJxC6RrmwDJ2QP--

--vT453ZjpIaSzzc5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJifK9rAAoJEB2Cnv7KVigSvqkL/iQJBiKC30J05/cIfxtTmNP1
hiEkcOkUPwuAOeBunjPWo4eSIvA8BfJ3W90T9E7/F+9CYSkyBXIbqB2teaDVdgQT
xOod92JaDDFoxWeWs8wJTiYuMI42w1oShUQmQBssT/vUf51lSUdBdFzRPa04WRy5
mDviWnXsqzBxgrLnviOIcKmm0jEDn+2iHGMuwG7PNpzbTySClnKDQOEnp/nQ4wO7
8rBKqZFT0SCpXEERPwP1ZSUev2MLyZq24ztYR+rmKw16mhTADqfUocDiEqiOONO/
u5iXCnr/xuExsX5bXll52ka26WCyslzqI1ZKo1V/Npg5KLqNDSq+QcKdjWsYkKYX
wMZxP1v0jZaxSz6mg8QzQUF1udgt/DS/oomASXCKtoXK0rXPEkJ5We1lpo2RkU1G
27P16Hu0HRIJAEY8bqN2on1jMerZcTyY2lZDNgAolxlHerMcxLTuxG1XKK03x5Kx
7s9arPWZtNtm+dyj3+ZPjj151zZh4rnpj7ed2DfOwg==
=zUV1
-----END PGP SIGNATURE-----

--vT453ZjpIaSzzc5F--

