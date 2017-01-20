From: David Sommerseth <davids@...515...>
Date: Fri, 20 Jan 2017 22:04:57 +0100
Message-Id: <20170120210457.3383-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] git: Merge .gitignore files into a single
	file
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

We already track a lot of files over the whole directory structure
in the main .gitignore file.  But a few additional ones had been
added into some of the subdirectories.

This unifies all these files into a master file for the whole project,
making it easier to know where to look at and edit if changes needs
to be done.

Signed-off-by: David Sommerseth <davids@...515...>
---
 .gitignore                    | 5 +++++
 sample/sample-keys/.gitignore | 1 -
 tests/unit_tests/.gitignore   | 1 -
 vendor/.gitignore             | 2 --
 4 files changed, 5 insertions(+), 4 deletions(-)
 delete mode 100644 sample/sample-keys/.gitignore
 delete mode 100644 tests/unit_tests/.gitignore
 delete mode 100644 vendor/.gitignore

diff --git a/.gitignore b/.gitignore
index fc1e223..72593cf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -51,11 +51,16 @@ config-msvc-local.h
 config-msvc-version.h
 doc/openvpn.8.html
 distro/rpm/openvpn.spec
+sample/sample-keys/sample-ca/
+vendor/.build
+vendor/dist
 
 tests/t_client.sh
 tests/t_client-*-20??????-??????/
 t_client.rc
 t_client_ips.rc
+tests/unit_tests/*/*_testdriver
+tests/unit_tests/*/*/*_testdriver
 
 src/openvpn/openvpn
 include/openvpn-plugin.h
diff --git a/sample/sample-keys/.gitignore b/sample/sample-keys/.gitignore
deleted file mode 100644
index f148752..0000000
--- a/sample/sample-keys/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-sample-ca/
diff --git a/tests/unit_tests/.gitignore b/tests/unit_tests/.gitignore
deleted file mode 100644
index 8655de8..0000000
--- a/tests/unit_tests/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-*_testdriver
diff --git a/vendor/.gitignore b/vendor/.gitignore
deleted file mode 100644
index e11dfec..0000000
--- a/vendor/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-.build/
-dist/
-- 
2.11.0


