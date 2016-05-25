From: openvpn-devel@...2127...
Date: Wed, 25 May 2016 19:57:56 +0200
Message-Id: <20160525175756.56186-3-openvpn-devel@...2127...>
In-Reply-To: <20160525175756.56186-1-openvpn-devel@...2127...>
References: <20160525175756.56186-1-openvpn-devel@...2127...>
Subject: [Openvpn-devel] [PATCH 2/2] Add a test for auth-pam searchandreplace
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

From: Jens Neuhalfen <jens@...2127...>

No functional changes.

Utility functions of auth-pam are split into a dedicated file. This allows
the test programs to easily test these functions without adding dependencies.

Add a minimal test for searchandreplace as a proof of concept.

Signed-off-by: Jens Neuhalfen <jens@...2127...>
---
 configure.ac                                       |   2 +
 src/plugins/auth-pam/Makefile.am                   |   1 +
 src/plugins/auth-pam/auth-pam.c                    |  91 +----------------
 src/plugins/auth-pam/utils.c                       | 113 +++++++++++++++++++++
 src/plugins/auth-pam/utils.h                       |  54 ++++++++++
 tests/unit_tests/Makefile.am                       |   2 +-
 tests/unit_tests/plugins/Makefile.am               |   3 +
 tests/unit_tests/plugins/auth-pam/Makefile.am      |  12 +++
 .../plugins/auth-pam/test_search_and_replace.c     |  79 ++++++++++++++
 9 files changed, 266 insertions(+), 91 deletions(-)
 create mode 100644 src/plugins/auth-pam/utils.c
 create mode 100644 src/plugins/auth-pam/utils.h
 create mode 100644 tests/unit_tests/plugins/Makefile.am
 create mode 100644 tests/unit_tests/plugins/auth-pam/Makefile.am
 create mode 100644 tests/unit_tests/plugins/auth-pam/test_search_and_replace.c

