From: Arne Schwabe <arne@...1227...>
Date: Mon, 30 Jan 2023 18:29:35 +0100
Message-Id: <20230130172936.3444840-4-arne@...1227...>
In-Reply-To: <20230130172936.3444840-1-arne@...1227...>
References: <20230130172936.3444840-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] Add printing USAN stack trace on github
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

This allows identifying the source of undefined behaviour more easily
from the github action logs.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6adb69563..132624547 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -242,6 +242,9 @@ jobs:
 
     name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"
 
+    env:
+      UBSAN_OPTIONS: print_stacktrace=1
+
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
@@ -291,6 +294,7 @@ jobs:
       LDFLAGS: ${{ matrix.ldflags }}
       OPENSSL_CFLAGS: "-I/usr/local/opt/${{matrix.libdir}}/include"
       OPENSSL_LIBS: "-L/usr/local/opt/${{matrix.libdir}}/lib -lcrypto -lssl"
+      UBSAN_OPTIONS: print_stacktrace=1
     steps:
       - name: Install dependencies
         run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf libressl
@@ -400,6 +404,7 @@ jobs:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
+      UBSAN_OPTIONS: print_stacktrace=1
 
     steps:
       - name: Install dependencies
-- 
2.37.1 (Apple Git-137.1)


