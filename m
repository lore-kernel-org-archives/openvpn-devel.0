From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 8 Aug 2018 11:58:47 +0200
Message-ID: <1533722327-5228-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't print OCC warnings about 'key-method',
 'keydir' and 'tls-auth'
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

Like 'proto', a mismatch in key-method, keydir or tls-auth would fail
before we ever get to the point where we can print this warning.

This prepares for removing these from the occ string later on, but also
prepares for tls-crypt-v2, which allows a server to support tls-auth and
tls-crypt-v2 connections in parallel.  Such a server will send 'keydir'
and 'tls-auth' in the occ string.  This change removes the spurious
warnings about that in the client log.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/options.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61fa983..60f4b6f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3790,11 +3790,14 @@ options_warning_safe_scan2(const int msglevel,
                            const char *b1_name,
                            const char *b2_name)
 {
-    /* we will stop sending 'proto xxx' in OCC in a future version
-     * (because it's not useful), and to reduce questions when
-     * interoperating, we start not-printing a warning about it today
+    /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
+     * OCC in a future version (because it's not useful).  To reduce questions
+     * when interoperating, we no longer printing a warning about it.
      */
-    if (strncmp(p1, "proto ", 6) == 0)
+    if (strcmp(p1, "key-method ") == 0
+        || strcmp(p1, "keydir ") == 0
+        || strcmp(p1, "proto ") == 0
+        || strcmp(p1, "tls-auth ") == 0)
     {
         return;
     }
-- 
2.7.4


