From: selva.nair@...277...
Date: Fri, 15 May 2020 11:21:51 -0400
Message-Id: <1589556111-18894-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1521522224-18829-2-git-send-email-selva.nair@...277...>
References: <1521522224-18829-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Allow repeated cycles through remotes
 when management-query-remote is in use
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

From: Selva Nair <selva.nair@...277...>

(i) Let the management-client predictably cycle through remote entries. This
is done by not aborting after two cycles. The client can abort or restart
the connection  using  signals (USR/HUP/TERM) as necessary.

In the current behaviour, the daemon can unexpectedly exit when the last remote
is skipped. When management-query-remote is not in use, the behaviour is
unchanged.

(ii) Do not count skipping a remote as an unsuccessful connection attempt.
As the latter count is used for backoff it should count only failed attempts.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 - rebased to master, no changes

 src/openvpn/init.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 70cd493..1bb39ee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -471,14 +471,6 @@ next_connection_entry(struct context *c)
                         c->c1.link_socket_addr.remote_list;
                 }
 
-                /*
-                 * Increase the number of connection attempts
-                 * If this is connect-retry-max * size(l)
-                 * OpenVPN will quit
-                 */
-
-                c->options.unsuccessful_attempts++;
-
                 if (++l->current >= l->len)
                 {
 
@@ -504,6 +496,9 @@ next_connection_entry(struct context *c)
         {
             /* allow management interface to override connection entry details */
             ce_defined = ce_management_query_remote(c);
+
+            /* ignore cycles when management-query-remote is in use */
+            n_cycles = 0;
             if (IS_SIG(c))
             {
                 break;
@@ -520,6 +515,7 @@ next_connection_entry(struct context *c)
 #endif
     } while (!ce_defined);
 
+    c->options.unsuccessful_attempts++;
     /* Check if this connection attempt would bring us over the limit */
     if (c->options.connect_retry_max > 0
         && c->options.unsuccessful_attempts > (l->len  * c->options.connect_retry_max))
-- 
2.1.4


