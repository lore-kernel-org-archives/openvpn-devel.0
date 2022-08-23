From: Timo Rothenpieler <timo@...2669...>
Date: Tue, 23 Aug 2022 15:42:18 +0200
Message-Id: <20220823134218.895-1-timo@...2669...>
In-Reply-To: <20220823120902.738-1-timo@...2669...>
References: <20220823120902.738-1-timo@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GitHub Actions: Use Docker Images for
 Ubuntu test runs
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

The ubuntu-18.04 base image is deprecated and in the process of being phased out:
https://github.blog/changelog/2022-08-09-github-actions-the-ubuntu-18-04-actions-runner-image-is-being-deprecated-and-will-be-removed-by-12-1-22/

It is already causing build failures during the scheduled periods mentioned in the blog post.

This is the best alternative I found which does not drop any tests or test environments.
Sadly GHAs build-in container-capabilities can't be used, since they don't allow specifying --network host.
Without that, IPv6 related tests fail, since the Docker deployment on GHA does not support IPv6, even in 2022:
https://github.com/actions/runner-images/issues/668

So instead this manually invokes docker to run the tests in the respective Ubuntu Docker-Image.
Some dependencies had to be added since the Docker-Images are more barebones than the Github-Runner images.
Otherwise, nothing about the test setup changed.
---
Was missing DEBIAN_FRONTEND=noninteractive


 .github/workflows/build.yaml | 43 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b0f67a78..53662120 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -162,79 +162,84 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-18.04, ubuntu-20.04, ubuntu-22.04]
+        img: ["ubuntu:18.04", "ubuntu:20.04", "ubuntu:22.04"]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
 
         include:
-          - os: ubuntu-18.04
+          - img: "ubuntu:18.04"
             sslpkg: "libssl1.0-dev"
             ssllib: openssl
             libname: OpenSSL 1.0.2
-          - os: ubuntu-18.04
+          - img: "ubuntu:18.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
-          - os: ubuntu-22.04
+          - img: "ubuntu:22.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 3.0.2
             ssllib: openssl
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--enable-iproute2"
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--enable-async-push"
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--disable-management"
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--enable-small"
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--disable-lzo --disable-lz4"
-          - os: ubuntu-20.04
+          - img: "ubuntu:20.04"
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--enable-dco"
             nlpkg: "libnl-genl-3-dev"
 
-    name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}}"
+    name: "gcc - ${{matrix.img}} - ${{matrix.libname}} ${{matrix.extraconf}}"
     env:
       SSLPKG: "${{matrix.sslpkg}}"
       NLPKG: "${{matrix.nlpkg}}"
 
-    runs-on: ${{matrix.os}}
+    runs-on: ubuntu-latest
     steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${NLPKG}
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
+      - name: Setup Container
+        run: docker run --name ovpn --detach --rm --cap-add NET_ADMIN --network host -v "$PWD:/wd" --workdir=/wd "${{matrix.img}}" sleep 3600
+      - name: Install dependencies
+        run: docker exec ovpn -e DEBIAN_FRONTEND=noninteractive sh -c "apt update && apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html libcmocka-dev python3-docutils build-essential pkgconf libtool automake autoconf iproute2 git ${SSLPKG} ${NLPKG}"
       - name: autoconf
-        run: autoreconf -fvi
+        run: docker exec ovpn autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}} --enable-werror
+        run: docker exec ovpn ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}} --enable-werror
       - name: make all
-        run: make -j3
+        run: docker exec ovpn make -j3
       - name: make check
-        run: make check
+        run: docker exec ovpn make check
+      - name: Docker Cleanup
+        if: always()
+        run: docker kill ovpn || true
 
   ubuntu-clang-asan:
     strategy:
-- 
2.34.1


