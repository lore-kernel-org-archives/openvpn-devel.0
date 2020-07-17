From: David Sommerseth <davids@...515...>
Date: Fri, 17 Jul 2020 13:01:36 +0200
Message-Id: <20200717110136.11579-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc/man: Add misssing renegotiation.rst to
 Makefile.am
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

This file did not get added to Makefile.am by a mistake during the
man-page overhaul, and the issue this causes is not easily spotted.

If a consumer of a tarball (created with 'make dist' from the git
tree) tries runs 'make clean' and 'make dist' plus have
python-docutils installed from such a tarball, it will explode and
complain about this missing file.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/Makefile.am b/doc/Makefile.am
index a1ac02f6..add92198 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -31,6 +31,7 @@ dist_doc_DATA = \
 	man-sections/plugin-options.rst \
 	man-sections/protocol-options.rst \
 	man-sections/proxy-options.rst \
+	man-sections/renegotiation.rst \
 	man-sections/signals.rst \
 	man-sections/script-options.rst \
 	man-sections/server-options.rst \
-- 
2.26.0


