From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Aug 2017 17:55:41 +0200
Message-ID: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add coverity static analysis to Travis CI
 config
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

Enable coverity analysis for the release/2.4 branch.

We can only do a limited number of coverity scans per week with our FOSS
account, but since we only occasionally push commits, that should work out
fine.  But this limit is the reason we don't use the standard travis addon,
because that would cause the coverity script to run on all of our matrix
builds.  That would cause us to reach our limit faster, and waste travis'
resources.

Since our FOSS coverity account doesn't handle multiple branches very well,
we have to pick one branch to run coverity on.  I think it's best to use
the most recent stable branch for that (i.e. for now, release/2.4).
Though for ease of maintenance, it's probably best to apply the patch to
both master and release/2.4.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 .travis.yml         |  8 +++++++-
 .travis/coverity.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100755 .travis/coverity.sh

diff --git a/.travis.yml b/.travis.yml
index db90e03..131d002 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,10 +21,13 @@ env:
     - OPENSSL_VERSION="1.0.2k"
     - OPENSSL_CFLAGS="-I${PREFIX}/include"
     - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
+    # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
+    #   via the "travis encrypt" command using the project repo's public key
+    - secure: "l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DXnsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANFJo2vfh//ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436oE8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KAD84prtfpZOcrSMxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsGYH++k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjhfGKd2F2ANT2Gkhj3Me36eNHfuE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9vLH4sBCww8U="
 
 matrix:
   include:
-    - env: SSLLIB="openssl"
+    - env: SSLLIB="openssl" RUN_COVERITY="1"
       os: linux
       compiler: gcc
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
@@ -91,5 +94,8 @@ install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
   - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
 
+before_script:
+  - .travis/coverity.sh
+
 script:
   - .travis/build-check.sh
diff --git a/.travis/coverity.sh b/.travis/coverity.sh
new file mode 100755
index 0000000..8bb40f4
--- /dev/null
+++ b/.travis/coverity.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+set -eu
+
+RUN_COVERITY="${RUN_COVERITY:-0}"
+
+export COVERITY_SCAN_PROJECT_NAME="OpenVPN/openvpn"
+export COVERITY_SCAN_BRANCH_PATTERN="release\/2.4"
+export COVERITY_SCAN_NOTIFICATION_EMAIL="scan-reports@...515..."
+export COVERITY_SCAN_BUILD_COMMAND_PREPEND="autoreconf -vi && ./configure --enable-iproute2 && make clean"
+export COVERITY_SCAN_BUILD_COMMAND="make"
+
+if [ "${RUN_COVERITY}" = "1" ]; then
+    # Ignore exit code, script exits with 1 if we're not on the right branch
+    curl -s "https://scan.coverity.com/scripts/travisci_build_coverity_scan.sh" | bash || true
+else
+    echo "Skipping coverity scan because \$RUN_COVERITY != \"1\""
+fi
-- 
2.7.4


