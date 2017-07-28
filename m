From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 28 Jul 2017 12:38:22 +0200
Message-ID: <1501238302-16714-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sample-plugins: fix ASN1_STRING_to_UTF8
 return value checks
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

As we did in 2d032c7f for the ASN1_STRING_to_UTF8() calls in the core code,
we should also free(buf) if the function returns 0.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 .../keying-material-exporter-demo/keyingmaterialexporter.c              | 2 +-
 sample/sample-plugins/log/log_v3.c                                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 44a8c02..c483907 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -143,7 +143,7 @@ session_user_set(struct session *sess, X509 *x509)
             continue;
         }
         unsigned char *buf = NULL;
-        if (ASN1_STRING_to_UTF8(&buf, val) <= 0)
+        if (ASN1_STRING_to_UTF8(&buf, val) < 0)
         {
             continue;
         }
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 12da624..98d80d9 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -227,7 +227,7 @@ x509_print_info(X509 *x509crt)
         {
             continue;
         }
-        if (ASN1_STRING_to_UTF8(&buf, val) <= 0)
+        if (ASN1_STRING_to_UTF8(&buf, val) < 0)
         {
             continue;
         }
-- 
2.7.4


