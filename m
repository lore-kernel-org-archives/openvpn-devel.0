From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Oct 2015 00:38:26 +0200
Message-Id: <1445380706-20864-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in auth-pam plugin
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

As it says on the tin.  aresp would not be free'd nor returned by
my_conv() on errors.  Note that we never reach this code if allocation
of aresp failed.

Found with the Clang static analyzer.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/plugins/auth-pam/auth-pam.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index bd71792..95692ab 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -642,6 +642,9 @@ my_conv (int n, const struct pam_message **msg_array,
 
   if (ret == PAM_SUCCESS)
     *response_array = aresp;
+  else
+    free(aresp);
+
   return ret;
 }
 
-- 
2.1.4


