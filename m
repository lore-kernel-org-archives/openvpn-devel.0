From: Steffan Karger <steffan@...1856...>
Date: Thu, 20 Jul 2017 19:55:57 +0200
Message-Id: <1500573357-20496-1-git-send-email-steffan@...1856...>
In-Reply-To: <20170701075919.GF2133@...2287...>
References: <20170701075919.GF2133@...2287...>
Subject: [Openvpn-devel] [PATCH v2] Always use default keysize for NCP'd
 ciphers
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

If a peer has set --keysize, and NCP negotiates a cipher with a different
key size (e.g. --keysize 128 + AES-256-GCM), that peer will exit with a
"invalid key size" error.  To prevent that, always set keysize=0 for NCP'd
ciphers.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2 - print log message when we override the user-set keysize

 src/openvpn/ssl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b1c26b3..8440f27 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1976,6 +1976,11 @@ tls_session_update_crypto_params(struct tls_session *session,
     {
         msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
             options->ciphername);
+        if (options->keysize)
+        {
+            msg(D_HANDSHAKE, "NCP: overriding user-set keysize with default");
+            options->keysize = 0;
+        }
     }
 
     init_key_type(&session->opt->key_type, options->ciphername,
-- 
2.7.4


