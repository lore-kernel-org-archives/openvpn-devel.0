From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 22 May 2017 15:54:13 +0200
Message-ID: <1495461253-20111-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openssl: fix overflow check for long
	--tls-cipher option
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

The length check in tls_ctx_restrict_ciphers() did not check for overflow,
which could lead to a stack buffer overflow.

This has no real-world impact, because --tls-cipher can only be specified
by entities that are allowed to supply config settings.  Since those
entities can also change --script-security and call scripts and/or
plugins, these users already have code execution at the level of the
openvpn process.  In other words: the attacker would not gain any
capabilities.  Nevertheless, a nasty bug that we should fix.

This bug was discovered and reported to the OpenVPN security team by
Guido Vranken.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_openssl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 645ccf5..73c07e3 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -352,7 +352,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
         }
 
         /* Make sure new cipher name fits in cipher string */
-        if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len)
+        if ((SIZE_MAX - openssl_ciphers_len) < current_cipher_len
+            || ((sizeof(openssl_ciphers)-1) < openssl_ciphers_len + current_cipher_len))
         {
             msg(M_FATAL,
                 "Failed to set restricted TLS cipher list, too long (>%d).",
-- 
2.7.4


