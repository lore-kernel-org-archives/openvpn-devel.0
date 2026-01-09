From: Gert Doering <gert@...1296...>
Date: Fri,  9 Jan 2026 17:35:08 +0100
Message-ID: <20260109163514.23051-1-gert@...1296...>
In-Reply-To: <gerrit.1767974222000.Ie59e03ce01575acaeaf690f582eb5cfa80eb37fc@...2715...>
References: <gerrit.1767974222000.Ie59e03ce01575acaeaf690f582eb5cfa80eb37fc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] configure.ac: Clean up systemd support
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

- Do not try to handle very old systemd that was released
  over ten years ago (remove SYSTEMD_NEWER_THAN_216)
- Do not require systemd.pc. I can't find any indication
  that we use any of the variables defined by it. (It
  does not define any libraries, just variables)
- Remove check for sd-daemon.h. We did not use the
  conditional and assumed it was there already.
- Allow libsystemd.pc to define cflags. Previously we
  ignored those.

Change-Id: Ie59e03ce01575acaeaf690f582eb5cfa80eb37fc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1463
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1463
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 01bbadc..53976a7 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -284,9 +284,6 @@
 /* Define to 1 if you have the <syslog.h> header file. */
 #cmakedefine HAVE_SYSLOG_H
 
-/* Define to 1 if you have the <systemd/sd-daemon.h> header file. */
-#undef HAVE_SYSTEMD_SD_DAEMON_H
-
 /* Define to 1 if you have the <sys/epoll.h> header file. */
 #cmakedefine HAVE_SYS_EPOLL_H
 
@@ -374,9 +371,6 @@
 /* Path to systemd-ask-password tool */
 #undef SYSTEMD_ASK_PASSWORD_PATH
 
-/* systemd is newer than v216 */
-#define SYSTEMD_NEWER_THAN_216
-
 /* The tap-windows id */
 #define TAP_WIN_COMPONENT_ID "tap0901"
 
diff --git a/configure.ac b/configure.ac
index 8ba5673..63d4d6e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1139,28 +1139,14 @@
 dnl
 AM_CONDITIONAL([ENABLE_SYSTEMD], [test "${enable_systemd}" = "yes"])
 if test "$enable_systemd" = "yes" ; then
-    PKG_CHECK_MODULES([libsystemd], [systemd libsystemd],
+    PKG_CHECK_MODULES([libsystemd], [libsystemd > 216],
                       [],
-                      [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon])]
+                      [AC_MSG_ERROR([systemd enabled but libsystemd is missing])]
                       )
 
-    PKG_CHECK_EXISTS([libsystemd > 216],
-                     [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],
-                           [systemd is newer than v216])]
-                    )
-
-    AC_CHECK_HEADERS(systemd/sd-daemon.h,
-       ,
-       [
-	   AC_MSG_ERROR([systemd development headers not found.])
-       ])
-
-    saved_LIBS="${LIBS}"
-    LIBS="${LIBS} ${libsystemd_LIBS}"
-    AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is missing sd_booted()])])
+    OPTIONAL_SYSTEMD_CFLAGS="${libsystemd_CFLAGS}"
     OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
     AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
-    LIBS="${saved_LIBS}"
 
     if test -n "${SYSTEMD_UNIT_DIR}"; then
         systemdunitdir="${SYSTEMD_UNIT_DIR}"
@@ -1377,6 +1363,7 @@
 AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_LZ4_CFLAGS])
 AC_SUBST([OPTIONAL_LZ4_LIBS])
+AC_SUBST([OPTIONAL_SYSTEMD_CFLAGS])
 AC_SUBST([OPTIONAL_SYSTEMD_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 19c21c0f..c879585 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -28,6 +28,7 @@
 	$(OPTIONAL_LIBNL_GENL_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
+	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
 	-DPLUGIN_LIBDIR=\"${plugindir}\" \
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index d277bd4..9588b95 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -61,13 +61,10 @@
     struct argv argv = argv_new();
 
     argv_printf(&argv, SYSTEMD_ASK_PASSWORD_PATH);
-#ifdef SYSTEMD_NEWER_THAN_216
-    /* the --echo support arrived in upstream systemd 217 */
     if (echo)
     {
         argv_printf_cat(&argv, "--echo");
     }
-#endif
     argv_printf_cat(&argv, "--icon network-vpn");
     argv_printf_cat(&argv, "--timeout=0");
     argv_printf_cat(&argv, "%s", prompt);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c014a91..b690dff 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1545,7 +1545,7 @@
 #else
 #ifdef ENABLE_SYSTEMD
         sd_notifyf(0, "STATUS=Failed to start up: %s With Errors\nERRNO=1", message);
-#endif /* HAVE_SYSTEMD_SD_DAEMON_H */
+#endif
         msg(M_INFO, "%s With Errors", message);
 #endif
     }
@@ -5052,4 +5052,4 @@
     packet_id_free(&c->c2.crypto_options.packet_id);
 
     context_gc_free(c);
-}
\ No newline at end of file
+}

