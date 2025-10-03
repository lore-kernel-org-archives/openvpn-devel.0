From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Oct 2025 12:06:02 +0200
Message-Id: <20251003100602.375062-1-frank@...2641...>
In-Reply-To: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
References: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] platform: Do not assume uid_t/gid_t are
 signed
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
Cc: MaxF <max@...2606...>

uid_t/gid_t are int on many platform but unsigned
on at least Linux. So rewrite the code in a way that
does not make any assumptions about the types. Mainly
this means storing the information whether the value
is valid in a separate bool and not in the value
itself.

Note that this changes the return behavior of
platform_{user,group}_get but a review of the
callers determined that this makes no actual
difference.

Change-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1206
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1206
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5a41a0f..1cb5c63 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1847,25 +1847,26 @@
 static bool
 man_verify_unix_peer_uid_gid(struct management *man, const socket_descriptor_t sd)
 {
-    if (socket_defined(sd) && (man->settings.client_uid != -1 || man->settings.client_gid != -1))
+    if (socket_defined(sd) && (man->settings.user.user_valid || man->settings.group.group_valid))
     {
         static const char err_prefix[] =
             "MANAGEMENT: unix domain socket client connection rejected --";
-        int uid, gid;
+        uid_t uid;
+        gid_t gid;
         if (unix_socket_get_peer_uid_gid(man->connection.sd_cli, &uid, &gid))
         {
-            if (man->settings.client_uid != -1 && man->settings.client_uid != uid)
+            if (man->settings.user.user_valid && man->settings.user.uid != uid)
             {
                 msg(D_MANAGEMENT,
                     "%s UID of socket peer (%d) doesn't match required value (%d) as given by --management-client-user",
-                    err_prefix, uid, man->settings.client_uid);
+                    err_prefix, uid, man->settings.user.uid);
                 return false;
             }
-            if (man->settings.client_gid != -1 && man->settings.client_gid != gid)
+            if (man->settings.group.group_valid && man->settings.group.gid != gid)
             {
                 msg(D_MANAGEMENT,
                     "%s GID of socket peer (%d) doesn't match required value (%d) as given by --management-client-group",
-                    err_prefix, gid, man->settings.client_gid);
+                    err_prefix, gid, man->settings.group.gid);
                 return false;
             }
         }
@@ -2542,8 +2543,6 @@
         CLEAR(*ms);
 
         ms->flags = flags;
-        ms->client_uid = -1;
-        ms->client_gid = -1;
 
         /*
          * Get username/password
@@ -2553,27 +2552,21 @@
             get_user_pass(&ms->up, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
         }
 
+#if UNIX_SOCK_SUPPORT
         /*
          * lookup client UID/GID if specified
          */
         if (client_user)
         {
-            struct platform_state_user s;
-            platform_user_get(client_user, &s);
-            ms->client_uid = platform_state_user_uid(&s);
-            msg(D_MANAGEMENT, "MANAGEMENT: client_uid=%d", ms->client_uid);
-            ASSERT(ms->client_uid >= 0);
+            ASSERT(platform_user_get(client_user, &ms->user));
+            msg(D_MANAGEMENT, "MANAGEMENT: client_uid=%d", ms->user.uid);
         }
         if (client_group)
         {
-            struct platform_state_group s;
-            platform_group_get(client_group, &s);
-            ms->client_gid = platform_state_group_gid(&s);
-            msg(D_MANAGEMENT, "MANAGEMENT: client_gid=%d", ms->client_gid);
-            ASSERT(ms->client_gid >= 0);
+            ASSERT(platform_group_get(client_group, &ms->group));
+            msg(D_MANAGEMENT, "MANAGEMENT: client_gid=%d", ms->group.gid);
         }
 
