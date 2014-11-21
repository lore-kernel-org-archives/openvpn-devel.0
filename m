From: Yegor Yefremov <yegorslists@...1030...>
Date: Fri, 21 Nov 2014 20:40:35 +0100
Message-Id: <1416598835-5269-1-git-send-email-yegorslists@...1030...>
Subject: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
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

Set enable_password_save to "yes", if the option is not given,
as stated in the description.

Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 608ab6d..9dcd2ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,7 +166,7 @@ AC_ARG_ENABLE(
 	[password-save],
 	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=yes@:>@])],
 	,
-	[enable_password_save="no"]
+	[enable_password_save="yes"]
 )
 
 AC_ARG_ENABLE(
-- 
1.8.3.2


