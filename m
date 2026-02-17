From: Gert Doering <gert@...1296...>
Date: Tue, 17 Feb 2026 18:13:00 +0100
Message-ID: <20260217171306.31229-1-gert@...1296...>
In-Reply-To: <gerrit.1771329387000.Ia5d330fe5c922aaa6948c1fb05c9a4947c833311@...2715...>
References: <gerrit.1771329387000.Ia5d330fe5c922aaa6948c1fb05c9a4947c833311@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Unbreak Mbed TLS 4 build
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

From: Max Fillinger <maximilian.fillinger@...2918...>

The previous Mbed TLS 4 change removed the mbedtls/version.h include
from syshead.h. But this include in mbedtls_compat.h where it's needed.

Also fix a warning by removing a size_t < 0 comparison.

Change-Id: Ia5d330fe5c922aaa6948c1fb05c9a4947c833311
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1538
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1538
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index cba6bb5..e8931d7 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -700,7 +700,7 @@
 md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
 {
     const md_info_t *md = md_get(mdname);
-    if (md == NULL || src_len < 0)
+    if (md == NULL)
     {
         return false;
     }
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 667529e..50739b6 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -36,6 +36,7 @@
 
 #include <mbedtls/asn1.h>
 #include <mbedtls/pk.h>
+#include <mbedtls/version.h>
 
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
 #include <mbedtls/ctr_drbg.h>

