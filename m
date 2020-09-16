From: Vladislav Grishenko <themiron@...2010...>
Date: Wed, 16 Sep 2020 18:13:49 +0500
Message-Id: <20200916131349.27668-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Fix fatal error at switching remotes (#629)
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

If remote server has been resolved to multiple addresses, at
least one connection attemt has been made and connection to
the last address was skipped by management - resolved earlier
link socket addrinfo objects will not be cleared neither on
instance close nor in the next connection entry loop.
This causes fatal error assert:

    >REMOTE:openvpn.net,1194,udp
    remote ACCEPT
    SUCCESS: remote command succeeded
    >REMOTE:openvpn.net,1194,udp
    remote SKIP
    SUCCESS: remote command succeeded
    >FATAL:Assertion failed at init.c:504 (c->c1.link_socket_addr.current_remote == NULL)

Fix this behaviour by cleaning stale addinfo objects.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a785934a..508270a7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -500,6 +500,16 @@ next_connection_entry(struct context *c)
                  */
                 if (!c->options.persist_remote_ip)
                 {
+                    if (c->c1.link_socket_addr.remote_list)
+                    {
+                        /* Connection entry addinfo objects might have been resolved
+                         * earlier but the entry itself might have been skipped by
+                         * management on the previous loop. if so, need to clear the
+                         * addrinfo objects as close_instance does */
+                        clear_remote_addrlist(&c->c1.link_socket_addr,
+                                              !c->options.resolve_in_advance);
+                    }
+
                     /* close_instance should have cleared the addrinfo objects */
                     ASSERT(c->c1.link_socket_addr.current_remote == NULL);
                     ASSERT(c->c1.link_socket_addr.remote_list == NULL);
-- 
2.17.1


