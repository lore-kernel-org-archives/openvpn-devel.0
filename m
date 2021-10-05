From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Oct 2021 14:27:36 +0200
Message-Id: <20211005122736.4060-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure: remove useless -Wno-* from
 default CFLAGS
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

Historically we always had -Wno-unused-parameter and
-Wno-unused-function enabled along with -Wall.

When we made -Wall a default option, we carried the other two along and
made them default too (in 2018).

Now the code is much cleaner compared to the past and we do not really
require -Wno-unused-parameter and -Wno-unused-function anymore.

Actually they may hide really unused functions that we'd need to
cleanup.

For this reason remove -Wno-unused-parameter and -Wno-unused-function
for good from the default CFLAGS.

Any new warning should rather be fixed than hidden.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7c2ead6a..a37dc762 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1224,8 +1224,6 @@ AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
 )
 
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
 
 if test "${enable_pedantic}" = "yes"; then
-- 
2.32.0


