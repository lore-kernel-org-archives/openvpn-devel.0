From: Arne Schwabe <arne@...1227...>
Date: Sun,  9 Oct 2022 16:00:42 +0200
Message-Id: <20221009140042.1560899-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Enable -Werror on macOS builds
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
 .github/workflows/build.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f34f6a266..f7d2d3836 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -299,7 +299,7 @@ jobs:
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure ${{matrix.configureflags}} ${{matrix.configuressllib}}
+        run: ./configure --enable-werror ${{matrix.configureflags}} ${{matrix.configuressllib}}
       - name: make all
         run: make -j4
       - name: make check
-- 
2.37.0 (Apple Git-136)


