From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 18 Apr 2023 15:49:41 +0200
Message-Id: <20230418134941.86637-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tests: do not include t_client.sh in dist
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

It is generated from t_client.sh.in by configure,
so no need to ship it. Due to the dependency on
the configuration it also might break reproducibility
of the dist tarball.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index a46f2573..80673d56 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -25,8 +25,10 @@ TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
 TESTS = $(test_scripts)
 
 dist_noinst_SCRIPTS = \
-	$(test_scripts) \
+	t_cltsrv.sh \
 	t_cltsrv-down.sh \
+	t_lpback.sh \
+	t_net.sh \
 	update_t_client_ips.sh
 
 dist_noinst_DATA = \
-- 
2.34.1


