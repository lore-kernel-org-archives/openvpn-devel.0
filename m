From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:06 +0200
Message-Id: <20210512131511.1309914-5-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/9] Add missing free_key_ctx for auth_token
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

This is is a small memory leak as this key is only leaked once
per server start.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1d77a9d42..49c742928 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2520,6 +2520,7 @@ key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
     if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
     {
         tls_ctx_free(&ks->ssl_ctx);
+        free_key_ctx(&ks->auth_token_key);
     }
     CLEAR(*ks);
 }
-- 
2.31.1


