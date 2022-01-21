From: Antonio Quartulli <a@...2181...>
Date: Fri, 21 Jan 2022 14:39:00 +0100
Message-Id: <20220121133900.14567-1-a@...2181...>
In-Reply-To: <20220119232743.16779-1-a@...2181...>
References: <20220119232743.16779-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GitHub Actions: add other config flavours
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

In the past we had issues with patches accidentally breaking less common
OpenVPN configurations. For this reason it makes sense to some of those
configurations build via CI.

Adding:
* --enable-iproute2
* --enable-async-push
* --disable-management
* --enable-small
* --disable-lzo --disable-lz4

These flavours are all built on Ubuntu 20.04 with OpenSSL 1.1.1

Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
* combined --disable-lzo and --disable-lz4 in one single build

 .github/workflows/build.yaml | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 354a3256..9f884ac2 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -148,8 +148,33 @@ jobs:
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-iproute2"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-async-push"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--disable-management"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-small"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--disable-lzo --disable-lz4"
 
-    name: "gcc - ${{matrix.os}} - ${{matrix.libname}}"
+    name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}}"
     env:
       SSLPKG: "${{matrix.sslpkg}}"
 
@@ -162,7 +187,7 @@ jobs:
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=${{matrix.ssllib}}
+        run: ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}}
       - name: make all
         run: make -j3
       - name: make check
-- 
2.34.1


