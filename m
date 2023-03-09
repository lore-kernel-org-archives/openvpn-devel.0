From: Antonio Quartulli <a@...2181...>
Date: Thu,  9 Mar 2023 01:52:08 +0100
Message-Id: <20230309005208.29704-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: print version to log if available
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
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>, Kristof Provost <kprovost@...2661...>

In order to provide better support in case of troubleshooting issues,
it's important to know what exact DCO version is loaded on the user
system.

Therefore print the DCO version during bootup.

For Windows and FreeBSD we currently implement a placeholder printing 'v0'.
This should be improved with a follow-up patch.

For Linux we directly fetch the module version from /sys and print
something like:

	DCO version: 0.1.20230206-15-g580608ec7c59

Cc: Lev Stipakov <lev@...515...>
Cc: Kristof Provost <kprovost@...2661...>
Change-Id: Ie1f6fa5d12a473d353d84fd119c2430b638e8bcd
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.h         | 15 +++++++++++++++
 src/openvpn/dco_freebsd.c |  6 ++++++
 src/openvpn/dco_linux.c   | 30 ++++++++++++++++++++++++++++++
 src/openvpn/dco_win.c     |  6 ++++++
 src/openvpn/openvpn.c     |  2 ++
 src/openvpn/options.c     | 11 +++++++++++
 src/openvpn/options.h     |  2 ++
 7 files changed, 72 insertions(+)

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 2fe671bf..96d95c21 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -58,6 +58,15 @@ struct tuntap;
  */
 bool dco_available(int msglevel);
 
+
+/**
+ * Return a human readable string representing the DCO version
+ *
+ * @param gc    the garbage collector to use for any dynamic allocation
+ * @return      a pointer to the string (allocated via gc) containing the string
+ */
+const char *dco_version_string(struct gc_arena *gc);
+
 /**
  * Check whether the options struct has any option that is not supported by
  * our current dco implementation. If so print a warning at warning level
@@ -250,6 +259,12 @@ dco_available(int msglevel)
     return false;
 }
 
+static inline const char *
+dco_version_string(struct gc_arena *gc)
+{
+    return "not-compiled";
+}
+
 static inline bool
 dco_check_option(int msglevel, const struct options *o)
 {
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 92de5f04..cbd2ce20 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -614,6 +614,12 @@ out:
     return available;
 }
 
+const char *
+dco_version_string(struct gc_arena *gc)
+{
+    return "v0";
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 308abfc4..c9cd9df1 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -841,9 +841,39 @@ dco_available(int msglevel)
             "Note: Kernel support for ovpn-dco missing, disabling data channel offload.");
         return false;
     }
+
     return true;
 }
 
+const char
+*dco_version_string(struct gc_arena *gc)
+{
+    struct buffer out = alloc_buf_gc(256, gc);
+    FILE *fp = fopen("/sys/module/ovpn_dco_v2/version", "r");
+    if (!fp)
+    {
+        buf_printf(&out, "N/A");
+        goto out;
+    }
+
+    if (!fgets((char *)buf_bptr(&out), out.capacity - 1, fp))
+    {
+        buf_printf(&out, "ERR");
+        goto out;
+    }
+
+    /* remove potential newline at the end of the string */
+    char *str = (char *)buf_bptr(&out);
+    char *nl = strchr(str, '\n');
+    if (nl)
+    {
+        *nl = '\0';
+    }
+
+out:
+    return (char *)out.data;
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a805c2a0..26463b38 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -385,6 +385,12 @@ dco_available(int msglevel)
     return false;
 }
 
+const char *
+dco_version_string(struct gc_arena *gc)
+{
+    return "v0";
+}
+
 int
 dco_do_read(dco_context_t *dco)
 {
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index cba58276..1aaddcdf 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -262,6 +262,8 @@ openvpn_main(int argc, char *argv[])
 #endif
             show_library_versions(M_INFO);
 
+            show_dco_version(M_INFO);
+
             /* misc stuff */
             pre_setup(&c.options);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ce7bd0a7..8f0e2194 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4816,6 +4816,16 @@ show_windows_version(const unsigned int flags)
 }
 #endif
 
+void
+show_dco_version(const unsigned int flags)
+{
+#ifdef ENABLE_DCO
+    struct gc_arena gc = gc_new();
+    msg(flags, "DCO version: %s", dco_version_string(&gc));
+    gc_free(&gc);
+#endif
+}
+
 void
 show_library_versions(const unsigned int flags)
 {
@@ -4839,6 +4849,7 @@ usage_version(void)
 #ifdef _WIN32
     show_windows_version( M_INFO|M_NOPREFIX );
 #endif
+    show_dco_version(M_INFO | M_NOPREFIX);
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
     msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7df717f7..2f25f5d0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -796,6 +796,8 @@ void show_windows_version(const unsigned int flags);
 
 #endif
 
+void show_dco_version(const unsigned int flags);
+
 void init_options(struct options *o, const bool init_gc);
 
 void uninit_options(struct options *o);
-- 
2.39.2


