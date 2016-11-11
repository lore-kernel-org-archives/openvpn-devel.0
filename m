From: David Sommerseth <davids@...515...>
Date: Fri, 11 Nov 2016 14:30:07 +0100
Message-Id: <1478871007-25998-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] console: Fix compiler warning
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

Building with -O2, the compiler warned about query_user_SINGLE() being
declared and not used in console.c.  This function, defined in console.h,
should have been declared as 'static inline'.  This also removes that
warning.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/console.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 41f2b8c..ec32cf6 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -106,7 +106,7 @@ static bool query_user_exec ()
  *             to be called at start-up initialization of OpenVPN.
  *
  */
-static bool query_user_SINGLE (char *prompt, size_t prompt_len,
+static inline bool query_user_SINGLE (char *prompt, size_t prompt_len,
                      char *resp, size_t resp_len,
                      bool echo)
 {
-- 
1.8.3.1


