From: Gert Doering <gert@...1296...>
Date: Tue,  7 Jul 2020 10:42:20 +0200
Message-Id: <20200707084220.45753-1-gert@...1296...>
In-Reply-To: <20200706190030.49301-1-gert@...1296...>
References: <20200706190030.49301-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove --writepid file on program exit.
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

For whatever reason, we never removed the pid file on program exit.

Not only this is unclean, but it also makes testing for "I want this
test case to FAIL" in t_client.sh more annoying to code for "is the
OpenVPN process still around?"...

Do not unlink the file if chroot() is active (might be outside the
chroot arena - testing for realpath etc. is left for someone else).

Signed-off-by: Gert Doering <gert@...1296...>

--
v2: make this work on M_FATAL exit, by unlinking from openvpn_exit() in
error.h - this requires moving write_pid() to init.c so module hierarchy
is maintained and introducing a static variable to save the PID file
name (otherwise it is no longer available when the top level GC is gone).
---
 src/openvpn/error.c   |  1 +
 src/openvpn/init.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/init.h    |  3 +++
 src/openvpn/openvpn.c | 24 +-----------------------
 4 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ad4f0ef4..d6247fec 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -743,6 +743,7 @@ openvpn_exit(const int status)
 #ifdef _WIN32
         uninit_win32();
 #endif
+        remove_pid_file();
 
         close_syslog();
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dd1747f3..cb850bc0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -58,6 +58,7 @@
 
 
 static struct context *static_context; /* GLOBAL */
+static const char *saved_pid_file_name; /* GLOBAL */
 
 /*
  * Crypto initialization flags
@@ -4687,6 +4688,47 @@ close_context(struct context *c, int sig, unsigned int flags)
     }
 }
 
+/* Write our PID to a file */
+void
+write_pid_file(const char *filename, const char *chroot_dir)
+{
+    if (filename)
+    {
+        unsigned int pid = 0;
+        FILE *fp = platform_fopen(filename, "w");
+        if (!fp)
+        {
+            msg(M_ERR, "Open error on pid file %s", filename);
+            return;
+        }
+
+        pid = platform_getpid();
+        fprintf(fp, "%u\n", pid);
+        if (fclose(fp))
+        {
+            msg(M_ERR, "Close error on pid file %s", filename);
+        }
+
+        /* remember file name so it can be deleted "out of context" later */
+	/* (the chroot case is more complex and not handled today) */
+        if (!chroot_dir)
+        {
+            saved_pid_file_name = strdup(filename);
+        }
+    }
+}
+
+/* remove PID file on exit, called from openvpn_exit() */
+void
+remove_pid_file(void)
+{
+    if (saved_pid_file_name)
+    {
+        platform_unlink(saved_pid_file_name);
+    }
+}
+
+
 /*
  * Do a loopback test
  * on the crypto subsystem.
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 0e6258f0..a2fdccd3 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -143,4 +143,7 @@ void open_plugins(struct context *c, const bool import_options, int init_point);
 
 void tun_abort(void);
 
+void write_pid_file(const char *filename, const char *chroot_dir);
+void remove_pid_file(void);
+
 #endif /* ifndef INIT_H */
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index dc7001dc..857c5faa 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -46,28 +46,6 @@ process_signal_p2p(struct context *c)
     return process_signal(c);
 }
 
-/* Write our PID to a file */
-static void
-write_pid(const char *filename)
-{
-    if (filename)
-    {
-        unsigned int pid = 0;
-        FILE *fp = platform_fopen(filename, "w");
-        if (!fp)
-        {
-            msg(M_ERR, "Open error on pid file %s", filename);
-        }
-
-        pid = platform_getpid();
-        fprintf(fp, "%u\n", pid);
-        if (fclose(fp))
-        {
-            msg(M_ERR, "Close error on pid file %s", filename);
-        }
-    }
-}
-
 
 /**************************************************************************/
 /**
@@ -274,7 +252,7 @@ openvpn_main(int argc, char *argv[])
             if (c.first_time)
             {
                 c.did_we_daemonize = possibly_become_daemon(&c.options);
-                write_pid(c.options.writepid);
+                write_pid_file(c.options.writepid, c.options.chroot_dir);
             }
 
 #ifdef ENABLE_MANAGEMENT
-- 
2.27.0


