From: Gert Doering <gert@...1296...>
Date: Fri, 26 Jul 2024 12:40:32 +0200
Message-ID: <20240726104032.2112-1-gert@...1296...>
In-Reply-To: <gerrit.1718900482000.I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a@...2715...>
References: <gerrit.1718900482000.I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] console_systemd: rename query_user_exec
 to query_user_systemd
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

This allows us to override query_user_exec for unit
tests more consistently without having to jump through
weird hoops.

Fixes running test_pkcs11 with --enable-systemd.

While here also fix documentation comments for
query_user_exec*.

Change-Id: I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/670
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 7358299..72ae8e0 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -65,11 +65,10 @@
 
 
 /**
- * Executes a configured setup, using the built-in method for querying the user.
+ * Loop through configured query_user slots, using the built-in method for
+ * querying the user.
  * This method uses the console/TTY directly.
  *
- * @param setup    Pointer to the setup defining what to ask the user
- *
  * @return True if executing all the defined steps completed successfully
  */
 bool query_user_exec_builtin(void);
@@ -77,21 +76,34 @@
 
 #if defined(ENABLE_SYSTEMD)
 /**
- * Executes a configured setup, using the compiled method for querying the user
- *
- * @param setup    Pointer to the setup defining what to ask the user
+ * Loop through configured query_user slots, using the systemd method for
+ * querying the user.
+ * If systemd is not running it will fall back to use
+ * query_user_exec_builtin() instead.
  *
  * @return True if executing all the defined steps completed successfully
  */
-bool query_user_exec(void);
+bool query_user_exec_systemd(void);
 
-#else  /* ENABLE_SYSTEMD not defined*/
+/**
+ * Loop through configured query_user slots, using the compiled method for
+ * querying the user.
+ *
+ * @return True if executing all the defined steps completed successfully
+ */
+static inline bool
+query_user_exec(void)
+{
+    return query_user_exec_systemd();
+}
+
+#else  /* ENABLE_SYSTEMD not defined */
 /**
  * Wrapper function enabling query_user_exec() if no alternative methods have
  * been enabled
  *
  */
-static bool
+static inline bool
 query_user_exec(void)
 {
     return query_user_exec_builtin();
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index c7cf1ad..cc91cd1 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -96,7 +96,7 @@
  *
  */
 bool
-query_user_exec(void)
+query_user_exec_systemd(void)
 {
     bool ret = true;  /* Presume everything goes okay */
     int i;
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 6d283a2..5518fa1 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -75,6 +75,14 @@
 {
     assert_true(0);
 }
+#if defined(ENABLE_SYSTEMD)
+bool
+query_user_exec_systemd(void)
+{
+    assert_true(0);
+    return false;
+}
+#endif
 bool
 query_user_exec_builtin(void)
 {
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index b43e655..de60291 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -26,10 +26,6 @@
 #include "config.h"
 #endif
 
-#undef ENABLE_SYSTEMD
-/* avoid redefining ENABLE_SYSTEMD in misc.c */
-#undef HAVE_CONFIG_H
-
 #include "syshead.h"
 #include "manage.h"
 
@@ -44,6 +40,13 @@
 struct management *management; /* global */
 
 /* mocking */
+#if defined(ENABLE_SYSTEMD)
+bool
+query_user_exec_systemd(void)
+{
+    return query_user_exec_builtin();
+}
+#endif
 bool
 query_user_exec_builtin(void)
 {

