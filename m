From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Mar 2023 12:09:26 +0200
Message-Id: <20230328100926.138233-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] GHA: remove Ubuntu 18.04 builds
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

Github will stop supporting them on April, 1st.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index a3ca7a2e..99ae437e 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -274,21 +274,6 @@ jobs:
         libname: [mbed TLS]
 
         include:
-          - os: ubuntu-18.04
-            sslpkg: "libmbedtls-dev"
-            ssllib: mbedtls
-            libname: mbed TLS
-            extraconf: "--disable-dco"
-          - os: ubuntu-18.04
-            sslpkg: "libssl1.0-dev"
-            ssllib: openssl
-            libname: OpenSSL 1.0.2
-            extraconf: "--disable-dco"
-          - os: ubuntu-18.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--disable-dco"
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
-- 
2.34.1


