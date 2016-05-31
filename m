From: David Sommerseth <openvpn@...2080...>
Date: Tue, 31 May 2016 16:07:25 +0200
Message-Id: <1464703645-26640-1-git-send-email-openvpn@...2080...>
In-Reply-To: <1464690813-10411-1-git-send-email-openvpn@...2080...>
References: <1464690813-10411-1-git-send-email-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH v2] Only build and run cmocka unit tests if
	its submodule is initialized
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
Cc: David Sommerseth <dazo@...2145...>

From: David Sommerseth <dazo@...2145...>

Commit 40cb4cfc5d01110 added infrastructure to write unit tests using
cmocka.  This was implemented using a git submodule to fetch an
up-to-date cmocka test framework.

The issue which appeared was that 'make check' stopped working if
the cmocka submodule was not initialized and updated.  As we do not
want this to be a hard depenency, this patch makes running these
unit tests conditional.  If cmocka has not been initialized, skip
them or if it has been initialized all unit tests will be run.

 [v2 - Also check if cmake is available, as cmocka depends on that
       to be built ]

Signed-off-by: David Sommerseth <dazo@...2145...>
---
 configure.ac                 | 16 ++++++++++++++++
 tests/unit_tests/Makefile.am |  2 ++
 vendor/Makefile.am           |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5e69f91..af21617 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1211,6 +1211,22 @@ TEST_CFLAGS="-I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
 
+# Check if cmake is available and cmocka git submodule is initialized,
+# needed for unit testing
+AC_CHECK_PROGS([CMAKE], [cmake])
+if test -n "${CMAKE}"; then
+   if test -f vendor/cmocka/CMakeLists.txt; then
+      AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
+   else
+      AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
+      AC_MSG_RESULT([!! WARNING !! The cmoka git submodule has not been initialized or updated.  Unit testing cannot be performed.])
+   fi
+else
+   AC_MSG_RESULT([!! WARNING !! CMake is available.  Unit testing cannot be performed.])
+   AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
+fi
+
+
 AC_CONFIG_FILES([
 	version.sh
 	Makefile
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index e076db8..8868c1c 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,3 +1,5 @@
 AUTOMAKE_OPTIONS = foreign
 
+if CMOCKA_INITIALIZED
 SUBDIRS = example_test plugins
+endif
diff --git a/vendor/Makefile.am b/vendor/Makefile.am
index f68240e..84656a1 100644
--- a/vendor/Makefile.am
+++ b/vendor/Makefile.am
@@ -15,7 +15,9 @@ distdir:
 
 libcmocka: distdir
 	mkdir -p $(cmockabuild)
+if CMOCKA_INITIALIZED
 	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=$(cmockainstall) $(cmockasrc) && make && make install)
+endif
 
 check: libcmocka
 
-- 
1.8.3.1


