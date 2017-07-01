From: Steffan Karger <steffan@...1856...>
Date: Sat,  1 Jul 2017 09:38:20 +0200
Message-Id: <20170701073820.14809-1-steffan@...1856...>
In-Reply-To: <d6b9bca0-3ce4-0392-72b3-207eeada1a63@...2288...>
References: <d6b9bca0-3ce4-0392-72b3-207eeada1a63@...2288...>
Subject: [Openvpn-devel] [PATCH] Always use default keysize for NCP'd ciphers
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
 src/openvpn/ssl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f868457e..a8418d37 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1976,6 +1976,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     {
         msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
             options->ciphername);
+        options->keysize = 0; /* Always use default key size for NCP */
     }
 
     init_key_type(&session->opt->key_type, options->ciphername,
-- 
2.11.0


