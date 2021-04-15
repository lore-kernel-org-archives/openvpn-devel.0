From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Thu, 15 Apr 2021 11:34:54 +0200
Message-ID: <20210415093454.18324-1-maximilian.fillinger@...2507...>
In-Reply-To: <4743b2e0-89bf-29f9-f406-867d35c9bb1d@...2181...>
References: <4743b2e0-89bf-29f9-f406-867d35c9bb1d@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 2/2] Abort if CRL file can't be stat-ed
 in ssl_init
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
Cc: a@...2181...

Now that the path for the CRL file is handled correctly when using
chroot, there's no good reason for the file to be inaccessible during
ssl_init().

This commit ensures that the CRL file is accessed successfully at least
once, which fixes a bug where the mbedtls version of OpenVPN wouldn't
use a reloaded CRL if it initially failed to access the file.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/ssl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1e0e6170..6ce1d079 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -559,7 +559,15 @@ tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
     }
     else if (platform_stat(crl_file, &crl_stat) < 0)
     {
-        msg(M_WARN, "WARNING: Failed to stat CRL file, not (re)loading CRL.");
+        /* If crl_last_mtime is zero, the CRL file has not been read before. */
+        if (ssl_ctx->crl_last_mtime == 0)
+        {
+            msg(M_FATAL, "ERROR: Failed to stat CRL file during initialization, exiting.");
+        }
+        else
+        {
+            msg(M_WARN, "WARNING: Failed to stat CRL file, not reloading CRL.");
+        }
         return;
     }
 
-- 
2.11.0


