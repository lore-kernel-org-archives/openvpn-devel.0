From: Antonio Quartulli <a@...2181...>
Date: Fri,  5 Aug 2022 17:08:37 +0200
Message-Id: <20220805150837.8169-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: perform pull options check only if we
 pulled any option
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
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

The do_deferred_options() function is invoked also on the server side in
order to process all negotiated bits.

However, in this case we should not perform any pull options check, as
it's required only on the client side.

Move check within the "if (options.pull)" block to ensure we perform the
check only when required.

Reported-By: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2e7544de..b6705921 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2402,22 +2402,23 @@ do_deferred_options(struct context *c, const unsigned int found)
         c->c2.tls_multi->peer_id = c->options.peer_id;
     }
 
-    /* process (potentially pushed) crypto options */
+    /* process (potentially) pushed options */
     if (c->options.pull)
     {
         if (!check_pull_client_ncp(c, found))
         {
             return false;
         }
-    }
 
-    /* Check if pushed options are compatible with DCO, if enabled */
-    if (dco_enabled(&c->options)
-        && !dco_check_pull_options(D_PUSH_ERRORS, &c->options))
-    {
-        msg(D_PUSH_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
-            "data channel offload. Use --disable-dco to connect to this server");
-        return false;
+        /* Check if pushed options are compatible with DCO, if enabled */
+        if (dco_enabled(&c->options)
+            && !dco_check_pull_options(D_PUSH_ERRORS, &c->options))
+        {
+            msg(D_PUSH_ERRORS, "OPTIONS ERROR: pushed options are incompatible "
+                "with data channel offload. Use --disable-dco to connect to "
+                "this server");
+            return false;
+        }
     }
 
     return true;
-- 
2.35.1


