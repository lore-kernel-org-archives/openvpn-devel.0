From: Steffan Karger <steffan@...1856...>
Date: Tue, 29 Jul 2014 23:04:26 +0200
Message-Id: <1406667866-14226-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix typo in cipher_kt_mode_{cbc,
	ofb_cfb}() doxygen.
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_backend.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index a48ad6c..bc067a7 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -231,7 +231,7 @@ int cipher_kt_block_size (const cipher_kt_t *cipher_kt);
 int cipher_kt_mode (const cipher_kt_t *cipher_kt);
 
 /**
- * Check of the supplied cipher is a supported CBC mode cipher.
+ * Check if the supplied cipher is a supported CBC mode cipher.
  *
  * @param cipher	Static cipher parameters. May not be NULL.
  *
@@ -241,7 +241,7 @@ bool cipher_kt_mode_cbc(const cipher_kt_t *cipher)
   __attribute__((nonnull));
 
 /**
- * Check of the supplied cipher is a supported OFB or CFB mode cipher.
+ * Check if the supplied cipher is a supported OFB or CFB mode cipher.
  *
  * @param cipher	Static cipher parameters. May not be NULL.
  *
-- 
1.9.1


