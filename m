From: Arne Schwabe <arne@...1227...>
Date: Mon, 30 Nov 2020 13:38:13 +0100
Message-Id: <20201130123813.21388-1-arne@...1227...>
In-Reply-To: <20201120160418.17690-1-arne@...1227...>
References: <20201120160418.17690-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Fix port-share option with TLS-Crypt v2
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

The port-share option assumed that all openvpn initial reset packets
are between 14 and 255 bytes long. This is not true for tls-crypt-v2.

Patch V2: use correct length for TLS-Crypt v2, use length variable
          non-tlscryptv2 test

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ps.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 2089e6b9..5d760782 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -983,14 +983,38 @@ is_openvpn_protocol(const struct buffer *buf)
     const int len = BLEN(buf);
     if (len >= 3)
     {
-        return p[0] == 0
-               && p[1] >= 14
-               && (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT)
-                   || p[2] == (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT));
+        int plen = (p[0] << 8) | p[1];
+
+        if (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT))
+        {
+            /* WKc is at least 290 byte (not including metadata):
+             *
+             * 16 bit len + 256 bit HMAC + 2048 bit Kc = 2320 bit
+             *
+             * This is increased by the normal length of client handshake +
+             * tls-crypt overhead (32)
+             *
+             * For metadata tls-crypt-v2.txt does not explicitly specify
+             * an upper limit but we also have TLS_CRYPT_V2_MAX_WKC_LEN
+             * as 1024 bytes. We err on the safe side with 255 extra overhead
+             *
+             * We don't do the 2 byte check for tls-crypt-v2 because it is very
+             * unrealistic to have only 2 bytes available.
+             */
+            return  (plen >= 336 && plen < (1024 + 255));
+        }
+        else
+        {
+            /* For non tls-crypt2 we assume the packet length to valid between
+             * 14 and 255 */
+            return plen >= 14 && plen <= 255
+                   && (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT));
+        }
     }
     else if (len >= 2)
     {
-        return p[0] == 0 && p[1] >= 14;
+        int plen = (p[0] << 8) | p[1];
+        return plen >= 14 && plen <= 255;
     }
     else
     {
-- 
2.26.2


