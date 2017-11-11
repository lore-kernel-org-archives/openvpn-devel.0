From: Gert van Dijk <gert@...2298...>
Date: Sat, 11 Nov 2017 18:14:06 +0100
Message-Id: <20171111171406.7562-1-gert@...2298...>
Subject: [Openvpn-devel] [PATCH] Add generated openvpn.doxyfile to .gitignore
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

I think this was omitted in 66bf378e.

Signed-off-by: Gert van Dijk <gert@...2298...>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 18a45202..25009d81 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@ config-msvc-version.h
 doc/openvpn.8.html
 /doc/doxygen/html/
 /doc/doxygen/latex/
+/doc/doxygen/openvpn.doxyfile
 distro/rpm/openvpn.spec
 distro/systemd/*.service
 sample/sample-keys/sample-ca/
-- 
2.15.0


