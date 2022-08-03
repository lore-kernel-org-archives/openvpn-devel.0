From: Antonio Quartulli <a@...2181...>
Date: Wed,  3 Aug 2022 17:40:49 +0200
Message-Id: <20220803154049.1213-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] push: fix compilation with
 --disable-management and --enable-werror
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

The authfail_extended and buf variables are only used when
ENABLE_MANAGEMENT is defined. However, they are currently declared
outside of any ifdefs, thus triggering a warning.

Move the declaration of these 2 down, right before their usage (within
the existing "#ifdef ENABLE_MANAGEMENT" block.

Fixes: ("Cleanup receive_auth_failed and simplify method")
Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/push.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d0038795..51dc8359 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -58,12 +58,6 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
         return;
     }
 
-    struct buffer buf = *buffer;
-
-    /* If the AUTH_FAIL message ends with a , it is an extended message that
-     * contains further flags */
-    bool authfail_extended = buf_string_compare_advance(&buf, "AUTH_FAILED,");
-
     /* Before checking how to react on AUTH_FAILED, first check if the
      * failed auth might be the result of an expired auth-token.
      * Note that a server restart will trigger a generic AUTH_FAILED
@@ -95,6 +89,11 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
         c->sig->signal_text = "auth-failure";
     }
 #ifdef ENABLE_MANAGEMENT
+    struct buffer buf = *buffer;
+    /* If the AUTH_FAIL message ends with a , it is an extended message that
+     * contains further flags */
+    bool authfail_extended = buf_string_compare_advance(&buf, "AUTH_FAILED,");
+
     if (management)
     {
         const char *reason = NULL;
-- 
2.35.1


