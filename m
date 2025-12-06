From: Gert Doering <gert@...1296...>
Date: Sat,  6 Dec 2025 21:58:16 +0100
Message-ID: <20251206205829.27254-1-gert@...1296...>
In-Reply-To: <gerrit.1765054252000.I0d592d9d0c7ead296869f933c206c5d55e6cbed1@...2715...>
References: <gerrit.1765054252000.I0d592d9d0c7ead296869f933c206c5d55e6cbed1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] mbedtls: gracefully exit if certificate
 file is NULL
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

From: Steffan Karger <steffan@...1856...>

Instead of crashing because we feed a NULL pointer to strlen(),
gracefully exit with an error message.

While at it, improve the error message a bit.

Change-Id: I0d592d9d0c7ead296869f933c206c5d55e6cbed1
Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1419
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1419
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 83fca78..3440319 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -466,10 +466,14 @@
 
     if (cert_inline)
     {
+        if (!cert_file)
+        {
+            msg(M_FATAL, "Cannot load inline certificate: NULL");
+        }
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain, (const unsigned char *)cert_file,
                                             strlen(cert_file) + 1)))
         {
-            msg(M_FATAL, "Cannot load inline certificate file");
+            msg(M_FATAL, "Cannot load inline certificate");
         }
     }
     else

