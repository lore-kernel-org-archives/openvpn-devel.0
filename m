From: Arne Schwabe <arne@...1227...>
Date: Fri,  6 May 2022 15:28:36 +0200
Message-Id: <20220506132836.1318985-2-arne@...1227...>
In-Reply-To: <20220506132836.1318985-1-arne@...1227...>
References: <20220422142953.3805364-13-arne@...1227...>
 <20220506132836.1318985-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Add ubuntu 22.04 to Github Actions
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

This adds Ubuntu 22.04 to the Github actions. mbed TLS in 22.04 is still
old enough (2.28) to build with OpenVPN and GPL licensed.
---
 .github/workflows/build.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dd23b1426..d34f4e9a9 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -159,7 +159,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-18.04, ubuntu-20.04]
+        os: [ubuntu-18.04, ubuntu-20.04, ubuntu-22.04]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
@@ -177,6 +177,10 @@ jobs:
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
+          - os: ubuntu-22.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 3.0.2
+            ssllib: openssl
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
-- 
2.32.0 (Apple Git-132)


