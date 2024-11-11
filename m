From: Gert Doering <gert@...1296...>
Date: Mon, 11 Nov 2024 08:43:55 +0100
Message-ID: <20241111074355.17918-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I210fa255921e7115bd66ba5f3e431562552e3335@...2715...>
References: <gerrit.1731290343000.I210fa255921e7115bd66ba5f3e431562552e3335@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Move should_trigger_renegotiation into
 its own function
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

From: Arne Schwabe <arne@...1227...>

The if statement has become quite large and unreadable. Reformat it
and move it to a separate function.

Change-Id: I210fa255921e7115bd66ba5f3e431562552e3335
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/794
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 93e31f1..c48a85c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2962,8 +2962,42 @@
     return true;
 }
 
+/**
+ * Determines if a renegotiation should be triggerred based on the various
+ * factors that can trigger one
+ */
+static bool
+should_trigger_renegotiation(const struct tls_session *session, const struct key_state *ks)
+{
+    /* Time limit */
+    if (session->opt->renegotiate_seconds
+        && now >= ks->established + session->opt->renegotiate_seconds)
+    {
+        return true;
+    }
 
+    /* Byte limit */
+    if (session->opt->renegotiate_bytes > 0
+        && ks->n_bytes >= session->opt->renegotiate_bytes)
+    {
+        return true;
+    }
 
+    /* Packet limit */
+    if (session->opt->renegotiate_packets
+        && ks->n_packets >= session->opt->renegotiate_packets)
+    {
+        return true;
+    }
+
+    /* Packet id approach the limit of the packet id */
+    if (packet_id_close_to_wrapping(&ks->crypto_options.packet_id.send))
+    {
+        return true;
+    }
+
+    return false;
+}
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2991,14 +3025,8 @@
 
     /* Should we trigger a soft reset? -- new key, keeps old key for a while */
     if (ks->state >= S_GENERATED_KEYS
-        && ((session->opt->renegotiate_seconds
-             && now >= ks->established + session->opt->renegotiate_seconds)
-            || (session->opt->renegotiate_bytes > 0
-                && ks->n_bytes >= session->opt->renegotiate_bytes)
-            || (session->opt->renegotiate_packets
-                && ks->n_packets >= session->opt->renegotiate_packets)
-            || (packet_id_close_to_wrapping(&ks->crypto_options.packet_id.send))))
-    {
+        && should_trigger_renegotiation(session, ks))
+   {
         msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d/%d bytes=" counter_format
             "/%d pkts=" counter_format "/%d",
             (int) (now - ks->established), session->opt->renegotiate_seconds,

