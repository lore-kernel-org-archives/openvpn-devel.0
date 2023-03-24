From: Gert Doering <gert@...1296...>
Date: Fri, 24 Mar 2023 09:38:16 +0100
Message-Id: <20230324083816.79436-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix compilation without compression
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

The previous commit (e86bc8b2967) breaks compilation if all compression
algorithms are disabled (--disable-lz4 --disable-lzo).  A later patch
in the series would fix this but can not be merged yet.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 435e1ca9..e3d14e94 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3779,8 +3779,10 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
     /* this depends on o->windows_driver, which is set above */
     options_postprocess_mutate_invariant(o);
 
+#ifdef USE_COMP
     /* check that compression settings in the options are okay */
     check_compression_settings_valid(&o->comp, M_USAGE);
+#endif
 
     /*
      * Save certain parms before modifying options during connect, especially
-- 
2.39.2


