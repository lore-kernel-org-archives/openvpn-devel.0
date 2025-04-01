From: Gert Doering <gert@...1296...>
Date: Tue,  1 Apr 2025 19:04:14 +0200
Message-ID: <20250401170420.29808-1-gert@...1296...>
In-Reply-To: <gerrit.1743525501000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
References: <gerrit.1743525501000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Pin version of CMake for all builds
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

From: Frank Lichtenheld <frank@...2641...>

Turns out that "apt install cmake" is useless since
Github installs also CMake but not as a package. So
make sure we control which CMake we get and not
Github.

Switch to get-cmake action (which also installs ninja)
and remove the installation via apt.

Change-Id: Ief11d5d7ccae084c863b50054d4e97c71f57d6f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/929
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b1af7ec..617b866 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,6 +54,7 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
@@ -78,10 +79,11 @@
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake ninja-build build-essential wget python3-docutils man2html-base
+        run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
 
+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
@@ -457,13 +459,14 @@
 
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y cmake gcc ninja-build golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+        run: sudo apt update && sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
         uses: actions/checkout@...2844... # v4.2.2
         with:
           path: aws-lc
           repository: aws/aws-lc
           ref: v1.42.0
+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: "AWS-LC: build"
         run: |
           mkdir build

