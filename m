From: Arne Schwabe <arne@...1227...>
Date: Wed,  6 Oct 2021 20:06:44 +0200
Message-Id: <20211006180644.3081219-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Default to --cipher BF-CBC if not set and
 compat-mode < 2.4.0
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

When we try to make a configuration compatible to a version earlier
than 2.4.0 we probably need to have a --cipher configured since NCP
is not available. In configuration where --cipher is not specified
we default to BF-CBC to support these old clients.

Note that with OpenSSL 3.0 you will also need to enable the legacy
provider otherwise we bail out since BF-CBC is no longer supported.

Also move the condition so BF-CBC gets included in the data-ciphers
list.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e82ff2e7b..035995d78 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3193,6 +3193,19 @@ options_set_backwards_compatible_options(struct options *o)
         }
     }
 
+    /* Versions < 2.4.0 additionally might be compiled with --enable-small and
+     * not have OCC strings required for "poor man's NCP" */
+    if (need_compatibility_before(o, 20400))
+    {
+        if (!o->ciphername)
+        {
+            /* If ciphername is not set default to BF-CBC when targeting these
+             * old versions that do not have NCP */
+            o->ciphername = "BF-CBC";
+        }
+        o->enable_ncp_fallback = true;
+    }
+    
     /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
      * Version 2.4 might probably does not need it but NCP was not so
      * good with 2.4 and ncp-disable might be more common on 2.4 peers.
@@ -3205,13 +3218,6 @@ options_set_backwards_compatible_options(struct options *o)
         append_cipher_to_ncp_list(o, o->ciphername);
     }
 
-    /* Versions < 2.4.0 additionally might be compiled with --enable-small and
-     * not have OCC strings required for "poor man's NCP" */
-    if (o->ciphername && need_compatibility_before(o, 20400))
-    {
-        o->enable_ncp_fallback = true;
-    }
-
     /* Compression is deprecated and we do not want to announce support for it
      * by default anymore, additionally DCO breaks with compression.
      *
-- 
2.33.0