-#if UNIX_SOCK_SUPPORT
         if (ms->flags & MF_UNIX_SOCK)
         {
             sockaddr_unix_init(&ms->local_unix, addr);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index bff96d3..a31eb06 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -242,14 +242,14 @@
     struct addrinfo *local;
 #if UNIX_SOCK_SUPPORT
     struct sockaddr_un local_unix;
+    struct platform_state_user user;
+    struct platform_state_group group;
 #endif
     bool management_over_tunnel;
     struct user_pass up;
     int log_history_cache;
     int echo_buffer_size;
     int state_buffer_size;
-    int client_uid;
-    int client_gid;
 
 /* flags for handling the management interface "signal" command */
 #define MANSIG_IGNORE_USR1_HUP  (1u << 0)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 880d14e..a1ffdaf 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -39,7 +39,7 @@
 
 #include "platform.h"
 
-#if _WIN32
+#ifdef _WIN32
 #include <direct.h>
 #endif
 
@@ -79,12 +79,10 @@
 bool
 platform_user_get(const char *username, struct platform_state_user *state)
 {
-    bool ret = false;
     CLEAR(*state);
     if (username)
     {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-        state->uid = -1;
         const struct passwd *pw = getpwnam(username);
         if (!pw)
         {
@@ -93,23 +91,23 @@
         else
         {
             state->uid = pw->pw_uid;
+            state->user_valid = true;
         }
         state->username = username;
-        ret = true;
 #else /* if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID) */
         msg(M_FATAL,
             "cannot get UID for user %s -- platform lacks getpwname() or setuid() system calls",
             username);
 #endif
     }
-    return ret;
+    return state->user_valid;
 }
 
 static void
 platform_user_set(const struct platform_state_user *state)
 {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-    if (state->username && state->uid >= 0)
+    if (state->username && state->user_valid)
     {
         if (setuid(state->uid))
         {
@@ -125,12 +123,10 @@
 bool
 platform_group_get(const char *groupname, struct platform_state_group *state)
 {
-    bool ret = false;
     CLEAR(*state);
     if (groupname)
     {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-        state->gid = -1;
         const struct group *gr = getgrnam(groupname);
         if (!gr)
         {
@@ -139,23 +135,23 @@
         else
         {
             state->gid = gr->gr_gid;
+            state->group_valid = true;
         }
         state->groupname = groupname;
-        ret = true;
 #else /* if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID) */
         msg(M_FATAL,
             "cannot get GID for group %s -- platform lacks getgrnam() or setgid() system calls",
             groupname);
 #endif
     }
-    return ret;
+    return state->group_valid;
 }
 
 static void
 platform_group_set(const struct platform_state_group *state)
 {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-    if (state->groupname && state->gid >= 0)
+    if (state->groupname && state->group_valid)
     {
         if (setgid(state->gid))
         {
@@ -237,13 +233,13 @@
      * new_uid/new_gid defaults to -1, which will not make
      * libcap-ng change the UID/GID unless configured
      */
-    if (group_state->groupname && group_state->gid >= 0)
+    if (group_state->groupname && group_state->group_valid)
     {
-        new_gid = group_state->gid;
+        new_gid = (int)group_state->gid;
     }
-    if (user_state->username && user_state->uid >= 0)
+    if (user_state->username && user_state->user_valid)
     {
-        new_uid = user_state->uid;
+        new_uid = (int)user_state->uid;
     }
 
     /* Prepare capabilities before dropping UID/GID */
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index f1a2b01..0cb25f5 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -64,9 +64,8 @@
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
     const char *username;
     uid_t uid;
-#else
-    int dummy;
 #endif
+    bool user_valid;
 };
 
 /* Get/Set GID of process */
@@ -76,9 +75,8 @@
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
     const char *groupname;
     gid_t gid;
-#else
-    int dummy;
 #endif
+    bool group_valid;
 };
 
 bool platform_user_get(const char *username, struct platform_state_user *state);
@@ -89,28 +87,6 @@
                              const struct platform_state_group *group_state, struct context *c);
 
 
-/*
- * Extract UID or GID
- */
-
-static inline int
-platform_state_user_uid(const struct platform_state_user *s)
-{
-#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-    return s->uid;
-#endif
-    return -1;
-}
-
-static inline int
-platform_state_group_gid(const struct platform_state_group *s)
-{
-#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-    return s->gid;
-#endif
-    return -1;
-}
-
 void platform_chroot(const char *path);
 
 void platform_nice(int niceval);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5fcf820..f71d891 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3082,7 +3082,7 @@
 }
 
 bool
-unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *gid)
+unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, uid_t *uid, gid_t *gid)
 {
 #ifdef HAVE_GETPEEREID
     uid_t u;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e45981f..2c79a11 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -371,7 +371,7 @@
 
 void socket_delete_unix(const struct sockaddr_un *local);
 
-bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *gid);
+bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, uid_t *uid, gid_t *gid);
 
 #endif /* if UNIX_SOCK_SUPPORT */
 