diff --git a/configure.ac b/configure.ac
index fb3fa3c..5e69f91 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1230,6 +1230,8 @@ AC_CONFIG_FILES([
 	src/plugins/down-root/Makefile
 	tests/Makefile
         tests/unit_tests/Makefile
+        tests/unit_tests/plugins/Makefile
+        tests/unit_tests/plugins/auth-pam/Makefile
         tests/unit_tests/example_test/Makefile
         vendor/Makefile
 	sample/Makefile
diff --git a/src/plugins/auth-pam/Makefile.am b/src/plugins/auth-pam/Makefile.am
index 2aef311..e6dc27e 100644
--- a/src/plugins/auth-pam/Makefile.am
+++ b/src/plugins/auth-pam/Makefile.am
@@ -18,6 +18,7 @@ dist_doc_DATA = README.auth-pam
 endif
 
 openvpn_plugin_auth_pam_la_SOURCES = \
+	utils.c \
 	auth-pam.c \
 	pamdl.c  pamdl.h \
 	auth-pam.exports
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 710accc..5ad3ec8 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -39,7 +39,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
-#include <stdbool.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -48,7 +47,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <syslog.h>
-#include <stdint.h>
+#include "utils.h"
 
 #include <openvpn-plugin.h>
 
@@ -117,94 +116,6 @@ struct user_pass {
 /* Background process function */
 static void pam_server (int fd, const char *service, int verb, const struct name_value_list *name_value_list);
 
-/*  Read 'tosearch', replace all occurences of 'searchfor' with 'replacewith' and return
- *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
- *  infinite loop with clever 'searchfor' and 'replacewith' strings.
- *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
- *
- *  Retuns NULL when
- *   - any parameter is NULL
- *   - the worst-case result is to large ( >= SIZE_MAX)
- */
-static char *
-searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith)
-{
-  if (!tosearch || !searchfor || !replacewith) return NULL;
-
-  size_t tosearchlen = strlen(tosearch);
-  size_t replacewithlen = strlen(replacewith);
-  size_t templen = tosearchlen * replacewithlen;
-
-  if (tosearchlen == 0 || strlen(searchfor) == 0 || replacewithlen == 0) {
-    return NULL;
-  }
-
-  bool is_potential_integer_overflow =  (templen == SIZE_MAX) || (templen / tosearchlen != replacewithlen);
-
-  if (is_potential_integer_overflow) {
-       return NULL;
-  }
-
-  // state: all parameters are valid
-
-  const char *searching=tosearch;
-  char *scratch;
-
-  char temp[templen+1];
-  temp[0]=0;
-
-  scratch = strstr(searching,searchfor);
-  if (!scratch) return strdup(tosearch);
-
-  while (scratch) {
-    strncat(temp,searching,scratch-searching);
-    strcat(temp,replacewith);
-
-    searching=scratch+strlen(searchfor);
-    scratch = strstr(searching,searchfor);
-  }
-  return strdup(temp);
-}
-
-/*
- * Given an environmental variable name, search
- * the envp array for its value, returning it
- * if found or NULL otherwise.
- */
-static const char *
-get_env (const char *name, const char *envp[])
-{
-  if (envp)
-    {
-      int i;
-      const int namelen = strlen (name);
-      for (i = 0; envp[i]; ++i)
-	{
-	  if (!strncmp (envp[i], name, namelen))
-	    {
-	      const char *cp = envp[i] + namelen;
-	      if (*cp == '=')
-		return cp + 1;
-	    }
-	}
-    }
-  return NULL;
-}
-
-/*
- * Return the length of a string array
- */
-static int
-string_array_len (const char *array[])
-{
-  int i = 0;
-  if (array)
-    {
-      while (array[i])
-	++i;
-    }
-  return i;
-}
 
 /*
  * Socket read/write functions.
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
new file mode 100644
index 0000000..4f2bec1
--- /dev/null
+++ b/src/plugins/auth-pam/utils.c
@@ -0,0 +1,113 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * OpenVPN plugin module to do PAM authentication using a split
+ * privilege model.
+ */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+
+#include <string.h>
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <stdint.h>
+
+#include "utils.h"
+
+char *
+searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith)
+{
+  if (!tosearch || !searchfor || !replacewith) return NULL;
+
+  size_t tosearchlen = strlen(tosearch);
+  size_t replacewithlen = strlen(replacewith);
+  size_t templen = tosearchlen * replacewithlen;
+
+  if (tosearchlen == 0 || strlen(searchfor) == 0 || replacewithlen == 0) {
+    return NULL;
+  }
+
+  bool is_potential_integer_overflow =  (templen == SIZE_MAX) || (templen / tosearchlen != replacewithlen);
+
+  if (is_potential_integer_overflow) {
+       return NULL;
+  }
+
+  // state: all parameters are valid
+
+  const char *searching=tosearch;
+  char *scratch;
+
+  char temp[templen+1];
+  temp[0]=0;
+
+  scratch = strstr(searching,searchfor);
+  if (!scratch) return strdup(tosearch);
+
+  while (scratch) {
+    strncat(temp,searching,scratch-searching);
+    strcat(temp,replacewith);
+
+    searching=scratch+strlen(searchfor);
+    scratch = strstr(searching,searchfor);
+  }
+  return strdup(temp);
+}
+
+const char *
+get_env (const char *name, const char *envp[])
+{
+  if (envp)
+    {
+      int i;
+      const int namelen = strlen (name);
+      for (i = 0; envp[i]; ++i)
+	{
+	  if (!strncmp (envp[i], name, namelen))
+	    {
+	      const char *cp = envp[i] + namelen;
+	      if (*cp == '=')
+		return cp + 1;
+	    }
+	}
+    }
+  return NULL;
+}
+
+int
+string_array_len (const char *array[])
+{
+  int i = 0;
+  if (array)
+    {
+      while (array[i])
+	++i;
+    }
+  return i;
+}
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
new file mode 100644
index 0000000..d896f89
--- /dev/null
+++ b/src/plugins/auth-pam/utils.h
@@ -0,0 +1,54 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _PLUGIN_AUTH_PAM_UTILS__H
+#define _PLUGIN_AUTH_PAM_UTILS__H
+
+/*  Read 'tosearch', replace all occurences of 'searchfor' with 'replacewith' and return
+ *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
+ *  infinite loop with clever 'searchfor' and 'replacewith' strings.
+ *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
+ *
+ *  Retuns NULL when
+ *   - any parameter is NULL
+ *   - the worst-case result is to large ( >= SIZE_MAX)
+ */
+char *
+searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith);
+
+/*
+ * Given an environmental variable name, search
+ * the envp array for its value, returning it
+ * if found or NULL otherwise.
+ */
+const char *
+get_env (const char *name, const char *envp[]);
+
+/*
+ * Return the length of a string array
+ */
+int
+string_array_len (const char *array[]);
+
+#endif
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 18267bd..e076db8 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,3 +1,3 @@
 AUTOMAKE_OPTIONS = foreign
 
