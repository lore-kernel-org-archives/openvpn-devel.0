From: Matthias Andree <matthias.andree@...68...>
Date: Fri, 17 Jul 2020 17:05:10 +0200
Message-Id: <20200717150510.124442-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Automake options: add subdir-objects,
 and clean up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Matthias Andree <matthias.andree@...68...>

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 Makefile.am  | 1 -
 configure.ac | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 439120e4..e4125447 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -25,7 +25,6 @@

 # This option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
-AUTOMAKE_OPTIONS =3D foreign 1.9
 ACLOCAL_AMFLAGS =3D -I m4

 MAINTAINERCLEANFILES =3D \
diff --git a/configure.ac b/configure.ac
index 45148892..9d6510ca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,7 +54,7 @@ m4_define([serial_tests], [
                 awk '{split ($NF,a,"."); if (a[1] =3D=3D 1 && a[2] >=3D 12=
) { print "serial-tests" }}'
     ])
 ])
-AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this paramet=
er.
+AM_INIT_AUTOMAKE(foreign serial_tests subdir-objects 1.9) dnl NB: Do not [=
quote] this parameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS

--
2.25.4


