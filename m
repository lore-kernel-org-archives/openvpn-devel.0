From: Gert Doering <gert@...1296...>
Date: Sun, 26 Oct 2025 15:35:14 +0100
Message-ID: <20251026143521.13291-1-gert@...1296...>
In-Reply-To: <gerrit.1761489176000.I5b6881dc73358c8d1249ee2ceb968ede295105b0@...2715...>
References: <gerrit.1761489176000.I5b6881dc73358c8d1249ee2ceb968ede295105b0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_mbedtls: fix missing perf_pop() call
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

This was triggered by a bug report submitted by Joshua Rogers, who
used ZeroPath to discover we missed a perf_pop() call in one of the
error paths of ssl_mbedtls.c.

Move an existing perf_pop call a bit upwards to fix that.

The perf code is always disabled by ENABLE_PERFORMANCE_METRICS being
commented out in perf.h. There is no configure flag. None of the active
developers remembers using it and the git log shows no actual code changes
since at least the project structure overhaul of 2012. So this has no
real-world impact.

Change-Id: I5b6881dc73358c8d1249ee2ceb968ede295105b0
Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1305
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1305
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8fb69c3..2862989 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1489,13 +1489,13 @@
     /* Error during read, check for retry error */
     if (retval < 0)
     {
+        perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
             return 0;
         }
         mbed_log_err(D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
         buf->len = 0;
-        perf_pop();
         return -1;
     }
     /* Nothing read, try again */

