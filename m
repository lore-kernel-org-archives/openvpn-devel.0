From: David Sommerseth <openvpn@...2080...>
Date: Thu,  2 Jun 2016 18:08:58 +0200
Message-Id: <1464883738-904-1-git-send-email-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH] Another fix related to unit test framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...2145...>

From: David Sommerseth <dazo@...2145...>

Continuing to fix breakage caused by commit 40cb4cfc5d011102.

It seems it was a conflict in vendor/Makefile.am's distdir target,
confusing autotools so it wouldn't actually parse that directory
properly.  The result was that 'make distcheck' would fail and
tarballs created would just ship with an empty vendor/ directory.

Also remove the 'foreign' AUTOMAKE_OPTIONS flag, as we don't use
that many places at all.  Things work well without this flag.

Signed-off-by: David Sommerseth <dazo@...2145...>
---
 vendor/Makefile.am | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/vendor/Makefile.am b/vendor/Makefile.am
index 84656a1..6c925b0 100644
--- a/vendor/Makefile.am
+++ b/vendor/Makefile.am
@@ -1,5 +1,3 @@
-AUTOMAKE_OPTIONS = foreign
-
 cmockasrc     = @VENDOR_SRC_ROOT@/cmocka  # needs an absolute path bc. of the cmake invocation
 cmockabuild   = @VENDOR_BUILD_ROOT@/cmocka
 cmockainstall = @VENDOR_DIST_ROOT@
@@ -10,12 +8,9 @@ MAINTAINERCLEANFILES = \
 	$(cmockainstall) \
 	@VENDOR_BUILD_ROOT@
 
-distdir:
-	mkdir -p $(cmockainstall)
-
-libcmocka: distdir
-	mkdir -p $(cmockabuild)
+libcmocka:
 if CMOCKA_INITIALIZED
+	mkdir -p $(cmockabuild) $(cmockainstall)
 	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=$(cmockainstall) $(cmockasrc) && make && make install)
 endif
 
-- 
1.8.3.1


