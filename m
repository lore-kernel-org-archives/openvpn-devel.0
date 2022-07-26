Date: Tue, 26 Jul 2022 08:58:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yt+QllThprcm+Vu6@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="at0yD82rLkX6Wk/a"
Content-Disposition: inline
Subject: [Openvpn-devel] OpenSSL 3.0 builds with --disable-management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--at0yD82rLkX6Wk/a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

buildbot found something new :-) - ossl 3.0 builds fail if --disable-manage=
ment
is set:

gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include -I../../sr=
c/compat        -DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\"  -Wall=
 -Wno-stringop-truncation -g -O2 -std=3Dc99 -MT xkey_helper.o -MD -MP -MF .=
deps/xkey_helper.Tpo -c -o xkey_helper.o xkey_helper.c
xkey_helper.c: In function `xkey_management_sign':
xkey_helper.c:178:26: error: `management' undeclared (first use in this fun=
ction); did you mean `SN_Management'?
  178 |     unsigned int flags =3D management->settings.flags;
      |                          ^~~~~~~~~~
      |                          SN_Management
xkey_helper.c:178:26: note: each undeclared identifier is reported only onc=
e for each function it appears in
xkey_helper.c:182:52: error: `MF_EXTERNAL_KEY_DIGEST' undeclared (first use=
 in this function)
  182 |     if (!strcmp(alg.op, "DigestSign") && !(flags & MF_EXTERNAL_KEY_=
DIGEST)
      |                                                    ^~~~~~~~~~~~~~~~=
~~~~~~
xkey_helper.c:215:56: error: `MF_EXTERNAL_KEY_PKCS1PAD' undeclared (first u=
se in this function)
  215 |     else if (!strcmp(alg.padmode, "pkcs1") && (flags & MF_EXTERNAL_=
KEY_PKCS1PAD))
      |                                                        ^~~~~~~~~~~~=
~~~~~~~~~~~~
xkey_helper.c:235:55: error: `MF_EXTERNAL_KEY_NOPADDING' undeclared (first =
use in this function)
  235 |     else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_K=
EY_NOPADDING)
      |                                                       ^~~~~~~~~~~~~=
~~~~~~~~~~~~
xkey_helper.c:240:54: error: `MF_EXTERNAL_KEY_PSSPAD' undeclared (first use=
 in this function)
  240 |     else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KE=
Y_PSSPAD))
      |                                                      ^~~~~~~~~~~~~~=
~~~~~~~~
xkey_helper.c:267:19: warning: implicit declaration of function `management=
_query_pk_sig' [-Wimplicit-function-declaration]
  267 |         out_b64 =3D management_query_pk_sig(management, in_b64, alg=
_str);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [Makefile:762: xkey_helper.o] Error 1
make[2]: *** [Makefile:437: all-recursive] Error 1
make[1]: *** [Makefile:614: all-recursive] Error 1
make: *** [Makefile:502: all] Error 2
make[3]: Leaving directory '/buildbot/ubuntu-2204-factory--disable-lzo--dis=
able-management/build/src/openvpn'

... so it seems we're missing a few #ifdef ENABLE_MANAGEMENT here and=20
there...

I'm just relaying what buildbot found, not suggesting a particular fix
- not very familiar with these new code paths (do we need xkey at all
if management is disabled?).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--at0yD82rLkX6Wk/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi35CWAAoJEB2Cnv7KVigScYsMAIsOZR340QLIa1yVT//ax01F
O4twGGKqdjx9BUdP64PNHKxmwnykwwxq6mk8oRUc7nJ5S4Ydx3grIFT12+hr13TZ
0hyaOvkldQMrwN7tc5X9OcTddmmo0J/p3osLyA0AIsWZlmPsfxVB0i8ERmxEuedg
8oZ4/qUOwtu4MSEE1GhyE69Chib7u3hS77xCU8SjIV0M+CZ3ULZtT0aALY4louZf
Wc9Uj1pA4xOpi7M26kXldiSDZ7SSKWDz4hh4L1BueR68X/v+Ns7SymYDeXoMm4bk
otaQPwC5dpGYIgNcaRgOUP/Wm3YtL9fBA5B9VkFXglxZmA8xCO4Vvl6N/iNzrq/5
brl/+ScNlyjBPJ45XX8WHY8NjtBOCf5LxN//FNx2QQqxyYbUNFTEuV7pKGnxcfQO
bIH+smp0oLE2Y4iBV3ttRIxRIu62D7rySxYZFfw4AAjLHBc1LAtuzZscTjAuH912
YIi/R8GsxbsiVs1zSmo6RpzxO0xOZlbL/fPoO2sibA==
=eKbs
-----END PGP SIGNATURE-----

--at0yD82rLkX6Wk/a--

