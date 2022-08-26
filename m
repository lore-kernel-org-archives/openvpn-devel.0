From: Antonio Quartulli <a@...2181...>
Date: Fri, 26 Aug 2022 10:41:11 +0200
Message-Id: <20220826084111.239523-1-a@...2181...>
In-Reply-To: <20220813204224.22576-5-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v102 5/7] dco-win: update GH Actions config
 file
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
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>

In order to build OpenVPN with DCO support on Windows there is no need
to pull the full ovpn-dco-win source code, because we now ship the
UAPI header within OpenVPN directly. This also eliminates the need
to specify the DCO_SOURCEDIR var.

At the same time, DCO is always enabled therefore passing --enable-dco
at configure time is not needed anymore.

Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v101:
* rebased

 .github/workflows/build.yaml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b0f67a78..f182a4fe 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -59,11 +59,6 @@ jobs:
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
-      - name: Checkout ovpn-dco-win
-        uses: actions/checkout@...2689...
-        with:
-          repository: OpenVPN/ovpn-dco-win
-          path: ovpn-dco-win
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
         with:
@@ -151,7 +146,7 @@ jobs:
         run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h ${HOME}/mingw/opt/include/
 
       - name: configure OpenVPN
-        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCEDIR=$(realpath ../ovpn-dco-win) LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4 --enable-dco
+        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4
         working-directory: openvpn
 
       - name: build OpenVPN
-- 
2.30.2


