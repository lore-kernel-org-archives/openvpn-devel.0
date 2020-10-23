From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:55 +0200
Message-Id: <20201023120259.29783-3-arne@...1227...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
 <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/8] Improve keys out of sync message
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

The current message basically lacks the information to actually figure
out why the keys are out of sync. This adds the missing information to
that diagnostic message.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 98ce38f9..79ad322a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -763,6 +763,22 @@ state_name(int state)
     }
 }
 
+static const char *
+ks_auth_name(enum ks_auth_state auth)
+{
+    switch(auth)
+    {
+    case KS_AUTH_TRUE:
+        return "KS_AUTH_TRUE";
+    case KS_AUTH_DEFERRED:
+        return "KS_AUTH_DEFERRED";
+    case KS_AUTH_FALSE:
+        return "KS_AUTH_FALSE";
+    default:
+        return "KS_????";
+    }
+}
+
 static const char *
 packet_opcode_name(int op)
 {
@@ -833,8 +849,9 @@ print_key_id(struct tls_multi *multi, struct gc_arena *gc)
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
-        buf_printf(&out, " [key#%d state=%s id=%d sid=%s]", i,
-                   state_name(ks->state), ks->key_id,
+        buf_printf(&out, " [key#%d state=%s auth=%s id=%d sid=%s]", i,
+                   state_name(ks->state), ks_auth_name(ks->authenticated),
+                   ks->key_id,
                    session_id_print(&ks->session_id_remote, gc));
     }
 
@@ -3331,8 +3348,10 @@ handle_data_channel_packet(struct tls_multi *multi,
     }
 
     msg(D_TLS_ERRORS,
-        "TLS Error: local/remote TLS keys are out of sync: %s [%d]",
-        print_link_socket_actual(from, &gc), key_id);
+        "TLS Error: local/remote TLS keys are out of sync: %s "
+        "(received key id: %d, known key ids: %s)",
+        print_link_socket_actual(from, &gc), key_id,
+        print_key_id(multi, &gc));
 
 done:
     tls_clear_error();
-- 
2.26.2


