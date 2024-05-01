From: Gert Doering <gert@...1296...>
Date: Wed,  1 May 2024 14:18:19 +0200
Message-ID: <20240501121819.12805-1-gert@...1296...>
In-Reply-To: <gerrit.1714486272000.I5d70198f6adbee8add619ee8a0bd6b5b1f61e506@...2715...>
References: <gerrit.1714486272000.I5d70198f6adbee8add619ee8a0bd6b5b1f61e506@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add missing EVP_KDF_CTX_free in
 ssl_tls1_PRF
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

This is just missing in the function. Found by clang+ASAN.

Change-Id: I5d70198f6adbee8add619ee8a0bd6b5b1f61e506
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/581
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b2c4eb6..61c6518 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1372,6 +1372,7 @@
 err:
     ret = false;
 out:
+    EVP_KDF_CTX_free(kctx);
     EVP_KDF_free(kdf);
 
     return ret;

