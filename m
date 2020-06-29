From: Gert Doering <gert@...1296...>
Date: Mon, 29 Jun 2020 19:51:09 +0200
Message-Id: <20200629175109.94276-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix 'engine' unit test on FreeBSD
 (specifically 'not GNU make')
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

The rules to generate $(builddir)/openssl.cnf from $(srcdir)/openssl.cnf.in
only worked for GNU Make.  BSD make needs the rules more explicit, and
the target must not have a directory specification (fixes commit 542c69c37).

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/unit_tests/engine-key/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/engine-key/Makefile.am
index 0bfdfcd4..24622251 100644
--- a/tests/unit_tests/engine-key/Makefile.am
+++ b/tests/unit_tests/engine-key/Makefile.am
@@ -21,8 +21,8 @@ CLEANFILES = \
 	log.txt \
 	$(conffiles)
 
-$(builddir)/openssl.cnf: $(srcdir)/openssl.cnf.in
-	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@
+openssl.cnf: $(srcdir)/openssl.cnf.in
+	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $(srcdir)/openssl.cnf.in > $@
 
 libtestengine_la_SOURCES = libtestengine.c
 libtestengine_la_LDFLAGS = @TEST_LDFLAGS@ -rpath /lib -shrext .so
-- 
2.27.0


