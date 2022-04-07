From: Timo Rothenpieler <timo@...2669...>
Date: Thu,  7 Apr 2022 20:40:24 +0200
Message-Id: <20220407184023.249-1-timo@...2669...>
In-Reply-To: <20220330205536.139-1-timo@...2669...>
References: <20220330205536.139-1-timo@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] platform: Retain CAP_NET_ADMIN when
 dropping privileges
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
Cc: Timo Rothenpieler <timo@...2669...>, David Sommerseth <davids@...515...>

On Linux, when dropping privileges, interaction with
the network configuration, such as tearing down routes
or ovpn-dco interfaces will fail when --user/--group are
used.

This patch sets the CAP_NET_ADMIN capability, which grants
the needed privileges during the lifetime of the OpenVPN
process when dropping root privileges.

Signed-off-by: Timo Rothenpieler <timo@...2669...>
Reviewed-By: David Sommerseth <davids@...515...>
---
 configure.ac                              |  19 ++++
 distro/systemd/openvpn-client@...2221... |   2 +-
 distro/systemd/openvpn-server@...2221... |   2 +-
 src/openvpn/init.c                        |  30 ++++++-
 src/openvpn/platform.c                    | 105 +++++++++++++++++++++-
 src/openvpn/platform.h                    |   7 +-
 6 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 85921ddb..d2eb3426 100644
--- a/configure.ac
+++ b/configure.ac
@@ -794,6 +794,25 @@ dnl
 	esac
 fi
 
+dnl
+dnl Depend on libcap-ng on Linux
+dnl
+case "$host" in
+	*-*-linux*)
+		PKG_CHECK_MODULES([LIBCAPNG],
+				  [libcap-ng],
+				  [],
+				  [AC_MSG_ERROR([libcap-ng package not found. Is the development package and pkg-config installed?])]
+		)
+		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])
+
+		CFLAGS="${CFLAGS} ${LIBCAPNG_CFALGS}"
+		LIBS="${LIBS} ${LIBCAPNG_LIBS}"
+		AC_DEFINE(HAVE_LIBCAPNG, 1, [Enable libcap-ng support])
+	;;
+esac
+
+
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index cbcef653..159fb4dc 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -11,7 +11,7 @@ Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index d1cc72cb..6e8e7d94 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -11,7 +11,7 @@ Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8818ba6f..0a1b00ca 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1138,6 +1138,30 @@ possibly_become_daemon(const struct options *options)
     return ret;
 }
 
