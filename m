From: Steffan Karger <steffan@...1856...>
Date: Fri,  8 Dec 2017 11:33:31 +0100
Message-Id: <1512729211-8407-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Don't throw fatal errors from
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

From: Steffan Karger <steffan.karger@...1435...>

As with create_temp_file(), this function is called on client connects and
should not cause fatal errors when I/O (possibly temporarily) fails.

The callers of this function are already fixed in the commit that does the
same for create_temp_file().

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_verify.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ebb1da2..12cff9a 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -557,13 +557,14 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
     peercert_file = fopen(peercert_filename, "w+");
     if (!peercert_file)
     {
-        msg(M_ERR, "Failed to open temporary file : %s", peercert_filename);
+        msg(M_ERRNO, "Failed to open temporary file : %s", peercert_filename);
         return NULL;
     }
 
     if (SUCCESS != x509_write_pem(peercert_file, peercert))
     {
-        msg(M_ERR, "Error writing PEM file containing certificate");
+        msg(M_WARN, "Error writing PEM file containing certificate");
+        peercert_filename = NULL;
     }
 
     fclose(peercert_file);
-- 
2.7.4


