From: selva.nair@...277...
Date: Sat, 13 Jan 2018 18:00:46 -0500
Message-Id: <1515884446-27152-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Use RSA_meth_free instead of free
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

From: Selva Nair <selva.nair@...277...>

- RSA_meth_new allocates memory for the name string
  and must be released using RSA_meth_free

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 34c31b9..d6d9acf 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1144,7 +1144,7 @@ err:
     {
         if (rsa_meth)
         {
-            free(rsa_meth);
+            RSA_meth_free(rsa_meth);
         }
     }
     crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
-- 
2.1.4


