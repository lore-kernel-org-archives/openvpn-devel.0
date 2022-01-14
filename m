From: Antonio Quartulli <a@...2181...>
Date: Fri, 14 Jan 2022 13:25:38 +0100
Message-Id: <20220114122538.24662-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GitHub Actions: ensure Ubuntu builds are
 made with the chosen SSL library
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

The configure parameter was appended to the stage name but not to the
actual command. Fix this.

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v2:
* fix typ0 in sslpkg name for mbedtls

 .github/workflows/build.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ea1233b1..354a3256 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -131,7 +131,7 @@ jobs:
       fail-fast: false
       matrix:
         os: [ubuntu-18.04, ubuntu-20.04]
-        sslpkg: [libssl-dev]
+        sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
 
@@ -161,8 +161,8 @@ jobs:
         uses: actions/checkout@...2620...
       - name: autoconf
         run: autoreconf -fvi
-      - name: configure --with-crypto-library=${{matrix.ssllib}}
-        run: ./configure
+      - name: configure
+        run: ./configure --with-crypto-library=${{matrix.ssllib}}
       - name: make all
         run: make -j3
       - name: make check
-- 
2.34.1


