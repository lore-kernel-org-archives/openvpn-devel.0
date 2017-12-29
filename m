From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 29 Dec 2017 11:18:58 +0100
Message-ID: <1514542738-20402-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <CAKuzo_jJx0U0hEnuv=BFGm_d6ME4JP44mDCCoBPwzCBdRs+dVA@...278...>
References: <CAKuzo_jJx0U0hEnuv=BFGm_d6ME4JP44mDCCoBPwzCBdRs+dVA@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Don't throw fatal errors from
 verify_cert_export_cert()
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

As with create_temp_file(), this function is called on client connects and
should not cause fatal errors when I/O (possibly temporarily) fails.

The callers of this function are already fixed in the commit that does the
same for create_temp_file().

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: Use M_NONFATAL (instead of M_WARN/M_ERRNO), as suggested by Selva.

 src/openvpn/ssl_verify.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ebb1da2..0ba9f41 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -549,7 +549,7 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
     if (!tmp_dir
         || !(peercert_filename = create_temp_file(tmp_dir, "pcf", gc)))
     {
-        msg (M_WARN, "Failed to create peer cert file");
+        msg(M_NONFATAL, "Failed to create peer cert file");
         return NULL;
     }
 
@@ -557,13 +557,15 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
     peercert_file = fopen(peercert_filename, "w+");
     if (!peercert_file)
     {
-        msg(M_ERR, "Failed to open temporary file : %s", peercert_filename);
+        msg(M_NONFATAL|M_ERRNO, "Failed to open temporary file: %s",
+            peercert_filename);
         return NULL;
     }
 
     if (SUCCESS != x509_write_pem(peercert_file, peercert))
     {
-        msg(M_ERR, "Error writing PEM file containing certificate");
+        msg(M_NONFATAL, "Error writing PEM file containing certificate");
+        peercert_filename = NULL;
     }
 
     fclose(peercert_file);
-- 
2.7.4


