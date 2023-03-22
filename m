From: selva.nair@...277...
Date: Wed, 22 Mar 2023 18:14:56 -0400
Message-Id: <20230322221456.1660425-3-selva.nair@...277...>
In-Reply-To: <20230322221456.1660425-1-selva.nair@...277...>
References: <20230322221456.1660425-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Enable pkcs11 an dtest_pkcs11 in github
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

From: Selva Nair <selva.nair@...277...>

- Enabled for the Ubuntu 22.04 build (OpenSSL 3) and one of the
  Ubuntu 20.04 builds (OpenSSL 1.1.1).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 .github/workflows/build.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index a3ca7a2e..2538c818 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -297,11 +297,14 @@ jobs:
             sslpkg: "libssl-dev"
             libname: OpenSSL 3.0.2
             ssllib: openssl
+            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
+            extraconf: --enable-pkcs11
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
-            extraconf: "--enable-iproute2"
+            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
+            extraconf: "--enable-iproute2 --enable-pkcs11"
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
@@ -326,11 +329,12 @@ jobs:
     name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}}"
     env:
       SSLPKG: "${{matrix.sslpkg}}"
+      PKCS11PKG: "${{matrix.pkcs11pkg}}"
 
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG}
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
       - name: autoconf
-- 
2.34.1


