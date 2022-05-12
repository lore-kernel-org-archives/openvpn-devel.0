From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:25 +0200
Message-Id: <20220512121429.2096164-4-arne@...1227...>
In-Reply-To: <20220512121429.2096164-1-arne@...1227...>
References: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/7] Add ubuntu 22.04 to Github Actions
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
Cc: Gert Doering <gert@...1296...>

This adds Ubuntu 22.04 to the Github actions. mbed TLS in 22.04 is still
old enough (2.28) to build with OpenVPN and GPL licensed.

Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20220506132836.1318985-2-arne@...1227...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24299.html

Signed-off-by: Gert Doering <gert@...1296...>
---
 .github/workflows/build.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index fb53fb8bd..4926c1f95 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -130,7 +130,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-18.04, ubuntu-20.04]
+        os: [ubuntu-18.04, ubuntu-20.04, ubuntu-22.04]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
@@ -148,6 +148,10 @@ jobs:
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


