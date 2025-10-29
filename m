From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 14:58:54 +0000
References: <gerrit.1761749931000.I5f57e7bf52e3f6289462ef05e1f6e81ab0133d0d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7812d72e190572b9cca4dd7369f4404f26caf3fc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vYf/NhR0Q9Y="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove --memstats
 feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vYf/NhR0Q9Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1329?usp=3Demail

to review the following change.


Change subject: Remove --memstats feature
......................................................................

Remove --memstats feature

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
---
M CMakeLists.txt
M Changes.rst
M src/openvpn/Makefile.am
M src/openvpn/error.c
M src/openvpn/forward.c
M src/openvpn/init.c
D src/openvpn/mstats.c
D src/openvpn/mstats.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/syshead.h
12 files changed, 5 insertions(+), 257 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1329/1

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
         if (status =3D=3D OPENVPN_EXIT_STATUS_ERROR)
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
         c->c2.link_read_bytes +=3D c->c2.buf.len;
         link_read_bytes_global +=3D c->c2.buf.len;
-#ifdef ENABLE_MEMSTATS
-        if (mmap_stats)
-        {
-            mmap_stats->link_read_bytes =3D link_read_bytes_global;
-        }
-#endif
         c->c2.original_recv_size =3D c->c2.buf.len;
     }
     else
@@ -1821,12 +1813,6 @@
                 c->c2.max_send_size_local =3D max_int(size, c->c2.max_send=
_size_local);
                 c->c2.link_write_bytes +=3D size;
                 link_write_bytes_global +=3D size;
-#ifdef ENABLE_MEMSTATS
-                if (mmap_stats)
-                {
-                    mmap_stats->link_write_bytes =3D link_write_bytes_glob=
al;
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
-        for (i =3D 0; i < 30; ++i)
-        {
-            mmap_stats->n_clients +=3D 1;
-            mmap_stats->link_write_bytes +=3D 8;
-            mmap_stats->link_read_bytes +=3D 16;
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
          * to _only_ what it is supposed to do after initialization is com=
plete
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
-volatile struct mmap_stats *mmap_stats =3D NULL; /* GLOBAL */
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
-    if (strlen(fn) >=3D sizeof(mmap_fn))
-    {
-        msg(M_FATAL, "mstats_open: filename too long");
-    }
-
-    /* create file that will be memory mapped */
-    fd =3D open(fn, O_CREAT | O_TRUNC | O_RDWR, S_IRUSR | S_IWUSR);
-    if (fd < 0)
-    {
-        msg(M_ERR, "mstats_open: cannot open: %s", fn);
-        return;
-    }
-
-    /* set the file to the correct size to contain a
-     * struct mmap_stats, and zero it */
-    CLEAR(ms);
-    ms.state =3D MSTATS_ACTIVE;
-    stat =3D write(fd, &ms, sizeof(ms));
-    if (stat !=3D sizeof(ms))
-    {
-        msg(M_ERR, "mstats_open: write error: %s", fn);
-        close(fd);
-        return;
-    }
-
-    /* mmap the file */
-    data =3D mmap(NULL, sizeof(struct mmap_stats), PROT_READ | PROT_WRITE,=
 MAP_SHARED, fd, 0);
-    if (data =3D=3D MAP_FAILED)
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
-    mmap_stats =3D (struct mmap_stats *)data;
-
-    msg(M_INFO, "memstats data will be written to %s", fn);
-}
-
-void
-mstats_close(void)
-{
-    if (mmap_stats)
-    {
-        mmap_stats->state =3D MSTATS_EXPIRED;
-        if (munmap((void *)mmap_stats, sizeof(struct mmap_stats)))
-        {
-            msg(M_WARN | M_ERRNO, "mstats_close: munmap error");
-        }
-        platform_unlink(mmap_fn);
-        mmap_stats =3D NULL;
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
-    counter_type link_read_bytes; /* counter_type can be assumed to be a u=
int64_t */
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
-        mmap_stats->n_clients =3D n_clients;
-    }
-#endif
-}
-
 static bool
 learn_address_script(const struct multi_context *m, const struct multi_ins=
tance *mi, const char *op,
                      const struct mroute_addr *addr)
@@ -589,7 +577,6 @@

     /* adjust current client connection count */
     m->n_clients +=3D mi->n_clients_delta;
-    update_mstat_n_clients(m->n_clients);
     mi->n_clients_delta =3D 0;

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
     "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\=
n"
-#ifdef ENABLE_MEMSTATS
-    "--memstats file : Write live usage stats to memory mapped binary file=
.\n"
-#endif
     "--mlock         : Disable Paging -- ensures key material and tunnel\n"
     "                  data will never be written to disk.\n"
     "--up cmd        : Run command cmd after successful tun device open.\n"
@@ -6333,13 +6330,6 @@
         options->log =3D true;
         redirect_stdout_stderr(p[1], true);
     }
