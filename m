From: selva.nair@...277...
Date: Mon,  6 Mar 2023 00:33:45 -0500
Message-Id: <20230306053346.796992-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Do not save pointer to 'struct passwd'
 returned by getpwnam etc.
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

From: Selva Nair <selva.nair@...277...>

- This pointer is to a static area which can change on further
  calls to getpwnam, getpwuid etc.
  Same with struct group returned by getgrnam.

  As the only field later referred to is uid or gid, fix
  by saving them instead.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Though we call getpwnam()/getgrnam() more than once with potentially
different user/group names, this has not yet led to a bug because
only in one place the state is persisted, and that call happens later.
But looks like a bug waiting to happen.

 src/openvpn/platform.c | 36 +++++++++++++++++++++++-------------
 src/openvpn/platform.h | 14 ++++----------
 src/openvpn/tun.c      |  4 ++--
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 580c4cb8..f6b856f3 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -85,11 +85,16 @@ platform_user_get(const char *username, struct platform_state_user *state)
     if (username)
     {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-        state->pw = getpwnam(username);
-        if (!state->pw)
+        state->uid = -1;
+        const struct passwd *pw = getpwnam(username);
+        if (!pw)
         {
             msg(M_ERR, "failed to find UID for user %s", username);
         }
+        else
+        {
+            state->uid = pw->pw_uid;
+        }
         state->username = username;
         ret = true;
 #else  /* if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID) */
@@ -103,9 +108,9 @@ static void
 platform_user_set(const struct platform_state_user *state)
 {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-    if (state->username && state->pw)
+    if (state->username && state->uid >= 0)
     {
-        if (setuid(state->pw->pw_uid))
+        if (setuid(state->uid))
         {
             msg(M_ERR, "setuid('%s') failed", state->username);
         }
@@ -124,11 +129,16 @@ platform_group_get(const char *groupname, struct platform_state_group *state)
     if (groupname)
     {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-        state->gr = getgrnam(groupname);
-        if (!state->gr)
+        state->gid = -1;
+        const struct group *gr = getgrnam(groupname);
+        if (!gr)
         {
             msg(M_ERR, "failed to find GID for group %s", groupname);
         }
+        else
+        {
+            state->gid = gr->gr_gid;
+        }
         state->groupname = groupname;
         ret = true;
 #else  /* if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID) */
@@ -142,9 +152,9 @@ static void
 platform_group_set(const struct platform_state_group *state)
 {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-    if (state->groupname && state->gr)
+    if (state->groupname && state->gid >= 0)
     {
-        if (setgid(state->gr->gr_gid))
+        if (setgid(state->gid))
         {
             msg(M_ERR, "setgid('%s') failed", state->groupname);
         }
@@ -152,7 +162,7 @@ platform_group_set(const struct platform_state_group *state)
 #ifdef HAVE_SETGROUPS
         {
             gid_t gr_list[1];
-            gr_list[0] = state->gr->gr_gid;
+            gr_list[0] = state->gid;
             if (setgroups(1, gr_list))
             {
                 msg(M_ERR, "setgroups('%s') failed", state->groupname);
@@ -225,13 +235,13 @@ platform_user_group_set(const struct platform_state_user *user_state,
      * new_uid/new_gid defaults to -1, which will not make
      * libcap-ng change the UID/GID unless configured
      */
-    if (group_state->groupname && group_state->gr)
+    if (group_state->groupname && group_state->gid >= 0)
     {
-        new_gid = group_state->gr->gr_gid;
+        new_gid = group_state->gid;
     }
-    if (user_state->username && user_state->pw)
+    if (user_state->username && user_state->uid >= 0)
     {
-        new_uid = user_state->pw->pw_uid;
+        new_uid = user_state->uid;
     }
 
     /* Prepare capabilities before dropping UID/GID */
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index a35a571c..d8dad74b 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -63,7 +63,7 @@ struct context;
 struct platform_state_user {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
     const char *username;
-    struct passwd *pw;
+    uid_t uid;
 #else
     int dummy;
 #endif
@@ -74,7 +74,7 @@ struct platform_state_user {
 struct platform_state_group {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
     const char *groupname;
-    struct group *gr;
+    gid_t gid;
 #else
     int dummy;
 #endif
@@ -97,10 +97,7 @@ static inline int
 platform_state_user_uid(const struct platform_state_user *s)
 {
 #if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
-    if (s->pw)
-    {
-        return s->pw->pw_uid;
-    }
+    return s->uid;
 #endif
     return -1;
 }
@@ -109,10 +106,7 @@ static inline int
 platform_state_group_gid(const struct platform_state_group *s)
 {
 #if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
-    if (s->gr)
-    {
-        return s->gr->gr_gid;
-    }
+    return s->gid;
 #endif
     return -1;
 }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a1414d23..87033277 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2242,7 +2242,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
         {
             msg(M_ERR, "Cannot get user entry for %s", username);
         }
-        else if (ioctl(tt->fd, TUNSETOWNER, platform_state_user.pw->pw_uid) < 0)
+        else if (ioctl(tt->fd, TUNSETOWNER, platform_state_user.uid) < 0)
         {
             msg(M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", username, dev);
         }
@@ -2255,7 +2255,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
         {
             msg(M_ERR, "Cannot get group entry for %s", groupname);
         }
-        else if (ioctl(tt->fd, TUNSETGROUP, platform_state_group.gr->gr_gid) < 0)
+        else if (ioctl(tt->fd, TUNSETGROUP, platform_state_group.gid) < 0)
         {
             msg(M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev);
         }
-- 
2.34.1


