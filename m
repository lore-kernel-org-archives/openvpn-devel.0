From: Gert Doering <gert@...1296...>
Date: Wed, 10 Mar 2021 13:48:08 +0100
Message-Id: <20210310124808.14741-1-gert@...1296...>
In-Reply-To: <20210308071023.18269-1-gert@...1296...>
References: <20210308071023.18269-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Require at least 100MB of mlock()-able
 memory if --mlock is used.
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

If --mlock is used, the amount of memory OpenVPN can use is guarded
by the RLIMIT_MEMLOCK value (see mlockall(2)).  The OS default for this
is usually 64 Kbyte, which is enough for OpenVPN to initialize, but
as soon as the first TLS handshake comes it, OpenVPN will crash due
to "ouf of memory", and might even end up in a crash loop.

Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with
many concurrent clients) of memory.  TLS renegotiation with EC keys
requires up to 90 MB of transient memory.

So: with this patch, we check if getrlimit() is available, and if yes,
log the amount of mlock'able memory.  If the amount is below 100 MB,
which is an arbitrary value "large enough for most smaller deployments",
we try to increase the limits to 100 MB, and abort if this fails.

v2:
  change arbitrary number to 100 MB, introduce #define for it
  not only check but also increase with setrlimit()
  uncrustify fixes

v3:
  OpenSolaris has mlockall() and getrlimit(), but no RLIMIT_MEMLOCK -
    make code conditional on HAVE_GETRLIMIT *and* RLIMIT_MEMLOCK
  add Changes.rst entry

Trac: #1390

Signed-off-by: Gert Doering <gert@...1296...>
---
 Changes.rst                          |  5 +++++
 configure.ac                         |  2 +-
 doc/man-sections/generic-options.rst |  7 +++++++
 src/openvpn/platform.c               | 29 ++++++++++++++++++++++++++++
 src/openvpn/platform.h               |  4 ++++
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 62008e8d..d6be1050 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -15,6 +15,11 @@ Compatibility with OpenSSL in FIPS mode
     requirements/recommendation of FIPS 140-2. This just allows OpenVPN
     to be run on a system that be configured OpenSSL in FIPS mode.
 
+``mlock`` will now check if enough memlock-able memory has been reserved,
+    and if less than 100MB RAM are available, use setrlimit() to upgrade
+    the limit.  See Trac #1390.  Not available on OpenSolaris.
+
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/configure.ac b/configure.ac
index 1ab8fe59..c65df3e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -645,7 +645,7 @@ AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system getpid dup dup2 \
-	getpass syslog openlog mlockall getgrnam setgid \
+	getpass syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups stat flock readv writev time gettimeofday \
 	ctime memset vsnprintf strdup \
 	setsid chdir putenv getpeername unlink \
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index d5f08839..c026529e 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -237,6 +237,13 @@ which mode OpenVPN is configured as.
   likely fail. The limit can be increased using ulimit or systemd
   directives depending on how OpenVPN is started.
 
+  If the platform has the getrlimit(2) system call, OpenVPN will check
+  for the amount of mlock-able memory before calling mlockall(2), and
+  tries to increase the limit to 100 MB if less than this is configured.
+  100 Mb is somewhat arbitrary - it is enough for a moderately-sized
+  OpenVPN deployment, but the memory usage might go beyond that if the
+  number of concurrent clients is high.
+
 --nice n
   Change process priority after initialization (``n`` greater than 0 is
   lower priority, ``n`` less than zero is higher priority).
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index ef688c23..3bf95f84 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -193,6 +193,35 @@ void
 platform_mlockall(bool print_msg)
 {
 #ifdef HAVE_MLOCKALL
+
+#if defined(HAVE_GETRLIMIT) && defined(RLIMIT_MEMLOCK)
+#define MIN_LOCKED_MEM_MB 100
+    struct rlimit rl;
+    if (getrlimit(RLIMIT_MEMLOCK, &rl) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RLIMIT_MEMLOCK) failed");
+    }
+    else
+    {
+        msg(M_INFO, "mlock: MEMLOCK limit: soft=%ld KB, hard=%ld KB",
+            ((long int) rl.rlim_cur) / 1024, ((long int) rl.rlim_max) / 1024);
+        if (rl.rlim_cur < MIN_LOCKED_MEM_MB*1024*1024)
+        {
+            msg(M_INFO, "mlock: RLIMIT_MEMLOCK < %d MB, increase limit",
+                MIN_LOCKED_MEM_MB);
+            rl.rlim_cur = MIN_LOCKED_MEM_MB*1024*1024;
+            if (rl.rlim_max < rl.rlim_cur)
+            {
+                rl.rlim_max = rl.rlim_cur;
+            }
+            if (setrlimit(RLIMIT_MEMLOCK, &rl) < 0)
+            {
+                msg(M_FATAL | M_ERRNO, "ERROR: setrlimit() failed");
+            }
+        }
+    }
+#endif
+
     if (mlockall(MCL_CURRENT | MCL_FUTURE))
     {
         msg(M_WARN | M_ERRNO, "WARNING: mlockall call failed");
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 01f3200c..02c23e38 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -48,6 +48,10 @@
 #include <stdio.h>
 #endif
 
+#ifdef HAVE_GETRLIMIT
+#include <sys/resource.h>
+#endif
+
 #include "basic.h"
 #include "buffer.h"
 
-- 
2.26.2


