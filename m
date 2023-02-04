From: selva.nair@...277...
Date: Fri,  3 Feb 2023 19:45:10 -0500
Message-Id: <20230204004512.250271-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Conditionally add subdir-objects option
 to automake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

- Eliminates repeated warnings such as
  warning: source file '$(openvpn_srcdir)/env_set.c' is in a subdirectory,
  but option 'subdir-objects' is disabled
- Enabled only for automake >= 1.16 as older versions have a buggy implementation
  of this option

Main side effect of this option is that object files like openvpnserv-blockdns.o
are now created in src/openvpn where block-dns.c resides instead of in
src/openvpnserv. Same for object files for sources from $(openvpn_srcdir) compiled
into test executables.

See also past discussion on this topic:
  https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 91500087..95d795c3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,9 +54,22 @@ m4_define([serial_tests], [
                 awk '{split ($NF,a,"."); if (a[1] == 1 && a[2] >= 12) { print "serial-tests" }}'
     ])
 ])
+
+dnl Automake 1.14+ warns if sources are in sub-directories but subdir-objects
+dnl options is not enabled. However, automake before 1.15a has a bug that causes
+dnl variable expansion to fail in foo_SOURCES when this option is used.
+dnl As most of our build systems are now likely to use automake 1.16+ add a
+dnl work around to conditionally add subdir-objects option.
+m4_define([subdir_objects], [
+    m4_esyscmd([automake --version |
+                head -1 |
+                awk '{split ($NF,a,"."); if (a[1] == 1 && a[2] >= 16) { print "subdir-objects" }}'
+    ])
+])
+
 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
-AM_INIT_AUTOMAKE(foreign serial_tests 1.9) dnl NB: Do not [quote] this parameter.
+AM_INIT_AUTOMAKE(foreign serial_tests subdir_objects 1.9) dnl NB: Do not [quote] this parameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
-- 
2.34.1