-#ifdef ENABLE_MEMSTATS
-    else if (streq(p[0], "memstats") && p[1] && !p[2])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->memstats_fn =3D p[1];
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1329?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5f57e7bf52e3f6289462ef05e1f6e81ab0133d0d
Gerrit-Change-Number: 1329
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--vYf/NhR0Q9Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1329?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove --memstats feature<br><br>The ``--me=
memstat`` was largely undocumented and there is no known<br>user of this fe=
ature.  This feature provided very limited statistics<br>(number of users, =
link bytes read/written) and we do not except any<br>usage because of this.=
<br><br>The only documentation was a mention in --help without any mention =
of<br>the (binary) format of the mmap file or other usage instructions.<br>=
<br>This deals also with issues reported by zeropath regarding potentially<=
br>insecure handling of the file permission of the memory mapped file.<br><=
br>Reported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroP=
ath (https://zeropath.com/)<br>Change-Id: I5f57e7bf52e3f6289462ef05e1f6e81a=
b0133d0d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M=
 CMakeLists.txt<br>M Changes.rst<br>M src/openvpn/Makefile.am<br>M src/open=
vpn/error.c<br>M src/openvpn/forward.c<br>M src/openvpn/init.c<br>D src/ope=
nvpn/mstats.c<br>D src/openvpn/mstats.h<br>M src/openvpn/multi.c<br>M src/o=
penvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/syshead.h<br>1=
2 files changed, 5 insertions(+), 257 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1329/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index =
bf754f3..c9301e6 100644</span><br><span>--- a/CMakeLists.txt</span><br><spa=
n>+++ b/CMakeLists.txt</span><br><span>@@ -490,8 +490,6 @@</span><br><span>=
     src/openvpn/mroute.h</span><br><span>     src/openvpn/mss.c</span><br>=
<span>     src/openvpn/mss.h</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    src/openvpn/mstats.c</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    src/openvpn/mstats.h</span><br><span>     src/openvpn/mtcp.c<=
/span><br><span>     src/openvpn/mtcp.h</span><br><span>     src/openvpn/mt=
u.c</span><br><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>=
index 4feacad2..41af103 100644</span><br><span>--- a/Changes.rst</span><br>=
<span>+++ b/Changes.rst</span><br><span>@@ -217,6 +217,11 @@</span><br><spa=
n>     ``--allow-compression yes`` is now an alias for</span><br><span>    =
 ``--allow-compression asym``.</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+``--memstats`` feature removed</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    The ``--mememstat`` was largely=
 undocumented and there is no known</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    user of this feature.  This feature provided very limit=
ed statistics</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (n=
umber of users, link bytes read/written) and we do not except any</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    usage because of this.</s=
pan><br><span> </span><br><span> User-visible Changes</span><br><span> ----=
----------------</span><br><span>diff --git a/src/openvpn/Makefile.am b/src=
/openvpn/Makefile.am</span><br><span>index dc58cd1..db87dfc 100644</span><b=
r><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Mak=
efile.am</span><br><span>@@ -90,7 +90,6 @@</span><br><span> 	mbedtls_compat=
.h \</span><br><span> 	mroute.c mroute.h \</span><br><span> 	mss.c mss.h \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	mstats.c mstats.h \</=
span><br><span> 	mtcp.c mtcp.h \</span><br><span> 	mtu.c mtu.h \</span><br>=
<span> 	mudp.c mudp.h \</span><br><span>diff --git a/src/openvpn/error.c b/=
src/openvpn/error.c</span><br><span>index 735d259..bd588d4 100644</span><br=
><span>--- a/src/openvpn/error.c</span><br><span>+++ b/src/openvpn/error.c<=
/span><br><span>@@ -37,8 +37,6 @@</span><br><span> #include &quot;status.h&=
quot;</span><br><span> #include &quot;integer.h&quot;</span><br><span> #inc=
lude &quot;ps.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#include &quot;mstats.h&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> </span><br><span> #if SYSLOG_CAPABILITY</span><br=
><span> #ifndef LOG_OPENVPN</span><br><span>@@ -723,10 +721,6 @@</span><br>=
<span>         }</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MEMSTATS</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        mstats_close();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> #ifdef ABORT_ON_ERROR</span><br>=
<span>         if (status =3D=3D OPENVPN_EXIT_STATUS_ERROR)</span><br><span=
>         {</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvp=
n/forward.c</span><br><span>index 7f72000..5bbac13 100644</span><br><span>-=
-- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</spa=
n><br><span>@@ -44,8 +44,6 @@</span><br><span> </span><br><span> #include &=
quot;memdbg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#include &quot;mstats.h&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> counter_type link_read_bytes_glob=
al;  /* GLOBAL */</span><br><span> counter_type link_write_bytes_global; /*=
 GLOBAL */</span><br><span> </span><br><span>@@ -992,12 +990,6 @@</span><br=
><span>     {</span><br><span>         c-&gt;c2.link_read_bytes +=3D c-&gt;=
c2.buf.len;</span><br><span>         link_read_bytes_global +=3D c-&gt;c2.b=
uf.len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
MEMSTATS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m=
map_stats)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mmap_stats-=
&gt;link_read_bytes =3D link_read_bytes_global;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span>         c-&gt;c2.original_recv_size =
=3D c-&gt;c2.buf.len;</span><br><span>     }</span><br><span>     else</spa=
n><br><span>@@ -1821,12 +1813,6 @@</span><br><span>                 c-&gt;c=
2.max_send_size_local =3D max_int(size, c-&gt;c2.max_send_size_local);</spa=
n><br><span>                 c-&gt;c2.link_write_bytes +=3D size;</span><br=
><span>                 link_write_bytes_global +=3D size;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MEMSTATS</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (mmap_stats)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    mmap_stats-=
&gt;link_write_bytes =3D link_write_bytes_global;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span>             }</span><br><sp=
an>         }</span><br><span> </span><br><span>diff --git a/src/openvpn/in=
it.c b/src/openvpn/init.c</span><br><span>index aa2611d..1bdaf27 100644</sp=
an><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/ini=
t.c</span><br><span>@@ -44,7 +44,6 @@</span><br><span> #include &quot;ps.h&=
quot;</span><br><span> #include &quot;lladdr.h&quot;</span><br><span> #incl=
ude &quot;ping.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &quot;mstats.h&quot;</span><br><span> #include &quot;ssl_verify.h=
&quot;</span><br><span> #include &quot;ssl_ncp.h&quot;</span><br><span> #in=
clude &quot;tls_crypt.h&quot;</span><br><span>@@ -908,22 +907,6 @@</span><b=
r><span>     return false;</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MSTATS_TEST</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        mstats_open(&quot;/dev/shm/mstats.dat&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; =
i &lt; 30; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mmap_s=
tats-&gt;n_clients +=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            mmap_stats-&gt;link_write_bytes +=3D 8;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            mmap_stats-&gt;link_read_byt=
es +=3D 16;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  sleep(1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mstats_close()=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     return true;</span><br><span>=
 }</span><br><span> </span><br><span>@@ -1233,13 +1216,6 @@</span><br><span=
>             }</span><br><span>         }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MEMSTATS</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;first_time &amp;&=
amp; c-&gt;options.memstats_fn)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          mstats_open(c-&gt;options.memstats_fn);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> #ifdef ENABLE_SELINUX</span><br><span>         /* Apply =
a SELinux context in order to restrict what OpenVPN can do</span><br><span>=
          * to _only_ what it is supposed to do after initialization is com=
