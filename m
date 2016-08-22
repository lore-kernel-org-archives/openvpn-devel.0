From: Gert Doering <gert@...1296...>
Date: Mon, 22 Aug 2016 21:22:59 +0200
Message-Id: <1471893779-8041-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix problems with NCP and --inetd.
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

NCP only works with --pull or --mode server, leading to breakage
in --inetd mode (because that has --tls-server, but not --mode server,
but clients can still ask for PUSH_REQUEST).

Fix by turning off o->ncp_enable unless (pull or mode server), and
double-fix by logging an appropriate message and refusing to change
ciphers if the server has already set up its keys.

Trac #715

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c |  8 ++++++++
 src/openvpn/push.c    | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c100d4c..a2b22f4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2614,6 +2614,14 @@ options_postprocess_mutate (struct options *o)
       if (streq (o->dh_file, "none"))
 	o->dh_file = NULL;
     }
+
+  /* cipher negotiation (NCP) currently assumes --pull or --mode server */
+  if ( o->ncp_enabled &&
+        ! (o->pull || o->mode == MODE_SERVER) )
+    {
+      msg( M_WARN, "disabling NCP mode (--ncp-disable) because not in P2MP client or server mode" );
+      o->ncp_enabled = false;
+    }
 #endif
 
 #if ENABLE_MANAGEMENT
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 000c82f..4bdede9 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -321,11 +321,22 @@ prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
   /* Push cipher if client supports Negotiable Crypto Parameters */
   if (tls_peer_info_ncp_ver (peer_info) >= 2 && o->ncp_enabled)
     {
-      /* Push the first cipher from --ncp-ciphers to the client.
-       * TODO: actual negotiation, instead of server dictatorship. */
-      char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
-      o->ciphername = strtok (push_cipher, ":");
-      push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
+      /* if we have already created our key, we cannot change our own
+       * cipher, so disable NCP and warn = explain why
+       */
+      struct tls_session *session = &tls_multi->session[TM_ACTIVE];
+      if ( session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized )
+	{
+	   msg( M_INFO, "PUSH: client wants to negotiate cipher (NCP), but server has already generated data channel keys, ignoring client request" );
+	}
+      else
+	{
+	  /* Push the first cipher from --ncp-ciphers to the client.
+	   * TODO: actual negotiation, instead of server dictatorship. */
+	  char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
+	  o->ciphername = strtok (push_cipher, ":");
+	  push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
+	}
     }
   return true;
 }
-- 
2.7.3


