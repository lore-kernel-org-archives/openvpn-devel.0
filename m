From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:19 +0100
Message-ID: <1320074961-3809-7-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/8] Moved from strsep to strtok,
	for Windows compatibility
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 ssl_polarssl.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/ssl_polarssl.c b/ssl_polarssl.c
index 9a8c49c..60d99a8 100644
--- a/ssl_polarssl.c
+++ b/ssl_polarssl.c
@@ -164,7 +164,7 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
-  char *tmp_ciphers, *tmp_ciphers_orig;
+  char *tmp_ciphers, *tmp_ciphers_orig, *token;
   int i, cipher_count;
   int ciphers_len = strlen (ciphers);
 
@@ -182,11 +182,15 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
   /* Parse allowed ciphers, getting IDs */
   i = 0;
   tmp_ciphers_orig = tmp_ciphers = strdup(ciphers);
-  while(tmp_ciphers) {
-      ctx->allowed_ciphers[i] = ssl_get_ciphersuite_id (strsep (&tmp_ciphers, ":"));
-      if (ctx->allowed_ciphers[i] != 0)
+
+  token = strtok (tmp_ciphers, ":");
+  while(token)
+    {
+      ctx->allowed_ciphers[i] = ssl_get_ciphersuite_id (token);
+      if (0 != ctx->allowed_ciphers[i])
 	i++;
-  }
+      token = strtok (NULL, ":");
+    }
   free(tmp_ciphers_orig);
 }
 
-- 
1.7.5.4


