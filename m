From: David Sommerseth <davids@...515...>
Date: Tue,  6 Dec 2016 23:10:51 +0100
Message-Id: <1481062251-18349-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Fix wrong configure.ac parsing of
	--enable-async-push
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

AC_ARG_ENABLE() was used wrong, which led enable_async_push to
always be set, regardless if --enable-async-push or --disable-async-push
was used.

Also spotted the exact same patch when writing this commit message as
GitHub PR#70.

Trac: #786
Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f4073d0..c6c5fa9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -267,7 +267,7 @@ AC_ARG_ENABLE(
 AC_ARG_ENABLE(
 	[async-push],
 	[AS_HELP_STRING([--enable-async-push], [enable async-push support @<:@default=no@:>@])],
-	[enable_async_push="yes"],
+        ,
 	[enable_async_push="no"]
 )
 
-- 
1.8.3.1


