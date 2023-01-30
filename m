From: Arne Schwabe <arne@...1227...>
Date: Mon, 30 Jan 2023 18:29:34 +0100
Message-Id: <20230130172936.3444840-3-arne@...1227...>
In-Reply-To: <20230130172936.3444840-1-arne@...1227...>
References: <20230130172936.3444840-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Update LibreSSL to 3.7.0 in Github
 actions
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

The version 3.5.3 triggers undefined behaviour with the usan sanatizer.
Updating LibreSSSL to 3.7.0 does unfortunately does not fix the issue but
at least we are now using a current version.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2db90bcde..6adb69563 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -409,7 +409,7 @@ jobs:
         with:
           path: libressl
           repository: libressl-portable/portable
-          ref: v3.5.3
+          ref: v3.7.0
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
@@ -417,7 +417,7 @@ jobs:
         run: autoreconf -fvi
         working-directory: libressl
       - name: "libressl: configure"
-        run: ./configure --enable-openvpn
+        run: ./configure
         working-directory: libressl
       - name: "libressl: make all"
         run: make -j3
-- 
2.37.1 (Apple Git-137.1)


