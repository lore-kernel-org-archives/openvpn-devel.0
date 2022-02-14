From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Feb 2022 03:10:54 +0100
Message-Id: <20220214021054.3750071-2-arne@...1227...>
In-Reply-To: <20220214021054.3750071-1-arne@...1227...>
References: <20220214021054.3750071-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Add Werror to github action ubuntu build
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
index f1a75736..34d1dcce 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -187,7 +187,7 @@ jobs:
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}}
+        run: ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}} --enable-werror
       - name: make all
         run: make -j3
       - name: make check
-- 
2.33.0