-SUBDIRS = example_test
+SUBDIRS = example_test plugins
diff --git a/tests/unit_tests/plugins/Makefile.am b/tests/unit_tests/plugins/Makefile.am
new file mode 100644
index 0000000..a3696d5
--- /dev/null
+++ b/tests/unit_tests/plugins/Makefile.am
@@ -0,0 +1,3 @@
+AUTOMAKE_OPTIONS = foreign
+
+SUBDIRS = auth-pam
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/Makefile.am
new file mode 100644
index 0000000..07233ee
--- /dev/null
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
@@ -0,0 +1,12 @@
+AUTOMAKE_OPTIONS = foreign
+
+if ENABLE_PLUGIN_AUTH_PAM
+check_PROGRAMS = auth_pam_testdriver
+TESTS = $(check_PROGRAMS)
+endif
+
+sut_sourcedir = $(top_srcdir)/src/plugins/auth-pam
+
+auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(sut_sourcedir)/utils.h $(sut_sourcedir)/utils.c
+auth_pam_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(sut_sourcedir)
+auth_pam_testdriver_LDFLAGS = @TEST_LDFLAGS@
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
new file mode 100644
index 0000000..d6b8a91
--- /dev/null
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -0,0 +1,79 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "utils.h"
+
+static void pass_any_null_param__returns_null() {
+
+  char DUMMY[] = "DUMMY";
+
+  assert_null(searchandreplace(NULL,DUMMY,DUMMY));
+  assert_null(searchandreplace(DUMMY,NULL,DUMMY));
+  assert_null(searchandreplace(DUMMY,DUMMY,NULL));
+}
+
+static void pass_any_empty_string__returns_null() {
+
+  char DUMMY[] = "DUMMY";
+  char EMPTY[] = "";
+
+  assert_null(searchandreplace(EMPTY,DUMMY,DUMMY));
+  assert_null(searchandreplace(DUMMY,EMPTY,DUMMY));
+  assert_null(searchandreplace(DUMMY,DUMMY,EMPTY));
+}
+
+static void replace_single_char__one_time__match_is_replaced() {
+  char *replaced = searchandreplace("X","X","Y");
+
+  assert_non_null(replaced);
+  assert_string_equal("Y", replaced);
+
+  free(replaced);
+}
+
+static void replace_single_char__multiple_times__match_all_matches_are_replaced() {
+  char *replaced = searchandreplace("XaX","X","Y");
+
+  assert_non_null(replaced);
+  assert_string_equal ("YaY", replaced);
+
+  free(replaced);
+}
+
+static void replace_longer_text__multiple_times__match_all_matches_are_replaced() {
+  char *replaced = searchandreplace("XXaXX","XX","YY");
+
+  assert_non_null(replaced);
+  assert_string_equal ("YYaYY", replaced);
+
+  free(replaced);
+}
+
+static void pattern_not_found__returns_original() {
+  char *replaced = searchandreplace("abc","X","Y");
+
+  assert_non_null(replaced);
+  assert_string_equal ("abc", replaced);
+
+  free(replaced);
+}
+
+
+int main(void) {
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(pass_any_null_param__returns_null),
+        cmocka_unit_test(pass_any_empty_string__returns_null),
+        cmocka_unit_test(replace_single_char__one_time__match_is_replaced),
+        cmocka_unit_test(replace_single_char__multiple_times__match_all_matches_are_replaced),
+        cmocka_unit_test(replace_longer_text__multiple_times__match_all_matches_are_replaced),
+        cmocka_unit_test(pattern_not_found__returns_original),
+    };
+
+    return cmocka_run_group_tests_name("searchandreplace", tests, NULL, NULL);
+}
+
-- 
2.8.3


