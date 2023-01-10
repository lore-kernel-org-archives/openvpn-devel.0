From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 10 Jan 2023 14:19:47 +0100
Message-Id: <20230110131947.59552-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] xkey_pkcs11h_sign: fix dangling pointer
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

Warning by GCC 12:
pkcs11_openssl.c:237:22: warning:
dangling pointer ‘tbs’ to ‘enc’ may be used [-Wdangling-pointer=]

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/pkcs11_openssl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 60bc1c47..ecf37ba0 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -169,6 +169,9 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
     unsigned char buf[EVP_MAX_MD_SIZE];
     size_t buflen;
 
+    unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for DigestInfo header */
+    size_t enc_len = sizeof(enc);
+
     if (!strcmp(sigalg.op, "DigestSign"))
     {
         msg(D_XKEY, "xkey_pkcs11h_sign: computing digest");
@@ -214,9 +217,6 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
         {
             /* CMA_RSA_PKCS needs pkcs1 encoded digest */
 
-            unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for DigestInfo header */
-            size_t enc_len = sizeof(enc);
-
             if (!encode_pkcs1(enc, &enc_len, sigalg.mdname, tbs, tbslen))
             {
                 return 0;
-- 
2.34.1


