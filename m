From: <maximilian.fillinger@...2507...>
Date: Thu, 21 Oct 2021 13:50:37 +0200
Message-ID: <20211021115037.27056-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix build with compression disabled
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

From: Max Fillinger <maximilian.fillinger@...2507...>

When building with both --disable-lz4 and --disable-lzo, the function
comp_non_stub_enabled and various flags are not defined. One of the
places where it is used in options.c was not put behind an #ifdef, which
caused compilation to fail.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ed2dcd53..4a5db8a6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3205,6 +3205,7 @@ options_set_backwards_compatible_options(struct options *o)
         o->enable_ncp_fallback = true;
     }
 
+#ifdef USE_COMP
     /* Compression is deprecated and we do not want to announce support for it
      * by default anymore, additionally DCO breaks with compression.
      *
@@ -3215,6 +3216,7 @@ options_set_backwards_compatible_options(struct options *o)
     {
         o->comp.flags = COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
     }
+#endif
 }
 
 static void
-- 
2.11.0


