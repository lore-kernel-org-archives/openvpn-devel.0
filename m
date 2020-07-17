From: Matthias Andree <matthias.andree@...68...>
Date: Fri, 17 Jul 2020 19:09:42 +0200
Message-Id: <20200717170942.227701-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Merge Makefile.am's AUTOMAKE_OPTIONS into
 configure.ac's AM_INIT_AUTOMAKE.
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

Else one location overwrites options from the other.

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 Makefile.am  | 3 ---
 configure.ac | 6 +++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 439120e4..d1c10fc5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,9 +23,6 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #

-# This option prevents autoreconf from overriding our COPYING and
-# INSTALL targets:
-AUTOMAKE_OPTIONS =3D foreign 1.9
 ACLOCAL_AMFLAGS =3D -I m4

 MAINTAINERCLEANFILES =3D \
diff --git a/configure.ac b/configure.ac
index 45148892..717b374a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,10 +54,14 @@ m4_define([serial_tests], [
                 awk '{split ($NF,a,"."); if (a[1] =3D=3D 1 && a[2] >=3D 12=
) { print "serial-tests" }}'
     ])
 ])
-AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this paramet=
er.
+# This foreign option prevents autoreconf from overriding our COPYING and
+# INSTALL targets:
+AM_INIT_AUTOMAKE(foreign serial_tests 1.9) dnl NB: Do not [quote] this par=
ameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS

+LT_INIT()
+
 AC_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@def=
ault=3Dyes@:>@])],
--
2.25.4


