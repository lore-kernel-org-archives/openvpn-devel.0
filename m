From: Arne Schwabe <arne@...1227...>
Date: Fri,  3 Apr 2020 11:09:44 +0200
Message-Id: <20200403090944.17726-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix off-by-one in tls-crypt-v2 client
 wrapping with custom metadata
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

Instead of writing at the end of the metadata buffer, the decoded
base64 data overwrites the opcode as BPTR points to the beginning
of the buffer and not the current position. Replace with BEND to
fix this off-by-one

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tls_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 37df2ce7..e9f9cc2a 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -664,7 +664,7 @@ tls_crypt_v2_write_client_key_file(const char *filename,
                 (int)strlen(b64_metadata), TLS_CRYPT_V2_MAX_B64_METADATA_LEN);
         }
         ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
-        int decoded_len = openvpn_base64_decode(b64_metadata, BPTR(&metadata),
+        int decoded_len = openvpn_base64_decode(b64_metadata, BEND(&metadata),
                                                 BCAP(&metadata));
         if (decoded_len < 0)
         {
-- 
2.26.0


