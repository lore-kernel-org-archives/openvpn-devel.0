From: Gert Doering <gert@...1296...>
Date: Wed, 29 Oct 2025 17:38:43 +0100
Message-ID: <20251029163849.446-1-gert@...1296...>
In-Reply-To: <gerrit.1761749931000.I5f57e7bf52e3f6289462ef05e1f6e81ab0133d0d@...2715...>
References: <gerrit.1761749931000.I5f57e7bf52e3f6289462ef05e1f6e81ab0133d0d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove --memstats feature
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

From: Arne Schwabe <arne@...1227...>

The ``--mememstat`` was largely undocumented and there is no known
user of this feature.  This feature provided very limited statistics
(number of users, link bytes read/written) and we do not except any
usage because of this.

The only documentation was a mention in --help without any mention of
the (binary) format of the mmap file or other usage instructions.

This deals also with issues reported by zeropath regarding potentially
insecure handling of the file permission of the memory mapped file.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I5f57e7bf52e3f6289462ef05e1f6e81ab0133d0d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1329
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1329
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bf754f3..c9301e6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -490,8 +490,6 @@
     src/openvpn/mroute.h
     src/openvpn/mss.c
     src/openvpn/mss.h
-    src/openvpn/mstats.c
-    src/openvpn/mstats.h
     src/openvpn/mtcp.c
     src/openvpn/mtcp.h
     src/openvpn/mtu.c
diff --git a/Changes.rst b/Changes.rst
index 4feacad2..41af103 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -217,6 +217,11 @@
     ``--allow-compression yes`` is now an alias for
     ``--allow-compression asym``.
 
+``--memstats`` feature removed
+    The ``--mememstat`` was largely undocumented and there is no known
+    user of this feature.  This feature provided very limited statistics
+    (number of users, link bytes read/written) and we do not except any
+    usage because of this.
 
 User-visible Changes
 --------------------
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index dc58cd1..db87dfc 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -90,7 +90,6 @@
 	mbedtls_compat.h \
 	mroute.c mroute.h \
 	mss.c mss.h \
-	mstats.c mstats.h \
 	mtcp.c mtcp.h \
 	mtu.c mtu.h \
 	mudp.c mudp.h \
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 735d259..bd588d4 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -37,8 +37,6 @@
 #include "status.h"
 #include "integer.h"
 #include "ps.h"
-#include "mstats.h"
-
 
 #if SYSLOG_CAPABILITY
 #ifndef LOG_OPENVPN
@@ -723,10 +721,6 @@
         }
 #endif
 
-#ifdef ENABLE_MEMSTATS
-        mstats_close();
-#endif
-
 #ifdef ABORT_ON_ERROR
         if (status == OPENVPN_EXIT_STATUS_ERROR)
         {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7f72000..5bbac13 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -44,8 +44,6 @@
 
 #include "memdbg.h"
 
-#include "mstats.h"
-
 counter_type link_read_bytes_global;  /* GLOBAL */
 counter_type link_write_bytes_global; /* GLOBAL */
 
@@ -992,12 +990,6 @@
     {
         c->c2.link_read_bytes += c->c2.buf.len;
         link_read_bytes_global += c->c2.buf.len;
-#ifdef ENABLE_MEMSTATS
-        if (mmap_stats)
-        {
-            mmap_stats->link_read_bytes = link_read_bytes_global;
-        }
-#endif
         c->c2.original_recv_size = c->c2.buf.len;
     }
     else
@@ -1821,12 +1813,6 @@
                 c->c2.max_send_size_local = max_int(size, c->c2.max_send_size_local);
                 c->c2.link_write_bytes += size;
                 link_write_bytes_global += size;
-#ifdef ENABLE_MEMSTATS
-                if (mmap_stats)
-                {
-                    mmap_stats->link_write_bytes = link_write_bytes_global;
-                }
-#endif
             }
         }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aa2611d..1bdaf27 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -44,7 +44,6 @@
 #include "ps.h"
 #include "lladdr.h"
 #include "ping.h"
-#include "mstats.h"
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
 #include "tls_crypt.h"
@@ -908,22 +907,6 @@
     return false;
 #endif
 
-#ifdef MSTATS_TEST
-    {
-        int i;
-        mstats_open("/dev/shm/mstats.dat");
-        for (i = 0; i < 30; ++i)
-        {
-            mmap_stats->n_clients += 1;
-            mmap_stats->link_write_bytes += 8;
-            mmap_stats->link_read_bytes += 16;
-            sleep(1);
-        }
-        mstats_close();
-        return false;
-    }
-#endif
-
     return true;
 }
 
@@ -1233,13 +1216,6 @@
             }
         }
 
