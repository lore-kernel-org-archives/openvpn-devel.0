From: Gert Doering <gert@...1296...>
Date: Mon, 13 Jul 2020 11:32:52 +0200
Message-Id: <20200713093252.30916-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Handle connecting clients without NCP or
 OCC without crashing.
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
Cc: Gert Doering <gert@...1296...>

ssl_ncp.c:ncp_get_best_cipher() would crash if a client connects without
NCP (or with a NCP cipher list that does not contain the first NCP cipher
in the server list) due to a NULL pointer strcmp().

Work around / fix by just assigning an empty string to remote_cipher here
("not NULL but will never match either").

Add new warning message in multi.c for the "we do not know what the
client can do" case (no NCP and non-helpful OCC), rewrapped the existing
message to keep line lenght limit.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c   | 17 +++++++++++++----
 src/openvpn/ssl_ncp.c |  6 ++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a2af071a..c2ffcb9d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1833,10 +1833,19 @@ multi_client_set_protocol_options(struct context *c)
             {
                 struct gc_arena gc = gc_new();
                 const char *peer_ciphers = tls_peer_ncp_list(peer_info, &gc);
-                msg(M_INFO, "PUSH: No common cipher between server and client."
-                    "Expect this connection not to work. "
-                    "Server ncp-ciphers: '%s', client supported ciphers '%s'",
-                    o->ncp_ciphers, peer_ciphers);
+                if (strlen(peer_ciphers) > 0)
+                {
+                    msg(M_INFO, "PUSH: No common cipher between server and "
+                        "client. Expect this connection not to work. Server "
+                        "ncp-ciphers: '%s', client supported ciphers '%s'",
+                        o->ncp_ciphers, peer_ciphers);
+                }
+                else
+                {
+                    msg(M_INFO, "No NCP data received from peer, falling back "
+                        "to --cipher '%s'. Peer reports in OCC --cipher '%s'",
+                        o->ciphername, np(tls_multi->remote_ciphername));
+                }
                 gc_free(&gc);
             }
         }
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index ea1dc960..fe7f5855 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -225,6 +225,12 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
 
     const char *peer_ncp_list = tls_peer_ncp_list(peer_info, &gc_tmp);
 
+    /* non-NCP client without OCC?  "assume nothing" */
+    if (remote_cipher == NULL )
+    {
+        remote_cipher = "";
+    }
+
     char *tmp_ciphers = string_alloc(server_list, &gc_tmp);
 
     const char *token = strsep(&tmp_ciphers, ":");
-- 
2.26.2


