From: selva.nair@...277...
Date: Sat, 14 Jan 2017 16:16:29 -0500
Message-Id: <1484428589-7882-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1483905658-25267-1-git-send-email-selva.nair@...277...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Fix user's group membership check in
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
a user which fails for domain users. Instead authorize the user

(i) if the built-in admin group or ovpn_admin group is in the process token
(ii) else if the user's SID is in the built-in admin or ovpn_admin groups

The second check is needed to recognize dynamic updates to group membership
on the local machine that will not be reflected in the token.

These checks do not require connection to a domain controller and will
work even when user is logged in with cached credentials.

Resolves Trac: #810

v2: include the token check as described above

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |   2 +-
 src/openvpnserv/validate.c    | 171 +++++++++++++++++++++++++++++++-----------
 src/openvpnserv/validate.h    |   2 +-
 3 files changed, 130 insertions(+), 45 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index dbe2b9b..9436fba 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1475,7 +1475,7 @@ RunOpenvpn(LPVOID p)
     }
 
     /* Check user is authorized or options are white-listed */
-    if (!IsAuthorizedUser(ovpn_user->User.Sid, &settings)
+    if (!IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group)
         && !ValidateOptions(pipe, sud.directory, sud.options))
     {
         goto out;
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index c9c3855..894c51b 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -49,6 +49,9 @@ static const WCHAR *white_list[] =
     NULL                                /* last value */
 };
 
+static BOOL IsUserInGroup(PSID sid, const PTOKEN_GROUPS groups, const WCHAR *group_name);
+static PTOKEN_GROUPS GetTokenGroups(const HANDLE token);
+
 /*
  * Check workdir\fname is inside config_dir
  * The logic here is simple: we may reject some valid paths if ..\ is in any of the strings
@@ -147,21 +150,16 @@ GetBuiltinAdminGroupName(WCHAR *name, DWORD nlen)
 
 /*
  * Check whether user is a member of Administrators group or
- * the group specified in s->ovpn_admin_group
+ * the group specified in ovpn_admin_group
  */
 BOOL
-IsAuthorizedUser(SID *sid, settings_t *s)
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group)
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
 
@@ -169,17 +167,9 @@ IsAuthorizedUser(SID *sid, settings_t *s)
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
@@ -192,41 +182,136 @@ IsAuthorizedUser(SID *sid, settings_t *s)
         /* use the default value */
         admin_group[0] = SYSTEM_ADMIN_GROUP;
     }
+    admin_group[1] = ovpn_admin_group;
 
-#ifdef UNICODE
-    admin_group[1] = s->ovpn_admin_group;
-#else
-    tmp = NULL;
-    len = MultiByteToWideChar(CP_UTF8, 0, s->ovpn_admin_group, -1, NULL, 0);
-    if (len == 0 || (tmp = malloc(len*sizeof(WCHAR))) == NULL)
+    PTOKEN_GROUPS token_groups = GetTokenGroups(token);
+    for (int i = 0; i < 2; ++i)
     {
-        MsgToEventLog(M_SYSERR, TEXT("Failed to convert admin group name to WideChar"));
-        goto out;
+        ret = IsUserInGroup(sid, token_groups, admin_group[i]);
+        if (ret)
+        {
+            MsgToEventLog(M_INFO, TEXT("Authorizing user '%s@%s' by virtue of membership in group '%s'"),
+                          username, domain, admin_group[i]);
+            goto out;
+        }
     }
-    MultiByteToWideChar(CP_UTF8, 0, s->ovpn_admin_group, -1, tmp, len);
-    admin_group[1] = tmp;
-#endif
 
