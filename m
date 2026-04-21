From: Gert Doering <gert@...1296...>
Date: Tue, 21 Apr 2026 07:53:50 +0200
Message-ID: <20260421055357.21708-1-gert@...1296...>
In-Reply-To: <gerrit.1776718304000.Ica5f37e525c3812609021750ecd3986c1420e2a4@...2715...>
References: <gerrit.1776718304000.Ica5f37e525c3812609021750ecd3986c1420e2a4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Mbed TLS: Error out if we have no valid
 tls-groups
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

Previously, when no valid groups were specified with the tls-groups
option, the Mbed TLS build of OpenVPN would start up and run, but fail
to complete a handshake, while the OpenSSL build would exit with an
error. This commit changes the behavior of the Mbed TLS build to match
the OpenSSL version.

Change-Id: Ica5f37e525c3812609021750ecd3986c1420e2a4
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1633
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1633
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 85c771a..8a0f7d2 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -450,6 +450,12 @@
         }
     }
 
+    /* Check if any groups were valid. */
+    if (i == 0)
+    {
+        msg(M_FATAL, "Error: All groups in \"%s\" are invalid or unsupported.", groups);
+    }
+
     /* Recent mbedtls versions state that the list of groups must be terminated
      * with 0. Older versions state that it must be terminated with MBEDTLS_ECP_DP_NONE
      * which is also 0, so this works either way. */

