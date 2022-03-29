From: Timo Rothenpieler <timo@...2669...>
Date: Tue, 29 Mar 2022 21:29:34 +0200
Message-Id: <20220329192934.1415-1-timo@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Retain CAP_NET_ADMIN when dropping
 privileges
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

---
This patch sits on top of the current dco branch, and will not apply to
latest master.

It solves the issue of dropping root privileges breaking dco and sitnl
due to missing NET_ADMIN capabilities.


 configure.ac           |  3 ++
 src/openvpn/init.c     | 22 +++++++++++++-
 src/openvpn/platform.c | 65 +++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/platform.h |  2 +-
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7199483a..220c63e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -710,6 +710,9 @@ if test -z "${LIBPAM_LIBS}"; then
 	)
 fi
 
+AC_CHECK_HEADERS([linux/capability.h sys/syscall.h sys/prctl.h],
+                 [AC_DEFINE(HAVE_LINUX_CAPABILITIES, 1, [Linux capability support available])])
+
 case "${with_mem_check}" in
 	valgrind)
 		AC_CHECK_HEADERS(
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8818ba6f..13c07ff0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1138,6 +1138,25 @@ possibly_become_daemon(const struct options *options)
     return ret;
 }
 
+/*
+ * Determine if we need to retain process capabilities. DCO and SITNL need it.
+ * Enforce it for DCO, but only try and soft-fail for SITNL to keep backwards compat.
+ */
+static int
+get_need_keep_caps(struct context *c)
+{
+    if (dco_enabled(&c->options))
+    {
+        return 1;
+    }
+
+#ifdef ENABLE_SITNL
+    return -1;
+#else
+    return 0;
+#endif
+}
+
 /*
  * Actually do UID/GID downgrade, chroot and SELinux context switching, if requested.
  */
@@ -1167,8 +1186,9 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
         {
             if (no_delay)
             {
+                int keep_caps = get_need_keep_caps(c);
                 platform_group_set(&c0->platform_state_group);
-                platform_user_set(&c0->platform_state_user);
+                platform_user_set(&c0->platform_state_user, keep_caps);
             }
             else if (c->first_time)
             {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 450f28ba..680ebb5f 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -43,6 +43,12 @@
 #include <direct.h>
 #endif
 
+#ifdef HAVE_LINUX_CAPABILITIES
+#include <linux/capability.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+#endif
+
 /* Redefine the top level directory of the filesystem
  * to restrict access to files for security */
 void
@@ -91,17 +97,74 @@ platform_user_get(const char *username, struct platform_state_user *state)
     return ret;
 }
 
+#ifdef HAVE_LINUX_CAPABILITIES
+#define SET_CAP_HELPER(data, set, cap) data[(cap)>>5].set |= 1<<((cap)&31)
+
+static bool
+do_keep_caps(bool prepare)
+{
+    struct __user_cap_header_struct cap_hdr = { _LINUX_CAPABILITY_VERSION_3 };
+    struct __user_cap_data_struct cap_data[_LINUX_CAPABILITY_U32S_3] = {};
+
+    if (syscall(SYS_capget, &cap_hdr, cap_data) < 0)
+    {
+        msg(M_NONFATAL | M_ERRNO, "failed getting capabilities");
+        return false;
+    }
+
+    if (prepare)
+    {
+        SET_CAP_HELPER(cap_data, permitted, CAP_NET_ADMIN);
+    }
+    else
+    {
+        SET_CAP_HELPER(cap_data, effective, CAP_NET_ADMIN);
+    }
+
+    if (syscall(SYS_capset, &cap_hdr, cap_data) < 0)
+    {
+        msg(M_NONFATAL | M_ERRNO, "failed setting %s capabilities", prepare ? "permitted" : "effective");
+        return false;
+    }
+
+    if (prepare && prctl(PR_SET_KEEPCAPS, 1) < 0)
+    {
+        msg(M_NONFATAL | M_ERRNO, "failed setting keepcaps");
+        return false;
+    }
+
+    return true;
+}
+#else
+static bool
+do_keep_caps(bool prepare)
+{
+    return false;
+}
+#endif
+
 void
-platform_user_set(const struct platform_state_user *state)
+platform_user_set(const struct platform_state_user *state, int keep_caps)
 {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
     if (state->username && state->pw)
     {
+        bool caps_prepared = keep_caps && do_keep_caps(true);
+
         if (setuid(state->pw->pw_uid))
         {
             msg(M_ERR, "setuid('%s') failed", state->username);
         }
         msg(M_INFO, "UID set to %s", state->username);
+
+        if (caps_prepared && do_keep_caps(false))
+        {
+            msg(M_INFO, "Capabilities retained");
+        }
+        else if (keep_caps > 0)
+        {
+            msg(M_FATAL, "Failed retaining capabilities");
+        }
     }
 #endif
 }
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index a3eec298..ef06da93 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -79,7 +79,7 @@ struct platform_state_group {
 
 bool platform_user_get(const char *username, struct platform_state_user *state);
 
-void platform_user_set(const struct platform_state_user *state);
+void platform_user_set(const struct platform_state_user *state, int keep_caps);
 
 bool platform_group_get(const char *groupname, struct platform_state_group *state);
 
-- 
2.25.1


