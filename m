From: Antonio Quartulli <a@...2181...>
Date: Wed,  8 Mar 2023 14:37:43 +0100
Message-Id: <20230308133743.5059-1-a@...2181...>
In-Reply-To: <7e5fc5f4-a17a-0266-f465-faa683cdcf31@...1227...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Avoid warning about missing braces when
 initialising key struct
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---

As concluded on IRC, this version does what we want it to do.
We also quickly tested with some sample program to make sure we weren't
making this up.


 src/openvpn/tls_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 81098355..3b68d186 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -348,7 +348,7 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct key2 *original_key,
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 client key format");
     }
 
-    struct key2 key2 = { .n = 2, .keys = { 0 } };
+    struct key2 key2 = { .n = 2 };
     if (!buf_read(&client_key, &key2.keys, sizeof(key2.keys)))
     {
         msg(M_FATAL, "ERROR: not enough data in tls-crypt-v2 client key");
-- 
2.39.2


