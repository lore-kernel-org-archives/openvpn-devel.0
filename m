From: Gert Doering <gert@...1296...>
Date: Mon, 25 Mar 2024 13:50:52 +0100
Message-ID: <20240325125052.14135-1-gert@...1296...>
In-Reply-To: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
References: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Use snprintf instead of sprintf for
 get_ssl_library_version
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

This is avoid a warning/error (when using -Werror) under current macOS
of sprintf:

   __deprecated_msg("This function is provided for compatibility
   reasons only.  Due to security concerns inherent in the design
   of sprintf(3), it is highly recommended that you use snprintf(3)
   instead.")

Change-Id: I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/545
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b44ddd5..0730d25 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1614,7 +1614,7 @@
 {
     static char mbedtls_version[30];
     unsigned int pv = mbedtls_version_get_number();
-    sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
+    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %d.%d.%d",
              (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
     return mbedtls_version;
 }

