From: Arne Schwabe <arne@...1227...>
Date: Sat, 17 Sep 2016 16:15:38 +0200
Message-Id: <1474121738-19420-1-git-send-email-arne@...1227...>
In-Reply-To: <0160917135948.GV78279@...1296...>
References: <0160917135948.GV78279@...1296...>
Subject: [Openvpn-devel] [PATCHv2] Enable TCP non-linear packet ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Implementation with multiple threads needs that to be able run encryption in parallel. Tested with James' OpenVPN 3 server.
---
 src/openvpn/comp.c      | 1 +
 src/openvpn/init.c      | 1 -
 src/openvpn/options.c   | 5 -----
 src/openvpn/packet_id.c | 7 +++----
 src/openvpn/packet_id.h | 2 +-
 src/openvpn/ssl.c       | 3 +--
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 3a32c62..61f6f08 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -160,6 +160,7 @@ comp_generate_peer_info_string(const struct compress_options *opt, struct buffer
 	buf_printf (out, "IV_LZO_STUB=1\n");
       buf_printf (out, "IV_COMP_STUB=1\n");
       buf_printf (out, "IV_COMP_STUBv2=1\n");
+    buf_printf (out, "IV_TCPNL=1\n");
     }
 }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9cd3d9f..fdeaf95 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2143,7 +2143,6 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
   if (options->replay)
     {
       packet_id_init (&c->c2.crypto_options.packet_id,
-		      link_socket_proto_connection_oriented (options->ce.proto),
 		      options->replay_window,
 		      options->replay_time,
 		      "STATIC", 0);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dd7d461..1be32ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2215,11 +2215,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
   /*
    * Check consistency of replay options
    */
-  if ((!proto_is_udp(ce->proto))
-      && (options->replay_window != defaults.replay_window
-	  || options->replay_time != defaults.replay_time))
-    msg (M_USAGE, "--replay-window only makes sense with --proto udp");
-
   if (!options->replay
       && (options->replay_window != defaults.replay_window
 	  || options->replay_time != defaults.replay_time))
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index baa4966..9874519 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -76,10 +76,9 @@ packet_id_debug (int msglevel,
 }
 
 void
-packet_id_init (struct packet_id *p, bool tcp_mode, int seq_backtrack, int time_backtrack, const char *name, int unit)
+packet_id_init (struct packet_id *p, int seq_backtrack, int time_backtrack, const char *name, int unit)
 {
-  dmsg (D_PID_DEBUG, "PID packet_id_init tcp_mode=%d seq_backtrack=%d time_backtrack=%d",
-	tcp_mode,
+  dmsg (D_PID_DEBUG, "PID packet_id_init seq_backtrack=%d time_backtrack=%d",
 	seq_backtrack,
 	time_backtrack);
 
@@ -88,7 +87,7 @@ packet_id_init (struct packet_id *p, bool tcp_mode, int seq_backtrack, int time_
 
   p->rec.name = name;
   p->rec.unit = unit;
-  if (seq_backtrack && !tcp_mode)
+  if (seq_backtrack)
     {
       ASSERT (MIN_SEQ_BACKTRACK <= seq_backtrack && seq_backtrack <= MAX_SEQ_BACKTRACK);
       ASSERT (MIN_TIME_BACKTRACK <= time_backtrack && time_backtrack <= MAX_TIME_BACKTRACK);
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 5eb501d..fb059b7 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -210,7 +210,7 @@ struct packet_id
   struct packet_id_rec rec;
 };
 
-void packet_id_init (struct packet_id *p, bool tcp_mode, int seq_backtrack, int time_backtrack, const char *name, int unit);
+void packet_id_init (struct packet_id *p, int seq_backtrack, int time_backtrack, const char *name, int unit);
 void packet_id_free (struct packet_id *p);
 
 /* should we accept an incoming packet id ? */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8717324..c7823b2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -799,7 +799,7 @@ key_state_init (struct tls_session *session, struct key_state *ks)
   /* init packet ID tracker */
   if (session->opt->replay)
     {
-      packet_id_init (&ks->crypto_options.packet_id, session->opt->tcp_mode,
+      packet_id_init (&ks->crypto_options.packet_id,
 	  session->opt->replay_window, session->opt->replay_time, "SSL",
 	  ks->key_id);
     }
@@ -948,7 +948,6 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
 
   /* initialize packet ID replay window for --tls-auth */
   packet_id_init (&session->tls_auth.packet_id,
-		  session->opt->tcp_mode,
 		  session->opt->replay_window,
 		  session->opt->replay_time,
 		  "TLS_AUTH", session->key_id);
-- 
2.8.4 (Apple Git-73)


