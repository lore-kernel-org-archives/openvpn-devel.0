From: Gert Doering <gert@...1296...>
Date: Sun, 24 May 2015 15:02:34 +0200
Message-Id: <1432472554-24666-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Disallow usage of --server-poll-timeout in
	--secret key mode.
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

The internal machinery wants TLS for this to work, so just add this
to the (long) list of options not allowed unless either --tls-client
or --tls-server is active.  For added sanity, add an ASSERT() call
to place where this combination caused a NULL ptr reference, and
document the restriction.

Fix trac #373

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         | 4 ++++
 src/openvpn/forward.c | 1 +
 src/openvpn/options.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b1c2fab..3fff3f2 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3783,6 +3783,10 @@ when polling possible remote servers to connect to
 in a round-robin fashion, spend no more than
 .B n
 seconds waiting for a response before trying the next server.
+As this only makes sense in client-to-server setups, it cannot
+be used in point-to-point setups using
+.B \-\-secret
+symmetrical key mode.
 .\"*********************************************************
 .TP
 .B \-\-explicit\-exit\-notify [n]
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a3323e9..6d459d2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -328,6 +328,7 @@ void
 check_server_poll_timeout_dowork (struct context *c)
 {
   event_timeout_reset (&c->c2.server_poll_interval);
+  ASSERT(c->c2.tls_multi);
   if (!tls_initial_packet_received (c->c2.tls_multi))
     {
       msg (M_INFO, "Server poll timeout, restarting");
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bc7f3c6..92d51c3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2288,6 +2288,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (tls_export_cert);
       MUST_BE_UNDEF (verify_x509_name);
       MUST_BE_UNDEF (tls_timeout);
+      MUST_BE_UNDEF (server_poll_timeout);
       MUST_BE_UNDEF (renegotiate_bytes);
       MUST_BE_UNDEF (renegotiate_packets);
       MUST_BE_UNDEF (renegotiate_seconds);
-- 
2.3.6


