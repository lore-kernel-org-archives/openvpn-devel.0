From: Steffan Karger <steffan@...1856...>
Date: Fri, 13 May 2016 08:54:52 +0200
Message-Id: <1463122492-701-1-git-send-email-steffan@...1856...>
In-Reply-To: <57351238.2030602@...68...>
References: <57351238.2030602@...68...>
Subject: [Openvpn-devel] [PATCH] Fix polarssl / mbedtls builds
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

Commit 8a399cd3 hardened the OpenSSL default cipher list,
but also introduced a change in shared code that causes
polarssl / mbedtls builds to break when no --tls-cipher is
specified.

This fix is backported code from the master branch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 1f58369..9263698 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -176,7 +176,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
   char *tmp_ciphers, *tmp_ciphers_orig, *token;
   int i, cipher_count;
-  int ciphers_len = strlen (ciphers);
+  int ciphers_len;
+
+  if (NULL == ciphers)
+    return; /* Nothing to do */
+
+  ciphers_len = strlen (ciphers);
 
   ASSERT (NULL != ctx);
   ASSERT (0 != ciphers_len);
-- 
2.7.4


