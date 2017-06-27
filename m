From: Steffan Karger <steffan@...1856...>
Date: Wed, 28 Jun 2017 00:20:29 +0200
Message-Id: <20170627222029.26623-1-steffan@...1856...>
In-Reply-To: <20170627172948.GX97029@...1296...>
References: <20170627172948.GX97029@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Undo cipher push in client options state
 if cipher is rejected
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

Because of the way we re-use the options parser for both config files and
pushed options, we always update the local options state when we accept an
option.  This resulted in a pushed cipher being rejected the first time it
was pushed, but being accepted the second time.

This patch is a minimal way to resolve this issue in the master and
release/2.4 branches.  I'll send a more invasive patch for master, to
reset the entire options state on reconnects, later.

Trac: #906

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2 - send the _entire_ patch, not just 1 hunk...

 src/openvpn/ssl.c | 4 +++-
 src/openvpn/ssl.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index bbc1c965..f868457e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1958,7 +1958,7 @@ cleanup:
 
 bool
 tls_session_update_crypto_params(struct tls_session *session,
-                                 const struct options *options, struct frame *frame)
+                                 struct options *options, struct frame *frame)
 {
     if (!session->opt->server
         && 0 != strcmp(options->ciphername, session->opt->config_ciphername)
@@ -1967,6 +1967,8 @@ tls_session_update_crypto_params(struct tls_session *session,
         msg(D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
             options->ciphername, session->opt->config_ciphername,
             options->ncp_ciphers);
+        /* undo cipher push, abort connection setup */
+        options->ciphername = session->opt->config_ciphername;
         return false;
     }
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 56ea6013..0e0f68fa 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -481,7 +481,7 @@ void tls_update_remote_addr(struct tls_multi *multi,
  * @return true if updating succeeded, false otherwise.
  */
 bool tls_session_update_crypto_params(struct tls_session *session,
-                                      const struct options *options, struct frame *frame);
+                                      struct options *options, struct frame *frame);
 
 /**
  * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
-- 
2.11.0


