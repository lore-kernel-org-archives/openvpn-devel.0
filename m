From: selva.nair@...277...
Date: Sun,  8 Jan 2017 15:00:58 -0500
Message-Id: <1483905658-25267-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Fix user's group membership check in
	interactive service to work with domains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

Currently the username unqualified by the domain is used to validate
a user which fails for domain users. Instead compare the user's SID
with SIDs in the Administrators group and ovpn_admin_group.

This has the advantage that connection to a domain controller is not
required and will work even when user is logged in with cached credentials.

Limitations:
(i) Group membership is not checked recursively
(ii) Domain administrators will not be recognized as members of local
Administrators group.

Resolves Trac: #810

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/validate.c | 95 +++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 40 deletions(-)

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index c9c3855..98d868f 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -49,6 +49,8 @@ static const WCHAR *white_list[] =
     NULL                                /* last value */
 };
 
+static BOOL IsUserInGroup(PSID sid, const WCHAR *group_name);
+
 /*
  * Check workdir\fname is inside config_dir
  * The logic here is simple: we may reject some valid paths if ..\ is in any of the strings
@@ -152,16 +154,11 @@ GetBuiltinAdminGroupName(WCHAR *name, DWORD nlen)
 BOOL
 IsAuthorizedUser(SID *sid, settings_t *s)
 {
-    LOCALGROUP_USERS_INFO_0 *groups = NULL;
-    DWORD nread;
-    DWORD nmax;
-    WCHAR *tmp = NULL;
     const WCHAR *admin_group[2];
     WCHAR username[MAX_NAME];
     WCHAR domain[MAX_NAME];
     WCHAR sysadmin_group[MAX_NAME];
-    DWORD err, len = MAX_NAME;
-    int i;
+    DWORD len = MAX_NAME;
     BOOL ret = FALSE;
     SID_NAME_USE sid_type;
 
@@ -169,17 +166,9 @@ IsAuthorizedUser(SID *sid, settings_t *s)
     if (!LookupAccountSidW(NULL, sid, username, &len, domain, &len, &sid_type))
     {
         MsgToEventLog(M_SYSERR, TEXT("LookupAccountSid"));
-        goto out;
-    }
-
-    /* Get an array of groups the user is member of */
-    err = NetUserGetLocalGroups(NULL, username, 0, LG_INCLUDE_INDIRECT, (LPBYTE *) &groups,
-                                MAX_PREFERRED_LENGTH, &nread, &nmax);
-    if (err && err != ERROR_MORE_DATA)
-    {
-        SetLastError(err);
-        MsgToEventLog(M_SYSERR, TEXT("NetUserGetLocalGroups"));
-        goto out;
+        /* not fatal as this is now used only for logging */
+        username[0] = '\0';
+        domain[0] = '\0';
     }
 
     if (GetBuiltinAdminGroupName(sysadmin_group, _countof(sysadmin_group)))
@@ -193,40 +182,66 @@ IsAuthorizedUser(SID *sid, settings_t *s)
         admin_group[0] = SYSTEM_ADMIN_GROUP;
     }
 
-#ifdef UNICODE
     admin_group[1] = s->ovpn_admin_group;
-#else
-    tmp = NULL;
-    len = MultiByteToWideChar(CP_UTF8, 0, s->ovpn_admin_group, -1, NULL, 0);
-    if (len == 0 || (tmp = malloc(len*sizeof(WCHAR))) == NULL)
-    {
-        MsgToEventLog(M_SYSERR, TEXT("Failed to convert admin group name to WideChar"));
-        goto out;
-    }
-    MultiByteToWideChar(CP_UTF8, 0, s->ovpn_admin_group, -1, tmp, len);
-    admin_group[1] = tmp;
-#endif
 
-    /* Check if user's groups include any of the admin groups */
-    for (i = 0; i < nread; i++)
+    for (int i = 0; i < 2; ++i)
     {
-        if (wcscmp(groups[i].lgrui0_name, admin_group[0]) == 0
-            || wcscmp(groups[i].lgrui0_name, admin_group[1]) == 0
-            )
+        ret = IsUserInGroup(sid, admin_group[i]);
+        if (ret)
         {
-            MsgToEventLog(M_INFO, TEXT("Authorizing user %s by virtue of membership in group %s"),
-                          username, groups[i].lgrui0_name);
-            ret = TRUE;
-            break;
+            MsgToEventLog(M_INFO, TEXT("Authorizing user '%s@%s' by virtue of membership in group '%s'"),
+                          username, domain, admin_group[i]);
+            goto out;
         }
     }
 
 out:
-    if (groups)
+    return ret;
+}
+
+/**
+ * Check a user with specified sid is in a local group named group_name
+ *
+ * Using sid instead of username avoids reference to domains so that
+ * this could be completed without access to the Domain Controller.
+ *
+ * Returns true if the user is in the group, false otherwise.
+ */
+static BOOL
+IsUserInGroup(PSID sid, const WCHAR *group_name)
+{
+    BOOL ret = FALSE;
+    LOCALGROUP_MEMBERS_INFO_0 *groups;
+    DWORD_PTR resume = 0;
+    DWORD err, nread, nmax;
+    int nloop = 0; /* a counter used to not get stuck in the do .. while() */
+
+    do
     {
+        groups = NULL;
+        err = NetLocalGroupGetMembers(NULL, group_name, 0, (LPBYTE *) &groups,
+                                      MAX_PREFERRED_LENGTH, &nread, &nmax, &resume);
+        if (err && err != ERROR_MORE_DATA)
+        {
+            break;
+        }
+
+        /* If a match is already found, ret = TRUE, the loop is skipped */
+        for (int i = 0; i < nread && !ret; ++i)
+        {
+            ret = EqualSid(groups[i].lgrmi0_sid, sid);
+        }
+
         NetApiBufferFree(groups);
+
+    /* MSDN says the lookup should always iterate until err != ERROR_MORE_DATA */
+    } while (err == ERROR_MORE_DATA && nloop++ < 100);
+
+    if (err != NERR_Success && err != NERR_GroupNotFound)
+    {
+        SetLastError(err);
+        MsgToEventLog(M_SYSERR, TEXT("In NetLocalGroupGetMembers for group '%s'"), group_name);
     }
-    free(tmp);
 
     return ret;
 }
-- 
2.1.4


