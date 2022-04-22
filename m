From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:33 +0200
Message-Id: <20220422134038.3801239-5-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 04/28] Add documentation for swap_hmac
 function
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4ebf5acc2..f58f3b727 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1366,10 +1366,7 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 }
 
 
-/*
- * Move a packet authentication HMAC + related fields to or from the front
- * of the buffer so it can be processed by encrypt/decrypt.
- */
+
 
 /*
  * Dependent on hmac size, opcode size, and session_id size.
@@ -1377,6 +1374,23 @@ tls_multi_free(struct tls_multi *multi, bool clear)
  */
 #define SWAP_BUF_SIZE 256
 
+/**
+ * Move a packet authentication HMAC + related fields to or from the front
+ * of the buffer so it can be processed by encrypt/decrypt.
+ *
+ * Turning the on wire format that starts with the opcode to a format
+ * that starts with the hmac
+ * e.g. "onwire" [opcode + packet id] [hmac] [remainder of packed]
+ *
+ *
+ *    "internal" [hmac] [opcode + packet id] [remainer of packet]
+ *
+ *  @param buf      the buffer the swap operation is executed on
+ *  @param incoming determines the direction of the swap
+ *  @param co       crypto options, determines the hmac to use in the swap
+ *
+ *  @return         if the swap was successful (buf was large enough)
+ */
 static bool
 swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
 {
-- 
2.32.0 (Apple Git-132)