plete</span><br><span>diff --git a/src/openvpn/mstats.c b/src/openvpn/mstat=
s.c</span><br><span>deleted file mode 100644</span><br><span>index bd6316c.=
.0000000</span><br><span>--- a/src/openvpn/mstats.c</span><br><span>+++ /de=
v/null</span><br><span>@@ -1,124 +0,0 @@</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  OpenVPN -- An application to securely tunnel IP networks</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *             over a single TCP/UDP=
 port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *             session authentication and key exchange,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *             packet compression.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  This program is free software; you can =
redistribute it and/or modify</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  it under the terms of the GNU General Public License version 2<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  as published by th=
e Free Software Foundation.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRANTY; without even=
 the implied warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  GNU General Public Licen=
se for more details.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Maintain usage stats in a memory-mapped file=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &quot;config.h&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot=
;syshead.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_MEMSTAT=
S)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &lt;sys/mman.h&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;error.h&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &quot;misc.h&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#include &quot;mstats.h&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;memdbg.h&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-volatile struct mmap_stats *mmap_stats =3D NULL; /* GLOBAL */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static char mmap_fn[128];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-mstats_open(const char *fn)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    void *data;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
size_t stat;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int f=
d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mmap_sta=
ts ms;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (mmap_stats) /* already calle=
d? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* verify that filename is not too long */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (strlen(fn) &gt;=3D sizeof(mmap_fn))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;mstats_open: fil=
ename too long&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* create file that will be memo=
ry mapped */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fd =
=3D open(fn, O_CREAT | O_TRUNC | O_RDWR, S_IRUSR | S_IWUSR);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (fd &lt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_ERR, &quot;mstats_open: cannot open: %s&q=
uot;, fn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* set the file to the correct size to contain a</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * struct mmap_stat=
s, and zero it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
CLEAR(ms);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms.stat=
e =3D MSTATS_ACTIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   stat =3D write(fd, &amp;ms, sizeof(ms));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (stat !=3D sizeof(ms))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_ERR, &quot;mstats_open: write error: %s&quot;=
, fn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        close(f=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* mmap the file */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    data =3D mmap(NULL, sizeof(struct mmap_stats), PROT_REA=
D | PROT_WRITE, MAP_SHARED, fd, 0);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (data =3D=3D MAP_FAILED)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(M_ERR, &quot;mstats_open: write error: %s&quot;, fn);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        close(fd);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* close the fd (mmap now controls the file) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (close(fd))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(M_ERR, &quot;mstats_open: close error: %s&quot=
;, fn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* save filename so we can delete it later */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strcpy(mmap_fn, fn)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* save a global pointer to memory-ma=
pped region */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mma=
p_stats =3D (struct mmap_stats *)data;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(M_INFO, &quot;memstats data will be written to %s&quot;, fn);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mstats_close(v=
oid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (mmap_stats)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        mmap_stats-&gt;state =3D MSTATS_EXPIRED;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (munmap((void *)m=
map_stats, sizeof(struct mmap_stats)))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(M_WARN | M_ERRNO, &quot;mstats_close: munmap error&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        platform_unlink(mmap_=
fn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mmap_stat=
s =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif /* if defined(ENABLE_MEMSTATS) */</span><br><span>diff --git=
 a/src/openvpn/mstats.h b/src/openvpn/mstats.h</span><br><span>deleted file=
 mode 100644</span><br><span>index c38b0f2..0000000</span><br><span>--- a/s=
rc/openvpn/mstats.h</span><br><span>+++ /dev/null</span><br><span>@@ -1,51 =
+0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             pack=
et compression.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2002-20=
25 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of =
the GNU General Public License version 2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  as published by the Free Software Foundation.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  This program is distributed in the hope tha=
t it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS =
FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  GNU General Public License for more details.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Mai=
ntain usage stats in a memory-mapped file</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(OPENVP=
N_MEMSTATS_H) &amp;&amp; defined(ENABLE_MEMSTATS)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define OPENVPN_MEMSTATS_H</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#include &quot;basic.h&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
 this struct is mapped to the file */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct mmap_stats</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    coun=
ter_type link_read_bytes; /* counter_type can be assumed to be a uint64_t *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    counter_type lin=
k_write_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 n_clients;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define MSTATS_UNDEF   0</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define MSTATS_ACTIVE  1</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MSTATS_EXPIRED 2<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int state;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-extern volatile struct mmap_stats *mmap_stats; /* GLOBAL */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void mstats_open(const char *fn);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void mstats_close(void);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* if !defined(OPENVPN_MEMSTATS_H) &amp;&amp; defined(ENABLE_MEMSTATS) *=
/</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</s=
pan><br><span>index 285671d..e243843 100644</span><br><span>--- a/src/openv=
pn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -37=
,7 +37,6 @@</span><br><span> #include &quot;run_command.h&quot;</span><br><=
span> #include &quot;otime.h&quot;</span><br><span> #include &quot;gremlin.=
h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot=
;mstats.h&quot;</span><br><span> #include &quot;ssl_verify.h&quot;</span><b=
r><span> #include &quot;ssl_ncp.h&quot;</span><br><span> #include &quot;vla=
n.h&quot;</span><br><span>@@ -80,17 +79,6 @@</span><br><span> }</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-update_mstat_n_clients(const int n_clients)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef ENABLE_MEMSTATS</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (mmap_stats)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
map_stats-&gt;n_clients =3D n_clients;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</spa=
n><br><span> learn_address_script(const struct multi_context *m, const stru=
ct multi_instance *mi, const char *op,</span><br><span>                    =
  const struct mroute_addr *addr)</span><br><span>@@ -589,7 +577,6 @@</span=
><br><span> </span><br><span>     /* adjust current client connection count=
 */</span><br><span>     m-&gt;n_clients +=3D mi-&gt;n_clients_delta;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    update_mstat_n_clients(=
m-&gt;n_clients);</span><br><span>     mi-&gt;n_clients_delta =3D 0;</span>=
<br><span> </span><br><span>     /* prevent dangling pointers */</span><br>=
<span>@@ -2799,7 +2786,6 @@</span><br><span> </span><br><span>     /* incre=
ment number of current authenticated clients */</span><br><span>     ++m-&g=
t;n_clients;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    updat=
e_mstat_n_clients(m-&gt;n_clients);</span><br><span>     --mi-&gt;n_clients=
_delta;</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><=
br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><=
br><span>index 9c02a8c..ecf9374 100644</span><br><span>--- a/src/openvpn/op=
tions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -323=
,9 +323,6 @@</span><br><span>     &quot;                  via a VRF present=
 on the system.\n&quot;</span><br><span> #endif</span><br><span>     &quot;=
--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MEMSTA=
TS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--memstat=
s file : Write live usage stats to memory mapped binary file.\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>    =
 &quot;--mlock         : Disable Paging -- ensures key material and tunnel\=
n&quot;</span><br><span>     &quot;                  data will never be wri=
tten to disk.\n&quot;</span><br><span>     &quot;--up cmd        : Run comm=
and cmd after successful tun device open.\n&quot;</span><br><span>@@ -6333,=
13 +6330,6 @@</span><br><span>         options-&gt;log =3D true;</span><br>=
<span>         redirect_stdout_stderr(p[1], true);</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MEMSTATS<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0=
], &quot;memstats&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;memstats_fn =
=3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     =
else if (streq(p[0], &quot;mlock&quot;) &amp;&amp; !p[1])</span><br><span> =
    {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br>=
<span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br>=
<span>index 125e524..9d2ff9f 100644</span><br><span>--- a/src/openvpn/optio=
ns.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -336,10=
 +336,6 @@</span><br><span> </span><br><span>     bool mtu_test;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
MEMSTATS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *mem=
stats_fn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     bool =
mlock;</span><br><span> </span><br><span>     int keepalive_ping; /* a prox=
y for ping/ping-restart */</span><br><span>diff --git a/src/openvpn/syshead=
.h b/src/openvpn/syshead.h</span><br><span>index 26a553b..90045a9 100644</s=
pan><br><span>--- a/src/openvpn/syshead.h</span><br><span>+++ b/src/openvpn=
/syshead.h</span><br><span>@@ -528,13 +528,6 @@</span><br><span> #define US=
E_COMP</span><br><span> #endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Enable --memstats option</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef TARGET_LINUX</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e ENABLE_MEMSTATS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #=
ifdef _MSC_VER</span><br><span> #ifndef PATH_MAX</span><br><span> #define P=
ATH_MAX MAX_PATH</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1329?usp=3Demail">change 1329</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1329?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5f57e7bf52e3f6289462ef05e1f=
6e81ab0133d0d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1329 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--vYf/NhR0Q9Y=--

