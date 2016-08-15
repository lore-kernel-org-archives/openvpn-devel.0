From: Steffan Karger <steffan@...1856...>
Date: Mon, 15 Aug 2016 20:02:36 +0200
Message-Id: <1471284156-2324-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix unittests for out-of-source builds
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4f14ebd..9189c94 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1215,7 +1215,7 @@ AC_SUBST([TEST_CFLAGS])
 # needed for unit testing
 AC_CHECK_PROGS([CMAKE], [cmake])
 if test -n "${CMAKE}"; then
-   if test -f vendor/cmocka/CMakeLists.txt; then
+   if test -f "${srcdir}/vendor/cmocka/CMakeLists.txt"; then
       AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
    else
       AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
-- 
2.7.4