-    /* Check if user's groups include any of the admin groups */
-    for (i = 0; i < nread; i++)
+out:
+    free(token_groups);
+    return ret;
+}
+
+/**
+ * Get a list of groups in token.
+ * Returns a pointer to TOKEN_GROUPS struct or NULL on error.
+ * The caller should free the returned pointer.
+ */
+static PTOKEN_GROUPS
+GetTokenGroups(const HANDLE token)
+{
+    PTOKEN_GROUPS groups = NULL;
+    DWORD buf_size = 0;
+
+    if (!GetTokenInformation(token, TokenGroups, groups, buf_size, &buf_size)
+        && GetLastError() == ERROR_INSUFFICIENT_BUFFER)
+    {
+        groups = malloc(buf_size);
+    }
+    if (!groups)
+    {
+        MsgToEventLog(M_SYSERR, L"GetTokenGroups");
+    }
+    else if (!GetTokenInformation(token, TokenGroups, groups, buf_size, &buf_size))
     {
-        if (wcscmp(groups[i].lgrui0_name, admin_group[0]) == 0
-            || wcscmp(groups[i].lgrui0_name, admin_group[1]) == 0
-            )
+        MsgToEventLog(M_SYSERR, L"GetTokenInformation");
+        free(groups);
+    }
+    return groups;
+}
+
+/*
+ * Find SID from name
+ *
+ * On input sid buffer should have space for at least sid_size bytes.
+ * Returns true on success, false on failure.
+ * Suggest: in caller allocate sid to hold SECURITY_MAX_SID_SIZE bytes
+ */
+static BOOL
+LookupSID(const WCHAR *name, PSID sid, DWORD sid_size)
+{
+    SID_NAME_USE su;
+    WCHAR domain[MAX_NAME];
+    DWORD dlen = _countof(domain);
+
+    if (!LookupAccountName(NULL, name, sid, &sid_size, domain, &dlen, &su))
+    {
+        return FALSE; /* not fatal as the group may not exist */
+    }
+    return TRUE;
+}
+
+/**
+ * User is in group if the token groups contain the SID of the group
+ * of if the user is a direct member of the group. The latter check
+ * catches dynamic changes in group membership in the local user
+ * database not reflected in the token.
+ * If token_groups or sid is NULL the corresponding check is skipped.
+ *
+ * Using sid and list of groups in token avoids reference to domains so that
+ * this could be completed without access to a Domain Controller.
+ *
+ * Returns true if the user is in the group, false otherwise.
+ */
+static BOOL
+IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_groups, const WCHAR *group_name)
+{
+    BOOL ret = FALSE;
+    DWORD_PTR resume = 0;
+    DWORD err;
+    BYTE grp_sid[SECURITY_MAX_SID_SIZE];
+    int nloop = 0; /* a counter used to not get stuck in the do .. while() */
+
+    /* first check in the token groups */
+    if (token_groups && LookupSID(group_name, (PSID) grp_sid, _countof(grp_sid)))
+    {
+        for (DWORD i = 0; i < token_groups->GroupCount; ++i)
         {
-            MsgToEventLog(M_INFO, TEXT("Authorizing user %s by virtue of membership in group %s"),
-                          username, groups[i].lgrui0_name);
-            ret = TRUE;
-            break;
+            if (EqualSid((PSID) grp_sid, token_groups->Groups[i].Sid))
+            {
+                return TRUE;
+            }
         }
     }
 
-out:
-    if (groups)
+    /* check user's SID is a member of the group */
+    if (!sid)
+    {
+        return FALSE;
+    }
+    do
+    {
+        DWORD nread, nmax;
+        LOCALGROUP_MEMBERS_INFO_0 *members = NULL;
+        err = NetLocalGroupGetMembers(NULL, group_name, 0, (LPBYTE *) &members,
+                                      MAX_PREFERRED_LENGTH, &nread, &nmax, &resume);
+        if ((err != NERR_Success && err != ERROR_MORE_DATA))
+        {
+            break;
+        }
+        /* If a match is already found, ret == TRUE and the loop is skipped */
+        for (int i = 0; i < nread && !ret; ++i)
+        {
+            ret = EqualSid(members[i].lgrmi0_sid, sid);
+        }
+        NetApiBufferFree(members);
+    /* MSDN says the lookup should always iterate until err != ERROR_MORE_DATA */
+    } while (err == ERROR_MORE_DATA && nloop++ < 100);
+
+    if (err != NERR_Success && err != NERR_GroupNotFound)
     {
-        NetApiBufferFree(groups);
+        SetLastError(err);
+        MsgToEventLog(M_SYSERR, TEXT("In NetLocalGroupGetMembers for group '%s'"), group_name);
     }
-    free(tmp);
 
     return ret;
 }
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index ece8704..033e0e4 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -34,7 +34,7 @@
 /* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin_group */
 
 BOOL
-IsAuthorizedUser(SID *sid, settings_t *s);
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group);
 
 BOOL
 CheckOption(const WCHAR *workdir, int narg, WCHAR *argv[], const settings_t *s);
-- 
2.1.4


