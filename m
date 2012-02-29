From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:26 +0200
Message-Id: <1330547854-18889-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 03/11] cleanup: remove warnings of
	redefinition of macros
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/resource.rc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/resource.rc b/src/resource.rc
index 84884cf..8b2d2f6 100755
--- a/src/resource.rc
+++ b/src/resource.rc
@@ -4,6 +4,11 @@
 /* get VERSION */
 #include "common.h"
 
+#undef VER_PRODUCTVERSION
+#undef VER_PRODUCTVERSION_STR
+#undef VER_COMPANYNAME_STR
+#undef VER_PRODUCTNAME_STR
+
 /* VER_FILETYPE, VER_FILESUBTYPE, VER_FILEDESCRIPTION_STR
  * and VER_INTERNALNAME_STR must be defined before including COMMON.VER
  * The strings don't need a '\0', since common.ver has them.
-- 
1.7.3.4


