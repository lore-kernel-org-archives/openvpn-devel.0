From: Vladislav Grishenko <themiron@...2010...>
Date: Wed, 16 Sep 2020 19:17:55 +0500
Message-Id: <20200916141755.1923-1-themiron@...2010...>
In-Reply-To: <20200916131349.27668-1-themiron@...2010...>
References: <20200916131349.27668-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH v2] Fix fatal error at switching remotes
 (#629)
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

v2: better comment placement and too long length fix

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a785934a..8fc79638 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -500,6 +500,17 @@ next_connection_entry(struct context *c)
                  */
                 if (!c->options.persist_remote_ip)
                 {
+                    /* Connection entry addinfo objects might have been resolved
+                     * earlier but the entry itself might have been skipped by
+                     * management on the previous loop.
+                     * If so, clear the addrinfo objects as close_instance does
+                     */
+                    if (c->c1.link_socket_addr.remote_list)
+                    {
+                        clear_remote_addrlist(&c->c1.link_socket_addr,
+                                              !c->options.resolve_in_advance);
+                    }
+
                     /* close_instance should have cleared the addrinfo objects */
                     ASSERT(c->c1.link_socket_addr.current_remote == NULL);
                     ASSERT(c->c1.link_socket_addr.remote_list == NULL);
-- 
2.17.1


