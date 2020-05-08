From: David Sommerseth <davids@...515...>
Date: Fri,  8 May 2020 13:44:11 +0200
Message-Id: <20200508114411.15762-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] options: Restore --tls-crypt-v2 inline
 file capability
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

Commit cb2e9218f2bc73f re-factored the internal file handling, but
somehow overlooked the --tls-crypt-v2 option processing.  It was no
longer possible to load a configuration file with this key file inlined.

There where two issues here.  First was that the OPT_P_INLINE flag was
not set, so the option parser rejected --tls-crypt-v2 as inline capable.

Second issue was that the 'streq(p[1], INLINE_FILE_TAG)' check makes no
longer sense, as at this point p[1] contains the file contents.  Instead
use the is_inline flag.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/options.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a37106ce..56c9e411 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8324,22 +8324,16 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "tls-crypt-v2") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_INLINE);
         if (permission_mask & OPT_P_GENERAL)
         {
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->tls_crypt_v2_file_inline = p[2];
-            }
             options->tls_crypt_v2_file = p[1];
+            options->tls_crypt_v2_file_inline = is_inline;
         }
         else if (permission_mask & OPT_P_CONNECTION)
         {
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->ce.tls_crypt_v2_file_inline = p[2];
-            }
             options->ce.tls_crypt_v2_file = p[1];
+            options->ce.tls_crypt_v2_file_inline = is_inline;
         }
     }
     else if (streq(p[0], "tls-crypt-v2-verify") && p[1] && !p[2])
-- 
2.26.0


