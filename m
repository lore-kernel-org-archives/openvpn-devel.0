From: selva.nair@...277...
Date: Tue,  7 Sep 2021 18:36:14 -0400
Message-Id: <20210907223614.8574-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow skipping multple remotes via
 management interface
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

The mamangement command "remote SKIP" is extended with an
optional parameter 'count' > 0. If count is greater than
number of connection entries (len), count % len is used.
On going past the index of the last connection entry,
counting is restarted from the first connection entry.

Without this, use of management-query-remote from a UI is
virtually impractical except when there are only a handful
of remote entries. Skipping the entries one by one takes
a long time when there are many entries to be skipped
(~ 1 second per entry).  Use of "remote MOD" is not an
option as change of protocol is not supported.

Management clients can determine the availablity of this
feature by checking that the management interface version
is > 3. Older versions will ignore the count parameter and
behave identically to using count = 1.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/management-notes.txt |  7 +++++++
 src/openvpn/init.c       | 20 ++++++++++++++++----
 src/openvpn/options.h    |  2 ++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 84e3d04b..ff0695a0 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -929,6 +929,13 @@ use this command:
 
   remote SKIP
 
+Starting OpenVPN version 2.6 (management version > 3), skip
+multiple remotes using:
+
+  remote SKIP n
+
+where n > 0 is the number of remotes to skip.
+
 COMMAND -- proxy  (OpenVPN 2.3 or higher)
 --------------------------------------------
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 386aee23..73ce3bb1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -348,6 +348,7 @@ management_callback_remote_cmd(void *arg, const char **p)
         {
             flags = CE_MAN_QUERY_REMOTE_SKIP;
             ret = true;
+            c->options.ce_advance_count = (p[2]) ? atoi(p[2]) : 1;
         }
         else if (!strcmp(p[1], "MOD") && p[2] && p[3])
         {
@@ -520,18 +521,28 @@ next_connection_entry(struct context *c)
                         c->c1.link_socket_addr.remote_list;
                 }
 
+                int advance_count = 1;
+
+                /* If previous connection entry was skipped by management client
+                 * with a count to advance by, apply it.
+                 */
+                if (c->options.ce_advance_count > 0)
+                {
+                    advance_count = c->options.ce_advance_count;
+                }
+
                 /*
                  * Increase the number of connection attempts
                  * If this is connect-retry-max * size(l)
                  * OpenVPN will quit
                  */
 
-                c->options.unsuccessful_attempts++;
+                c->options.unsuccessful_attempts += advance_count;
+                l->current += advance_count;
 
-                if (++l->current >= l->len)
+                if (l->current >= l->len)
                 {
-
-                    l->current = 0;
+                    l->current %= l->len;
                     if (++n_cycles >= 2)
                     {
                         msg(M_FATAL, "No usable connection profiles are present");
@@ -540,6 +551,7 @@ next_connection_entry(struct context *c)
             }
         }
 
+        c->options.ce_advance_count = 1;
         ce = l->array[l->current];
 
         if (ce->flags & CE_DISABLED)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b0e40cb7..ea7ee96e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -253,6 +253,8 @@ struct options
     bool no_advance;
     /* Counts the number of unsuccessful connection attempts */
     unsigned int unsuccessful_attempts;
+    /* count of connection entries to advance by when no_advance is not set */
+    int ce_advance_count;
 
 #if ENABLE_MANAGEMENT
     struct http_proxy_options *http_proxy_override;
-- 
2.20.1


