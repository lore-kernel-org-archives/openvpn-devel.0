From: Gert Doering <gert@...1296...>
Date: Tue,  2 Apr 2024 08:36:46 +0200
Message-ID: <20240402063646.25490-1-gert@...1296...>
In-Reply-To: <gerrit.1712017317000.I5b14bf90bb07935f0bb84373ec4e62352752c03f@...2715...>
References: <gerrit.1712017317000.I5b14bf90bb07935f0bb84373ec4e62352752c03f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Match ifdef for get_sigtype function
 with if ifdef of caller
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

These two ifdef needs to be the same otherwise the compiler will
break with a undefined function.

Change-Id: I5b14bf90bb07935f0bb84373ec4e62352752c03f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/551
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6f29c3d..a158617 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2166,7 +2166,8 @@
     EVP_PKEY_free(pkey);
 }
 
-#if !defined(LIBRESSL_VERSION_NUMBER)  && OPENSSL_VERSION_NUMBER >= 0x1010000fL
+#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x1010000fL) \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >= 0x3090000fL)
 /**
  * Translate an OpenSSL NID into a more human readable name
  * @param nid

