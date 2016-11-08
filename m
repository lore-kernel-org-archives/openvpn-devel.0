References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
	<192d8759-72ee-956a-55a8-e51f9104d552@...1435...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <7123e2f6-2253-7c6b-84ee-8540bec68fec@...1435...>
Date: Tue, 8 Nov 2016 14:51:02 +0100
MIME-Version: 1.0
In-Reply-To: <192d8759-72ee-956a-55a8-e51f9104d552@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o3fxKxhcBWF8rkPn0cktnidbVRq3JqEPG"
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
 add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--o3fxKxhcBWF8rkPn0cktnidbVRq3JqEPG
Content-Type: multipart/mixed; boundary="theWulB4SluHI8T3F624cQFnM9GdkAVDg";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <7123e2f6-2253-7c6b-84ee-8540bec68fec@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
	add unit tests
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
	<192d8759-72ee-956a-55a8-e51f9104d552@...1435...>
In-Reply-To: <192d8759-72ee-956a-55a8-e51f9104d552@...1435...>

--theWulB4SluHI8T3F624cQFnM9GdkAVDg
Content-Type: multipart/mixed; boundary="------------3B069BA5832D29AF346BA65A"

This is a multi-part message in MIME format.
--------------3B069BA5832D29AF346BA65A
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08-11-16 09:44, Steffan Karger wrote:
> I didn't look at the code itself (David already did), but two very minor
> nitpicks I ran into while rebasing my src/openvpn/* unit tests on this
> patch:
>=20
> [..]

Apart from this, I noticed that builds that depend on
OPENSSL_CFLAGS/MBEDTLS_CFLAGS (or LIBS) would fail to compile the
testdriver.  Attached a proposed fixup that fixes both me previous
nitpicks as well as the test driver build.  Feel free to squash into the
original patch if you agree.

-Steffan

--------------3B069BA5832D29AF346BA65A
Content-Type: text/x-patch;
 name="0001-argv_test-fixups.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-argv_test-fixups.patch"

=46rom f2214b435cc4a63cf7a58c78915f445feb9ae014 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Nov 2016 14:42:24 +0100
Subject: [PATCH] argv_test fixups

---
 configure.ac                         | 4 ++--
 tests/unit_tests/Makefile.am         | 2 +-
 tests/unit_tests/openvpn/Makefile.am | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index a42257a..bd6797c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1270,10 +1270,10 @@ AC_CONFIG_FILES([
 	src/plugins/down-root/Makefile
 	tests/Makefile
         tests/unit_tests/Makefile
-        tests/unit_tests/plugins/Makefile
-        tests/unit_tests/plugins/auth-pam/Makefile
         tests/unit_tests/example_test/Makefile
         tests/unit_tests/openvpn/Makefile
+        tests/unit_tests/plugins/Makefile
+        tests/unit_tests/plugins/auth-pam/Makefile
         vendor/Makefile
 	sample/Makefile
 	doc/Makefile
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 44ab26b..31d37b8 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS =3D foreign
=20
 if CMOCKA_INITIALIZED
-SUBDIRS =3D example_test plugins openvpn
+SUBDIRS =3D example_test openvpn plugins
 endif
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/open=
vpn/Makefile.am
index af7f12f..b706fae 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,8 +7,10 @@ TESTS =3D $(check_PROGRAMS)
 openvpn_srcdir =3D $(top_srcdir)/src/openvpn
 compat_srcdir =3D $(top_srcdir)/src/compat
=20
-argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat=
_srcdir)
-argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wra=
p=3Dparse_line
+argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat=
_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wra=
p=3Dparse_line \
+	$(OPTIONAL_CRYPTO_LIBS)
 argv_testdriver_SOURCES =3D test_argv.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/buffer.c \
--=20
2.7.4


--------------3B069BA5832D29AF346BA65A--

--theWulB4SluHI8T3F624cQFnM9GdkAVDg--

--o3fxKxhcBWF8rkPn0cktnidbVRq3JqEPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYIdhGAAoJEEEwndWOY1w52O0H/0sXfXgiMbhuaGqr/qxDIykh
s3dRmZnlR8fuOtOavO7D0pLUDkErLBWBY3Kbw678Jk+c7OjnLU5qAFZqla1OKUHF
OftkNmAe0VkiMImjpSkaKKAHUyo1gX12ik0hli1/rskT7mounQ27WRfngze+qsea
KIzm2bogYSZD/xv6WW1WkRTyi/0WW7pjt87HjFwDPFNiZAsataLPLgq5cOnTWdOz
hnCVRY0xgSgwCzn64jP91cfuOLyVUAYgKcDlERBzcF2Snb3lhUDdavqio0IxUDyY
UUFvoeP0neyoznfHjKxtSESfYRc6Yr58/MlYzS8Hd2SCzJf2Yvr7LTg1ntv8uoU=
=HEAT
-----END PGP SIGNATURE-----

--o3fxKxhcBWF8rkPn0cktnidbVRq3JqEPG--

