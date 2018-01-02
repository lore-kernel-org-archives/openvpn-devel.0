From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 2 Jan 2018 23:52:51 +0100
Message-ID: <1514933571-4592-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <CAKuzo_hHXfVBAp48kjsWy5ZUT22LyfMe2rCiz8evHyJrtYw0VQ@...278...>
References: <CAKuzo_hHXfVBAp48kjsWy5ZUT22LyfMe2rCiz8evHyJrtYw0VQ@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Don't throw fatal errors from
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

As with create_temp_file(), this function is called on client connects
and should not cause fatal errors when I/O (possibly temporarily) fails.
Fix this and the openssl backend implementation of x509_write_pem() to
no longer throw fatal errors.

The callers of this function are already fixed in the commit that does
the same for create_temp_file().

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: Use M_NONFATAL (instead of M_WARN/M_ERRNO), as suggested by Selva.
v3: Also fix x509_write_pem and unlink file on write error, per Selva too.

 src/openvpn/ssl_verify.c         | 9 ++++++---
 src/openvpn/ssl_verify_openssl.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ebb1da2..5ae4fbb 100644
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
 
@@ -557,13 +557,16 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
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
+        (void) platform_unlink(peercert_filename);
+        peercert_filename = NULL;
     }
 
     fclose(peercert_file);
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 02850fc..238292f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -767,7 +767,7 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
 {
     if (PEM_write_X509(peercert_file, peercert) < 0)
     {
-        msg(M_ERR, "Failed to write peer certificate in PEM format");
+        msg(M_NONFATAL, "Failed to write peer certificate in PEM format");
         return FAILURE;
     }
     return SUCCESS;
-- 
2.7.4


