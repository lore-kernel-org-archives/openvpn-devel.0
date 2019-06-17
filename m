From: Antonio Quartulli <a@...2181...>
Date: Mon, 17 Jun 2019 14:41:09 +0200
Message-Id: <20190617124110.30907-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] t_net.sh: fixes for the networking test
 script
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

1) The test_networking driver needs the cmocka library at runtime,
therefore LD_LIBRARY_PATH has to be properly configured.
The running framework takes care of that for the other unit-tests, but
since we run the networking driver from within t_net.sh, we have to be
sure that we also set LD_LIBRARY_PATH accordingly.

2) Building the networking unit-test when SITNL is not enabled does not
make much sense right now.
Make compilation dependent on having SITNL configured.

3) Remove some no-op mock_msg function calls.

4) Remove obsolete comment and declarations

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 tests/t_net.sh                             |  8 ++------
 tests/unit_tests/openvpn/Makefile.am       |  2 ++
 tests/unit_tests/openvpn/test_networking.c | 16 ----------------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 70e8517d..c6a7d5c8 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -1,12 +1,9 @@
 #!/usr/bin/env bash
 
 IFACE="dummy0"
-UNIT_TEST="./unit_tests/openvpn/networking_testdriver"
+UNIT_TEST="LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../vendor/dist/lib/ ./unit_tests/openvpn/networking_testdriver"
 MAX_TEST=${1:-7}
 
-KILL_EXEC=`which kill`
-CC=${CC:-gcc}
-
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 openvpn="${top_builddir}/src/openvpn/openvpn"
@@ -99,8 +96,7 @@ fi
 # Ensure PREFER_KSU is in a known state
 PREFER_KSU="${PREFER_KSU:-0}"
 
-# make sure we have permissions to run ifconfig/route from OpenVPN
-# can't use "id -u" here - doesn't work on Solaris
+# make sure we have permissions to run the networking unit-test
 ID=`id`
 if expr "$ID" : "uid=0" >/dev/null
 then :
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index e61c57c4..d015b293 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -78,6 +78,7 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/run_command.c
 
+if HAVE_SITNL
 networking_testdriver_CFLAGS = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
@@ -92,3 +93,4 @@ networking_testdriver_SOURCES = test_networking.c mock_msg.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c
+endif
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 6c50da92..22d8babe 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -2,13 +2,9 @@
 #include "syshead.h"
 #include "networking.h"
 
-#include "mock_msg.h"
-
 
 static char *iface = "dummy0";
 
-#ifdef ENABLE_SITNL
-
 static int
 net__iface_up(bool up)
 {
@@ -177,8 +173,6 @@ main(int argc, char *argv[])
 {
     int test;
 
-    mock_set_debug_level(10);
-
     if (argc < 2)
     {
         usage(argv[0]);
@@ -223,13 +217,3 @@ main(int argc, char *argv[])
     usage(argv[0]);
     return -1;
 }
-
-#else
-
-int
-main(int argc, char *argv[])
-{
-    return 0;
-}
-
-#endif /* ENABLE_SITNL */
-- 
2.22.0


