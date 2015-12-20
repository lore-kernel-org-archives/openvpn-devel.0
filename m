From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Dec 2015 18:10:44 +0100
Message-Id: <1450631444-19754-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add Travis CI config for automatic builds
	and static analysis
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Adding a .travis.yml file with config for automated builds enables
travis-ci to perform some basic continuous integration.  This does not
replace our existing build and test infrastructure, since that tests
many more combinations and platforms.

When added to the repository, this enables automated builds and (basic)
tests for all branches this commit is applied to, and enables coverity
analysis for the coverity_scan branch (since we can only do a limited
number of coverity scans per week with our FOSS account).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 .travis.yml | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..5141182
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,34 @@
+language: c
+
+compiler:
+  - gcc
+  - clang
+
+sudo: no
+
+env:
+  global:
+   # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
+   #   via the "travis encrypt" command using the project repo's public key
+   - secure: "l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DXnsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANFJo2vfh//ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436oE8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KAD84prtfpZOcrSMxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsGYH++k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjhfGKd2F2ANT2Gkhj3Me36eNHfuE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9vLH4sBCww8U="
+
+addons:
+  apt:
+    packages:
+      - liblzo2-dev
+      - libpam0g-dev
+  coverity_scan:
+    project:
+      name: "OpenVPN/openvpn"
+      version: 2.3.x
+      description: "Open Source VPN daemon"
+    notification_email: scan-reports@...515...
+    build_command_prepend: "autoreconf -vi && ./configure --enable-iproute2 && make clean"
+    build_command: "make"
+    branch_pattern: coverity_scan
+
+script:
+  - autoreconf -vi
+  # We need to use --enable-iproute2 to run on the new (faster) Travis CI infra.
+  - ./configure --enable-strict --enable-iproute2
+  - make check
-- 
2.5.0


