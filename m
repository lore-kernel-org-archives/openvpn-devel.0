From: Jeff <os.gv.ll@...277...>
Date: Tue,  8 Jun 2021 09:32:50 +0800
Message-Id: <1623115970-9186-1-git-send-email-os.gv.ll@...277...>
Subject: [Openvpn-devel] [PATCH] duplicate function declaration.
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

---
 src/openvpn/crypto_backend.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 35cd918..af123d0 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -88,18 +88,6 @@ void crypto_init_dmalloc(void);
 
 #endif /* DMALLOC */
 
-/**
- * Translate a data channel cipher name from the OpenVPN config file
- * 'language' to the crypto library specific name.
- */
-const char *translate_cipher_name_from_openvpn(const char *cipher_name);
-
-/**
- * Translate a data channel cipher name from the crypto library specific name
- * to the OpenVPN config file 'language'.
- */
-const char *translate_cipher_name_from_openvpn(const char *cipher_name);
-
 void show_available_ciphers(void);
 
 void show_available_digests(void);
-- 
2.7.4


