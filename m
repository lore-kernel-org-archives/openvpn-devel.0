From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Apr 2022 09:09:02 +0200
Message-Id: <20220402070902.30282-8-a@...2181...>
In-Reply-To: <20220402070902.30282-1-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/7] GitHub Actions: add Linux DCO build (on
 Ubuntu 20.04)
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .github/workflows/build.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 579bbb5d..0225daea 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -168,15 +168,22 @@ jobs:
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--disable-lzo --disable-lz4"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-dco"
+            nlpkg: "libnl-genl-3-dev"
 
     name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}}"
     env:
       SSLPKG: "${{matrix.sslpkg}}"
+      NLPKG: "${{matrix.nlpkg}}"
 
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG}
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${NLPKG}
       - name: Checkout OpenVPN
         uses: actions/checkout@...2620...
       - name: autoconf
-- 
2.35.1


