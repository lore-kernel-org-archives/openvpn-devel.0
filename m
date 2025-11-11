From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 18:24:31 +0100
Message-ID: <20251111172437.7634-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
References: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] ssl: change return type of
 calc_control_channel_frame_overhead to size_t
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

From: Frank Lichtenheld <frank@...2641...>

This avoids dealing with conversion warnings inside
the function. Since we only add values that are
supposed to be positive this should be safe.

Note that we now cast the return value to int at
the caller side. There we actually substract it and
want to catch the case where the result gets negative.
Since all the involved values are quite small compared
to INT_MAX I decided to just cast it without further
checks.

Change-Id: I71e9d4a61d37483685723c16e98f59755694cadf
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1297
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1297
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 908854a..eb5c4fc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -179,21 +179,16 @@
     frame->tun_mtu = max_int(frame->tun_mtu, TLS_CHANNEL_MTU_MIN);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * calculate the maximum overhead that control channel frames have
  * This includes header, op code and everything apart from the
  * payload itself. This method is a bit pessimistic and might give higher
  * overhead than we actually have */
-static int
+static size_t
 calc_control_channel_frame_overhead(const struct tls_session *session)
 {
     const struct key_state *ks = &session->key[KS_PRIMARY];
-    int overhead = 0;
+    size_t overhead = 0;
 
     /* opcode */
     overhead += 1;
@@ -226,10 +221,6 @@
     return overhead;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 init_ssl_lib(void)
 {
@@ -2650,7 +2641,7 @@
     int max_pkt_len = min_int(TLS_CHANNEL_BUF_SIZE, session->opt->frame.tun_mtu);
 
     /* Subtract overhead */
-    max_pkt_len -= calc_control_channel_frame_overhead(session);
+    max_pkt_len -= (int)calc_control_channel_frame_overhead(session);
 
     /* calculate total available length for outgoing tls ciphertext */
     int maxlen = max_pkt_len * rel_avail;

