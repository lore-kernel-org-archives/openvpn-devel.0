From: Gert Doering <gert@...1296...>
Date: Tue, 14 Apr 2026 07:59:21 +0200
Message-ID: <20260414055927.17252-1-gert@...1296...>
In-Reply-To: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
References: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_mbedtls: Fix format string in
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

From: Frank Lichtenheld <frank@...2641...>

These are unsigned values, so treat them as such.

Identified by cppcheck.

Change-Id: I232fba91cfcca6c35d37696bc86890a366f5967f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1626
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1626
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a62ff76..85c771a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1572,7 +1572,7 @@
 {
     static char mbedtls_version[30];
     unsigned int pv = mbedtls_version_get_number();
-    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %d.%d.%d", (pv >> 24) & 0xff,
+    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %u.%u.%u", (pv >> 24) & 0xff,
              (pv >> 16) & 0xff, (pv >> 8) & 0xff);
     return mbedtls_version;
 }

