From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 17:28:38 +0100
Message-ID: <20251028162843.18189-1-gert@...1296...>
In-Reply-To: <gerrit.1761573316000.I54845bf4dd17d06cfc3b402f188795f74f4b1d3e@...2715...>
References: <gerrit.1761573316000.I54845bf4dd17d06cfc3b402f188795f74f4b1d3e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] sitnl: set FD_CLOEXEC on socket to
 prevent abuse
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

From: Antonio Quartulli <antonio@...2726...>

Since OpenVPN spawns various child processes, it is important
that sockets are closed after calling exec.

The sitnl socket didn't have the right flag set, resulting
in it surviving in, for example, connect/disconnect scripts
and giving the latter a chance to abuse the socket.

Ensure this doesn't happen by setting FD_CLOEXEC on
this socket right after creation.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I54845bf4dd17d06cfc3b402f188795f74f4b1d3e
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1314
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1314
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5954a6e..bf754f3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -923,6 +923,7 @@
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/crypto_epoch.c
+            src/openvpn/fdmisc.c
             src/openvpn/otime.c
             src/openvpn/packet_id.c
             )
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b3adb16..3e20b70 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -27,6 +27,7 @@
 
 #include "dco.h"
 #include "errlevel.h"
+#include "fdmisc.h"
 #include "buffer.h"
 #include "misc.h"
 #include "networking.h"
@@ -181,6 +182,9 @@
         return fd;
     }
 
+    /* set close on exec to avoid child processes access the socket */
+    set_cloexec(fd);
+
     if (setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf)) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: SO_SNDBUF", __func__);
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 997703a..0f13172 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -196,6 +196,7 @@
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/fdmisc.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c

