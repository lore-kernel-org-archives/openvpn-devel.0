From: David Sommerseth <openvpn@...2080...>
Date: Fri,  3 Jun 2016 19:09:13 +0200
Message-Id: <1464973753-12778-1-git-send-email-openvpn@...2080...>
In-Reply-To: <1464883738-904-1-git-send-email-openvpn@...2080...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH v2] Another fix related to unit test
	framework
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

The comment had to be moved to a single line, otherwise the
white spaces between the end of the variable assignment and the
hash character got added to the variable.

 [v2 - Fix white space issues in path variables]

Signed-off-by: David Sommerseth <dazo@...2145...>
---
 vendor/Makefile.am | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/vendor/Makefile.am b/vendor/Makefile.am
index 84656a1..5028f45 100644
--- a/vendor/Makefile.am
+++ b/vendor/Makefile.am
@@ -1,6 +1,5 @@
-AUTOMAKE_OPTIONS = foreign
-
-cmockasrc     = @VENDOR_SRC_ROOT@/cmocka  # needs an absolute path bc. of the cmake invocation
+# needs an absolute path bc. of the cmake invocation
+cmockasrc     = @VENDOR_SRC_ROOT@/cmocka
 cmockabuild   = @VENDOR_BUILD_ROOT@/cmocka
 cmockainstall = @VENDOR_DIST_ROOT@
 
@@ -10,13 +9,10 @@ MAINTAINERCLEANFILES = \
 	$(cmockainstall) \
 	@VENDOR_BUILD_ROOT@
 
-distdir:
-	mkdir -p $(cmockainstall)
-
-libcmocka: distdir
-	mkdir -p $(cmockabuild)
+libcmocka:
 if CMOCKA_INITIALIZED
-	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=$(cmockainstall) $(cmockasrc) && make && make install)
+	mkdir -p "$(cmockabuild)" "$(cmockainstall)"
+	(cd "$(cmockabuild)" && cmake -DCMAKE_INSTALL_PREFIX="$(cmockainstall)" "$(cmockasrc)" && make && make install)
 endif
 
 check: libcmocka
-- 
1.8.3.1


