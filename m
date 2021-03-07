From: Gert Doering <gert@...1296...>
Date: Sun,  7 Mar 2021 17:15:47 +0100
Message-Id: <20210307161547.25130-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
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
many concurrent clients) of memory.

So: with this patch, we check if getrlimit() is available, and if yes,
log the amount of mlock'able memory.  If the amount is below 20 MB,
which is an arbitrary value "large enough for most smaller deployments",
we abort.

Trac: #1390

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac                         |  2 +-
 doc/man-sections/generic-options.rst |  6 ++++++
 src/openvpn/platform.c               | 18 ++++++++++++++++++
 src/openvpn/platform.h               |  4 ++++
 4 files changed, 29 insertions(+), 1 deletion(-)

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
index d5f08839..0a7d3caf 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -237,6 +237,12 @@ which mode OpenVPN is configured as.
   likely fail. The limit can be increased using ulimit or systemd
   directives depending on how OpenVPN is started.
 
+  If the platform has the getrlimit(2) system call, OpenVPN will check
+  for the amount of mlock-able memory before calling mlockall(2), and 
+  abort if less than 20 Mb are available.  20 Mb is somewhat arbitrary -
+  it is enough for a moderately-sized OpenVPN deployment, but the memory
+  usage will go beyond that if the number of concurrent clients is high.
+
 --nice n
   Change process priority after initialization (``n`` greater than 0 is
   lower priority, ``n`` less than zero is higher priority).
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index ef688c23..67a69748 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -193,6 +193,24 @@ void
 platform_mlockall(bool print_msg)
 {
 #ifdef HAVE_MLOCKALL
+
+#ifdef HAVE_GETRLIMIT
+    struct rlimit rl;
+    if (getrlimit(RLIMIT_MEMLOCK,&rl)<0)
+    {
+        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RLIMIT_MEMLOCK) failed");
+    }
+    else
+    {
+	msg(M_INFO, "mlock: MEMLOCK limit: soft=%ldkb, hard=%dkb",
+	    ((long int) rl.rlim_cur)/1024, ((long int) rl.rlim_max)/1024);
+	if (rl.rlim_cur < 20*1024*1024)
+	{
+	    msg(M_FATAL, "mlock: RLIMIT_MEMLOCK < 20 MByte, increase limit");
+	}
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