-#ifdef ENABLE_MEMSTATS
-        if (c->first_time && c->options.memstats_fn)
-        {
-            mstats_open(c->options.memstats_fn);
-        }
-#endif
-
 #ifdef ENABLE_SELINUX
         /* Apply a SELinux context in order to restrict what OpenVPN can do
          * to _only_ what it is supposed to do after initialization is complete
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
deleted file mode 100644
index bd6316c..0000000
--- a/src/openvpn/mstats.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-/*
- * Maintain usage stats in a memory-mapped file
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_MEMSTATS)
-
-#include <sys/mman.h>
-
-#include "error.h"
-#include "misc.h"
-#include "mstats.h"
-
-#include "memdbg.h"
-
-volatile struct mmap_stats *mmap_stats = NULL; /* GLOBAL */
-static char mmap_fn[128];
-
-void
-mstats_open(const char *fn)
-{
-    void *data;
-    ssize_t stat;
-    int fd;
-    struct mmap_stats ms;
-
-    if (mmap_stats) /* already called? */
-    {
-        return;
-    }
-
-    /* verify that filename is not too long */
-    if (strlen(fn) >= sizeof(mmap_fn))
-    {
-        msg(M_FATAL, "mstats_open: filename too long");
-    }
-
-    /* create file that will be memory mapped */
-    fd = open(fn, O_CREAT | O_TRUNC | O_RDWR, S_IRUSR | S_IWUSR);
-    if (fd < 0)
-    {
-        msg(M_ERR, "mstats_open: cannot open: %s", fn);
-        return;
-    }
-
-    /* set the file to the correct size to contain a
-     * struct mmap_stats, and zero it */
-    CLEAR(ms);
-    ms.state = MSTATS_ACTIVE;
-    stat = write(fd, &ms, sizeof(ms));
-    if (stat != sizeof(ms))
-    {
-        msg(M_ERR, "mstats_open: write error: %s", fn);
-        close(fd);
-        return;
-    }
-
-    /* mmap the file */
-    data = mmap(NULL, sizeof(struct mmap_stats), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-    if (data == MAP_FAILED)
-    {
-        msg(M_ERR, "mstats_open: write error: %s", fn);
-        close(fd);
-        return;
-    }
-
-    /* close the fd (mmap now controls the file) */
-    if (close(fd))
-    {
-        msg(M_ERR, "mstats_open: close error: %s", fn);
-    }
-
-    /* save filename so we can delete it later */
-    strcpy(mmap_fn, fn);
-
-    /* save a global pointer to memory-mapped region */
-    mmap_stats = (struct mmap_stats *)data;
-
-    msg(M_INFO, "memstats data will be written to %s", fn);
-}
-
-void
-mstats_close(void)
-{
-    if (mmap_stats)
-    {
-        mmap_stats->state = MSTATS_EXPIRED;
-        if (munmap((void *)mmap_stats, sizeof(struct mmap_stats)))
-        {
-            msg(M_WARN | M_ERRNO, "mstats_close: munmap error");
-        }
-        platform_unlink(mmap_fn);
-        mmap_stats = NULL;
-    }
-}
-
-#endif /* if defined(ENABLE_MEMSTATS) */
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
deleted file mode 100644
index c38b0f2..0000000
--- a/src/openvpn/mstats.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-/*
- * Maintain usage stats in a memory-mapped file
- */
-
-#if !defined(OPENVPN_MEMSTATS_H) && defined(ENABLE_MEMSTATS)
-#define OPENVPN_MEMSTATS_H
-
-#include "basic.h"
-
-/* this struct is mapped to the file */
-struct mmap_stats
-{
-    counter_type link_read_bytes; /* counter_type can be assumed to be a uint64_t */
-    counter_type link_write_bytes;
-    int n_clients;
-
-#define MSTATS_UNDEF   0
-#define MSTATS_ACTIVE  1
-#define MSTATS_EXPIRED 2
-    int state;
-};
-
-extern volatile struct mmap_stats *mmap_stats; /* GLOBAL */
-
-void mstats_open(const char *fn);
-
-void mstats_close(void);
-
-#endif /* if !defined(OPENVPN_MEMSTATS_H) && defined(ENABLE_MEMSTATS) */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 285671d..e243843 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -37,7 +37,6 @@
 #include "run_command.h"
 #include "otime.h"
 #include "gremlin.h"
-#include "mstats.h"
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
 #include "vlan.h"
@@ -80,17 +79,6 @@
 }
 #endif
 
-static inline void
-update_mstat_n_clients(const int n_clients)
-{
-#ifdef ENABLE_MEMSTATS
-    if (mmap_stats)
-    {
-        mmap_stats->n_clients = n_clients;
-    }
-#endif
-}
-
 static bool
 learn_address_script(const struct multi_context *m, const struct multi_instance *mi, const char *op,
                      const struct mroute_addr *addr)
@@ -589,7 +577,6 @@
 
     /* adjust current client connection count */
     m->n_clients += mi->n_clients_delta;
-    update_mstat_n_clients(m->n_clients);
     mi->n_clients_delta = 0;
 
     /* prevent dangling pointers */
@@ -2799,7 +2786,6 @@
 
     /* increment number of current authenticated clients */
     ++m->n_clients;
-    update_mstat_n_clients(m->n_clients);
     --mi->n_clients_delta;
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9c02a8c..ecf9374 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -323,9 +323,6 @@
     "                  via a VRF present on the system.\n"
 #endif
     "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n"
-#ifdef ENABLE_MEMSTATS
-    "--memstats file : Write live usage stats to memory mapped binary file.\n"
-#endif
     "--mlock         : Disable Paging -- ensures key material and tunnel\n"
     "                  data will never be written to disk.\n"
     "--up cmd        : Run command cmd after successful tun device open.\n"
@@ -6333,13 +6330,6 @@
         options->log = true;
         redirect_stdout_stderr(p[1], true);
     }
-#ifdef ENABLE_MEMSTATS
-    else if (streq(p[0], "memstats") && p[1] && !p[2])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->memstats_fn = p[1];
-    }
-#endif
     else if (streq(p[0], "mlock") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 125e524..9d2ff9f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -336,10 +336,6 @@
 
     bool mtu_test;
 
-#ifdef ENABLE_MEMSTATS
-    char *memstats_fn;
-#endif
-
     bool mlock;
 
     int keepalive_ping; /* a proxy for ping/ping-restart */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 26a553b..90045a9 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -528,13 +528,6 @@
 #define USE_COMP
 #endif
 
-/*
- * Enable --memstats option
- */
-#ifdef TARGET_LINUX
-#define ENABLE_MEMSTATS
-#endif
-
 #ifdef _MSC_VER
 #ifndef PATH_MAX
 #define PATH_MAX MAX_PATH

