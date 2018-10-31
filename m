From: Antonio Quartulli <a@...2181...>
Date: Thu,  1 Nov 2018 00:01:24 +0800
Message-Id: <20181031160124.26972-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tls-crypt: properly cast time_t to uint64_t
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

The exact type of time_t is platform dependent and therefore
can't be assumed to be uint64_t all the time.

For example, on 32bit platforms, where time_t is defined as long
(32bit), the compiler will generate the following warning, due
to the arithmetic used in the macro:

tls_crypt.c:745:29: warning: shift count >= width of type [-Wshift-count-overflow]

Force time_t to be parsed as uint64_t.

Reported-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tls_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d70d0a66..c3ed2b93 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -742,7 +742,7 @@ tls_crypt_v2_write_client_key_file(const char *filename,
     }
     else
     {
-        int64_t timestamp = htonll(now);
+        int64_t timestamp = htonll((uint64_t)now);
         ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));
         ASSERT(buf_write(&metadata, &timestamp, sizeof(timestamp)));
     }
-- 
2.19.1