+/*
+ * Determine if we need to retain process capabilities. DCO and SITNL need it.
+ * Enforce it for DCO, but only try and soft-fail for SITNL to keep backwards compat.
+ *
+ * Returns the tri-state expected by platform_user_group_set.
+ * -1: try to keep caps, but continue if impossible
+ *  0: don't keep caps
+ *  1: keep caps, fail hard if impossible
+ */
+static int
+need_keep_caps(struct context *c)
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
@@ -1167,8 +1191,10 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
         {
             if (no_delay)
             {
-                platform_group_set(&c0->platform_state_group);
-                platform_user_set(&c0->platform_state_user);
+                int keep_caps = need_keep_caps(c);
+                platform_user_group_set(&c0->platform_state_user,
+                                        &c0->platform_state_group,
+                                        keep_caps);
             }
             else if (c->first_time)
             {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 450f28ba..1e321369 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -43,6 +43,11 @@
 #include <direct.h>
 #endif
 
+#ifdef HAVE_LIBCAPNG
+#include <cap-ng.h>
+#include <sys/prctl.h>
+#endif
+
 /* Redefine the top level directory of the filesystem
  * to restrict access to files for security */
 void
@@ -91,7 +96,7 @@ platform_user_get(const char *username, struct platform_state_user *state)
     return ret;
 }
 
-void
+static void
 platform_user_set(const struct platform_state_user *state)
 {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
@@ -130,7 +135,7 @@ platform_group_get(const char *groupname, struct platform_state_group *state)
     return ret;
 }
 
-void
+static void
 platform_group_set(const struct platform_state_group *state)
 {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
@@ -155,6 +160,102 @@ platform_group_set(const struct platform_state_group *state)
 #endif
 }
 
+/* Set user and group, retaining neccesary capabilities required by the platform.
+ *
+ * The keep_caps argument has 3 possible states:
+ *  >0: Retain capabilities, and fail hard on failure to do so.
+ * ==0: Don't attempt to retain any capabilities, just sitch user/group.
+ *  <0: Try to retain capabilities, but continue on failure.
+ */
+void platform_user_group_set(const struct platform_state_user *user_state,
+                             const struct platform_state_group *group_state,
+                             int keep_caps)
+{
+    unsigned int err_flags = (keep_caps > 0) ? M_FATAL : M_NONFATAL;
+#ifdef HAVE_LIBCAPNG
+    int new_gid = -1, new_uid = -1;
+    int res;
+
+    if (keep_caps == 0)
+    {
+        goto fallback;
+    }
+
+    /*
+     * new_uid/new_gid defaults to -1, which will not make
+     * libcap-ng change the UID/GID unless configured
+     */
+    if (group_state->groupname && group_state->gr)
+    {
+        new_gid = group_state->gr->gr_gid;
+    }
+    if (user_state->username && user_state->pw)
+    {
+        new_uid = user_state->pw->pw_uid;
+    }
+
+    /* Prepare capabilities before dropping UID/GID */
+    capng_clear(CAPNG_SELECT_BOTH);
+    res = capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, CAP_NET_ADMIN);
+    if (res < 0)
+    {
+        msg(err_flags, "capng_update(CAP_NET_ADMIN) failed: %d", res);
+        goto fallback;
+    }
+
+    /* Change to new UID/GID.
+     * capng_change_id() internally calls capng_apply() to apply prepared capabilities.
+     */
+    res = capng_change_id(new_uid, new_gid, CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING);
+    if (res == -4 || res == -6)
+    {
+        /* -4 and -6 mean failure of setuid/gid respectively.
+           There is no point for us to continue if those failed. */
+        msg(M_ERR, "capng_change_id('%s','%s') failed: %d",
+            user_state->username, group_state->groupname, res);
+    }
+    else if (res < 0)
+    {
+        if (res == -3)
+        {
+            msg(M_NONFATAL, "Following error likely due to missing capability CAP_SETPCAP.");
+        }
+        msg(err_flags | M_ERRNO, "capng_change_id('%s','%s') failed retaining capabilities: %d",
+            user_state->username, group_state->groupname, res);
+        goto fallback;
+    }
+
+    if (new_uid >= 0)
+    {
+         msg(M_INFO, "UID set to %s", user_state->username);
+    }
+    if (new_gid >= 0)
+    {
+         msg(M_INFO, "GID set to %s", group_state->groupname);
+    }
+
+    msg(M_INFO, "Capabilities retained: CAP_NET_ADMIN");
+
+    return;
+fallback:
+    /* capng_change_id() can leave this flag clobbered on failure
+     * This is working around a bug in libcap-ng, which can leave the flag set
+     * on failure: https://github.com/stevegrubb/libcap-ng/issues/33 */
+    if (prctl(PR_GET_KEEPCAPS) && prctl(PR_SET_KEEPCAPS, 0) < 0)
+    {
+        msg(M_ERR, "Clearing KEEPCAPS flag failed");
+    }
+#endif  /* HAVE_LIBCAPNG */
+
+    if (keep_caps)
+    {
+        msg(err_flags, "Unable to retain capabilities");
+    }
+
+    platform_group_set(group_state);
+    platform_user_set(user_state);
+}
+
 /* Change process priority */
 void
 platform_nice(int niceval)
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index a3eec298..19187d3a 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -79,11 +79,12 @@ struct platform_state_group {
 
 bool platform_user_get(const char *username, struct platform_state_user *state);
 
-void platform_user_set(const struct platform_state_user *state);
-
 bool platform_group_get(const char *groupname, struct platform_state_group *state);
 
-void platform_group_set(const struct platform_state_group *state);
+void platform_user_group_set(const struct platform_state_user *user_state,
+                             const struct platform_state_group *group_state,
+                             int keep_caps);
+
 
 /*
  * Extract UID or GID
-- 
2.25.1


