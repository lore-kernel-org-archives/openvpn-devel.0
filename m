From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 20 Sep 2023 14:15:19 +0200
Message-Id: <20230920121519.177949-1-frank@...2641...>
In-Reply-To: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
References: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CMake: fix broken daemonization and syslog
 functionality
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
Cc: Lev Stipakov <lev@...515...>, Arne Schwabe <arne-openvpn@...1227...>

From: Lev Stipakov <lev@...515...>

While CMake is not the official way to build OpenVPN on Linux,
it still make sense to support it. Turns out that

  HAVE_SETSID, HAVE_OPENLOG and HAVE_SYSLOG

were not set by CMake configure, and --daemon and syslog
functionality was broken.

While on it, fix compiler error on unused return value of chdir().

Change-Id: I171d55da2be868d961caa1d4491e6f1ed10ebe8a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/341
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7dae665..9de6aba 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -150,6 +150,7 @@
 check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
+check_symbol_exists(setsid unistd.h HAVE_SETSID)
 check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)
 
 check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 4f28917..f2cdd39 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -218,7 +218,7 @@
 #undef HAVE_NICE
 
 /* Define to 1 if you have the `openlog' function. */
-#undef HAVE_OPENLOG
+#cmakedefine HAVE_OPENLOG
 
 /* OpenSSL engine support available */
 #undef HAVE_OPENSSL_ENGINE
@@ -258,7 +258,7 @@
 #undef HAVE_SETGROUPS
 
 /* Define to 1 if you have the `setsid' function. */
-#undef HAVE_SETSID
+#cmakedefine HAVE_SETSID
 
 /* Define to 1 if you have the `setsockopt' function. */
 #define HAVE_SETSOCKOPT 1
@@ -303,7 +303,7 @@
 #undef HAVE_STRSEP
 
 /* Define to 1 if you have the `syslog' function. */
-#undef HAVE_SYSLOG
+#cmakedefine HAVE_SYSLOG
 
 /* Define to 1 if you have the <syslog.h> header file. */
 #cmakedefine HAVE_SYSLOG_H
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index aebb8f4..5c6d740 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -70,7 +70,10 @@
 
     if (!nochdir)
     {
-        chdir("/");
+        if (chdir("/") == -1)
+        {
+            return (-1);
+        }
     }
 
     if (!noclose)

