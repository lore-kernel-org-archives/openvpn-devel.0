From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  5 Aug 2020 06:25:48 +0000
Message-Id: <20200805062548.38082-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix compilation with --disable-lzo and
 --disable-lz4
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

struct compress_options is defined under USE_COMP, therefore
compilation fails when it is referenced without that define.

Since function show_compression_warning, which uses aforementioned
struct, is only called under USE_COMP, it is safe to wrap its definition
under USE_COMP, which fixes compilation issue.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bc256b18..1c246f4b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5085,6 +5085,7 @@ set_user_script(struct options *options,
 #endif
 }
 
+#ifdef USE_COMP
 static void
 show_compression_warning(struct compress_options *info)
 {
@@ -5103,6 +5104,7 @@ show_compression_warning(struct compress_options *info)
         }
     }
 }
+#endif
 
 static void
 add_option(struct options *options,
-- 
2.25.1


