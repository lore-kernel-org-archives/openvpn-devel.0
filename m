From: Gert Doering <gert@...1296...>
Date: Mon,  4 Nov 2024 09:58:08 +0100
Message-ID: <20241104085808.17039-1-gert@...1296...>
In-Reply-To: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
References: <gerrit.1730665141000.Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] send uname() release as IV_PLAT_VER= on
 non-windows versions
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

This is highly system specific, as the content of the uname()
structure elements is not specified very well - uname(3) says:

      release       Release level of the operating system

which translates to "IV_PLAT_VER=13.3-RELEASE-p6" (FreeBSD) or
"IV_PLAT_VER=22.6.0" (macOS) - the latter being the "Mach Kernel
version", not what Apple calls the OS.

It's still useful if a server operator needs to keep track of
client versions (and the GUI does not set the corresponding
environment variable, which neither Tunnelblick nor NM do).

v2: manpage amendments
v3: whitespace
v4: reword manpage

Github: OpenVPN/openvpn#637

Change-Id: Id2b0c5a517f02e5c219fea2ae3ef2bdef7690169
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/793
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index a06948e..5ca85e0 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -430,7 +430,10 @@
         The version of the operating system, e.g. 6.1 for Windows 7.
         This may be set by the client UI/GUI using ``--setenv``.
         On Windows systems it is automatically determined by openvpn
-        itself.
+        itself.  On other platforms OpenVPN will default to sending
+        the information returned by the `uname()` system call in
+        the `release` field, which is usually the currently running
+        kernel version.  This is highly system specific, though.
 
   :code:`UV_<name>=<value>`
         Client environment variables whose names start with
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8040e7b..93e31f1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2010,6 +2010,10 @@
             buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
             buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
+#else
+            struct utsname u;
+            uname(&u);
+            buf_printf(&out, "IV_PLAT_VER=%s\n", u.release);
 #endif
         }
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 83a48fc..33a90c1 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -331,6 +331,10 @@
 #include <sys/mman.h>
 #endif
 
+#ifndef _WIN32
+#include <sys/utsname.h>
+#endif
+
 /*
  * Pedantic mode is meant to accomplish lint-style program checking,
  * not to build a working executable.

