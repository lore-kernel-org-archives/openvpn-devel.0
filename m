From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 Nov 2019 11:03:23 +0100
Message-Id: <20191110100323.13206-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add -Wno-stringop-truncation to CFLAGS on
 linux
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
Cc: Antonio Quartulli <a@...2181...>

GCC>=8 supports truncation checking, however the logic is somewhat
fragile when it comes to evaluating strncpy().

In buffer.h we have implemented a wrapper called strncpynt() which
ensures we always do the right hting in the code and reduce the chance
of having bugs.

This said, it seems that the gcc logic is not able to always understand
if we are doing the right thing and throws a false positive.

Toa void the noise, disable truncation checking on Linux by default.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 4159e450..807804e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1283,6 +1283,7 @@ AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
         [AC_MSG_RESULT([no]); CFLAGS="$old_cflags"])]
 )
 
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
-- 
2.24.0


