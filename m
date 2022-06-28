From: Antonio Quartulli <a@...2181...>
Date: Tue, 28 Jun 2022 11:41:44 +0200
Message-Id: <20220628094144.17471-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tls-crypt-v2: bail out if the client key is
 too small
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

The tls-crypt-v2 key should be at least 2 bytes long in order to read
the actual length.

Bail out if the key is too short.
Failing to do so will lead to a read out of the buffer boundary.

While at it improve the error message a bit.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tls_crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 88730a99..2fc79111 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -557,7 +557,8 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
 
     if (BLEN(&wrapped_client_key) < sizeof(net_len))
     {
-        msg(D_TLS_ERRORS, "failed to read length");
+        msg(D_TLS_ERRORS, "Can not read tls-crypt-v2 client key length");
+        return false;
     }
     memcpy(&net_len, BEND(&wrapped_client_key) - sizeof(net_len),
            sizeof(net_len));
-- 
2.35.1


