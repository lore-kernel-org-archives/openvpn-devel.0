From: selva.nair@...277...
Date: Mon,  6 Mar 2023 00:33:46 -0500
Message-Id: <20230306053346.796992-2-selva.nair@...277...>
In-Reply-To: <20230306053346.796992-1-selva.nair@...277...>
References: <20230306053346.796992-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Include supplementary groups when
 checking management-client-group
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

- When management-client-group is in use, allow access if any of
  the supplementary groups of the user matches the specified group.

  Currently only the effective gid of the peer socket is checked
  which is normally the primary group of user. As unprivileged users
  have no easy way of changing the effective gid of a process,
  group based access control is of very limited use without this change.

- Also accept if uid = 0 irrespective of the group.

Github: OpenVPN/openvpn#264

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac         |  2 +-
 src/openvpn/manage.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 67f680b2..979903a8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -659,7 +659,7 @@ AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups flock readv writev time gettimeofday \
-	setsid chdir \
+	setsid chdir getpwuid getgrent \
 	chsize ftruncate execve getpeereid basename dirname access \
 	epoll_create strsep \
 ])
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index db88e347..73dc7d57 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1771,6 +1771,42 @@ man_new_connection_post(struct management *man, const char *description)
 }
 
 #if UNIX_SOCK_SUPPORT
+/**
+ * Return true if user uid is a member of group gid.
+ * On error or lack of platform support, we return false.
+ */
+
+static bool
+is_user_in_group(uid_t uid, gid_t gid)
+{
+    bool ret = false;
+#if defined(HAVE_GETPWUID) && defined(HAVE_GETGRENT)
+    struct passwd *pw = getpwuid(uid);
+    if (!pw)
+    {
+        return ret;
+    }
+
+    struct group *gr = getgrent();
+    char **members = NULL;
+    while (gr)
+    {
+        if (gr->gr_gid == gid)
+        {
+            /* found the group -- check user is a member */
+            members = gr->gr_mem;
+            for (char *s = *members; s && !ret; s++)
+            {
+                ret = !strcmp(s, pw->pw_name);
+            }
+            break; /* out of the while loop */
+        }
+        gr = getgrent();
+    }
+#endif /* if defined(HAVE_GETPWUID) && defined(HAVE_GETGRENT) */
+    return ret;
+}
+
 static bool
 man_verify_unix_peer_uid_gid(struct management *man, const socket_descriptor_t sd)
 {
@@ -1780,13 +1816,18 @@ man_verify_unix_peer_uid_gid(struct management *man, const socket_descriptor_t s
         int uid, gid;
         if (unix_socket_get_peer_uid_gid(man->connection.sd_cli, &uid, &gid))
         {
+            if (uid == 0) /* accept if root */
+            {
+                return true;
+            }
             if (man->settings.client_uid != -1 && man->settings.client_uid != uid)
             {
                 msg(D_MANAGEMENT, "%s UID of socket peer (%d) doesn't match required value (%d) as given by --management-client-user",
                     err_prefix, uid, man->settings.client_uid);
                 return false;
             }
-            if (man->settings.client_gid != -1 && man->settings.client_gid != gid)
+            if (man->settings.client_gid != -1 && man->settings.client_gid != gid
+                && !is_user_in_group(uid, man->settings.client_gid))
             {
                 msg(D_MANAGEMENT, "%s GID of socket peer (%d) doesn't match required value (%d) as given by --management-client-group",
                     err_prefix, gid, man->settings.client_gid);
-- 
2.34.1


