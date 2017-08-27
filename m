From: Gert van Dijk <gert@...2298...>
Date: Sun, 27 Aug 2017 18:15:15 +0200
Message-Id: <20170827161515.2424-1-gert@...2298...>
Subject: [Openvpn-devel] [PATCH] Warn that DH config option is only
 meaningful in a tls-server context
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

If specified in a tls-client context, don't try to open the file as it's
not used. Worse even, if 'none' was specified to disable explicitly, it
complained that the file 'none' could not be found.
---
 src/openvpn/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1bbda027..536d6f3f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3011,6 +3011,13 @@ options_postprocess_mutate(struct options *o)
             o->dh_file = NULL;
         }
     }
+    else if (o->dh_file)
+    {
+        /* DH file is only meaningful in a tls-server context. */
+        msg(M_WARN, "ignoring option 'dh' in tls-client mode, please only "
+                    "include this in your server configuration");
+        o->dh_file = NULL;
+    }
 
     /* cipher negotiation (NCP) currently assumes --pull or --mode server */
     if (o->ncp_enabled
-- 
2.14.1


