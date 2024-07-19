From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 19 Jul 2024 15:11:41 +0200
Message-Id: <20240719131141.75324-1-frank@...2641...>
In-Reply-To: <gerrit.1721306838000.I44b9003143fdad90bfff7b2c86d0bb503f9157de@...2715...>
References: <gerrit.1721306838000.I44b9003143fdad90bfff7b2c86d0bb503f9157de@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add Ubuntu 24.04 runner to Github Actions
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

From: Arne Schwabe <arne@...1227...>

Change-Id: I44b9003143fdad90bfff7b2c86d0bb503f9157de
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/676
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d7c3ecd..6e361d5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -106,7 +106,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04, ubuntu-22.04]
+        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
@@ -122,6 +122,12 @@
             ssllib: openssl
             pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
             extraconf: --enable-pkcs11
+          - os: ubuntu-24.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 3.0.13
+            ssllib: openssl
+            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
+            extraconf: --enable-pkcs11
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
@@ -173,7 +179,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04]
+        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]
         ssllib: [mbedtls, openssl]
 
     name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"

