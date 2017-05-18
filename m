From: Gert Doering <gert@...1296...>
Date: Thu, 18 May 2017 12:22:46 +0200
Message-Id: <20170518102246.5496-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix NCP behaviour on TLS reconnect.
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

If a client reconnects on a soft-restart from the same port (due to --bind
in use on the client), both sides will handle this as a "reconnect" and
not a "full new connect" internally, re-using existing crypto context.

The client will still ask the server for pushed options, and the server
code to handle this refuses to do NCP if a key has already been negotiated
(because there is no way to *change* the cipher after that) - which ends
up in "the client uses the non-negotiated cipher from the config file,
while the server uses the previously-negotiated NCP cipher", and nothing
works.

The easy workaround: if we find us in the situation that we think NCP
has already been done, just re-push "cipher o->ciphername" with the
current cipher for this client context.

All credits for this go to Stefan Behrens <sbehrens@...2269...>
who found and diagnosed the issue in trac #887, came up with a first
patch to solve the issue quite similar to this (simplified) one, and
helped testing.

Trac: #887
---
 src/openvpn/push.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8c3104e..bcef0ef 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -372,15 +372,17 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     /* Push cipher if client supports Negotiable Crypto Parameters */
     if (tls_peer_info_ncp_ver(peer_info) >= 2 && o->ncp_enabled)
     {
-        /* if we have already created our key, we cannot change our own
-         * cipher, so disable NCP and warn = explain why
+        /* if we have already created our key, we cannot *change* our own
+         * cipher -> so log the fact and push the "what we have now" cipher
+         * (so the client is always told what we expect it to use)
          */
         const struct tls_session *session = &tls_multi->session[TM_ACTIVE];
         if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
         {
             msg( M_INFO, "PUSH: client wants to negotiate cipher (NCP), but "
                  "server has already generated data channel keys, "
-                 "ignoring client request" );
+                 "re-sending previously negotiated cipher '%s'",
+                 o->ciphername );
         }
         else
         {
@@ -388,8 +390,8 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
              * TODO: actual negotiation, instead of server dictatorship. */
             char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
             o->ciphername = strtok(push_cipher, ":");
-            push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
         }
+        push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
     }
     else if (o->ncp_enabled)
     {
-- 
2.10.2


