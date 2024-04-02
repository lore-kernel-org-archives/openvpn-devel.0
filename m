From: Gert Doering <gert@...1296...>
Date: Tue,  2 Apr 2024 14:22:23 +0200
Message-ID: <20240402122223.22183-1-gert@...1296...>
In-Reply-To: <gerrit.1712017317000.I911e25949a8647b567fd4178683534d4404ab469@...2715...>
References: <gerrit.1712017317000.I911e25949a8647b567fd4178683534d4404ab469@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove redundant call of EVP_CipherInit
 before EVP_CipherInit_Ex
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

From: Arne Schwabe <arne@...1227...>

EVP_CipherInit basically is the same EVP_CipherInit_ex except that it
in some instances it resets/inits the ctx parameter first. We already
call EVP_CIPHER_CTX_reset to reset/init the ctx before so this call does
not do anything useful.

OpenSSL 1.0.2:

https://github.com/openssl/openssl/blob/OpenSSL_1_0_2-stable/crypto/evp/evp_enc.c#L94

EVP_CipherInit calls first EVP_CIPHER_CTX_init and then EVP_CipherInit_ex

Our openssl_compat.h has

for these older OpenSSL versions

OpenSSL 3.0:

https://github.com/openssl/openssl/blob/openssl-3.2/crypto/evp/evp_enc.c#L450

basically the same as 1.0.2. Just that method names have been changed.

Change-Id: I911e25949a8647b567fd4178683534d4404ab469
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/552
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index bfc5e37..13dfa8c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -846,10 +846,6 @@
     evp_cipher_type *kt = cipher_get(ciphername);
 
     EVP_CIPHER_CTX_reset(ctx);
-    if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
-    {
-        crypto_msg(M_FATAL, "EVP cipher init #1");
-    }
     if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL, enc))
     {
         crypto_msg(M_FATAL, "EVP cipher init #2");

