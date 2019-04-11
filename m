From: chipitsine@...277...
Date: Fri, 12 Apr 2019 01:51:59 +0500
Message-Id: <20190411205159.7369-2-chipitsine@...277...>
In-Reply-To: <20190411205159.7369-1-chipitsine@...277...>
References: <20190411205159.7369-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] initial cirrus-ci support
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

From: Ilya Shipitsin <chipitsine@...277...>

enabled FreeBSD 12.0 builds

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .cirrus.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 00000000..955b8de0
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,24 @@
+FreeBSD_task:
+  freebsd_instance:
+    image: freebsd-12-0-release-amd64
+  env:
+    ASSUME_ALWAYS_YES: TRUE # required for unattended "pkg" invocation
+    LZO_CFLAGS: '-I/usr/local/include'
+    LZO_LIBS: '-llzo2 -L/usr/local/lib'
+    LZ4_CFLAGS: '-I/usr/local/include'
+    LZ4_LIBS: '-llz4 -L/usr/local/lib'
+    MBEDTLS_CFLAGS: '-I/usr/local/include'
+    MBEDTLS_LIBS: '-lmbedtls -lmbedx509 -lmbedcrypto -L/usr/local/lib'
+    matrix:
+      - SSLLIB: openssl
+      - SSLLIB: mbedtls
+  install_script:
+    - pkg install cmake gmake openssl111 mbedtls git autoconf automake libtool
+    - git submodule update --init --recursive
+  script:
+    - autoreconf -iv
+    - ./configure --with-crypto-library=${SSLLIB}
+    - make
+    - src/openvpn/openvpn --version || true
+    - ldd src/openvpn/openvpn
+    - make check
-- 
2.20.1


