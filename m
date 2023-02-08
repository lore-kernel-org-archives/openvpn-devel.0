From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Feb 2023 01:18:17 +0100
Message-Id: <20230208001819.244694-4-arne@...1227...>
In-Reply-To: <20230208001819.244694-1-arne@...1227...>
References: <20230208001819.244694-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Do not run check_engine test when
 crosscompiling
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/engine-key/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/engine-key/Makefile.am
index 246222514..0c2888576 100644
--- a/tests/unit_tests/engine-key/Makefile.am
+++ b/tests/unit_tests/engine-key/Makefile.am
@@ -12,7 +12,9 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
 	top_srcdir="$(top_srcdir)"; \
 	export srcdir builddir top_builddir top_srcdir;
 
+if !CROSS_COMPILING
 TESTS = check_engine_keys.sh
+endif
 check_engine_keys.sh: $(conffiles)
 
 CLEANFILES = \
-- 
2.37.1 (Apple Git-137.1)


