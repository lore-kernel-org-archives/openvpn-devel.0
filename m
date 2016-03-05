From: Selva Nair <selva.nair@...277...>
Date: Sat,  5 Mar 2016 14:39:56 -0500
Message-Id: <1457206796-11863-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Handle localized Administrators group name
	in windows
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

Interactive service allows all configs and options if the user
is in "Administrators" group. This patch makes it work even if the
admin group is renamed or localized.

While at it, also remove two unused variables in validate.c.

Thanks to Leonardo Basilio <leobasilio@...277...> for testing
the patch on a localized version of windows and Samuli Seppänen
<samuli@...515...> for pointing out this issue.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/validate.c |   45 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index b5809b3..7458d75 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -57,8 +57,6 @@ static BOOL
 CheckConfigPath (const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
 {
     WCHAR tmp[MAX_PATH];
-    WCHAR widepath[MAX_PATH];
-    WCHAR relpath[MAX_PATH];
     const WCHAR *config_file = NULL;
     const WCHAR *config_dir = NULL;
 
@@ -112,6 +110,36 @@ OptionLookup (const WCHAR *name, const WCHAR *white_list[])
 }
 
 /*
+ * The Administrators group may be localized or renamed by admins.
+ * Get the local name of the group using the SID.
+ */
+static BOOL
+GetBuiltinAdminGroupName (WCHAR *name, DWORD nlen)
+{
+    BOOL b = FALSE;
+    PSID admin_sid = NULL;
+    DWORD sid_size = SECURITY_MAX_SID_SIZE;
+    SID_NAME_USE snu;
+
+    WCHAR domain[MAX_NAME];
+    DWORD dlen = _countof(domain);
+
+    admin_sid = malloc(sid_size);
+    if (!admin_sid)
+        return FALSE;
+
+    b = CreateWellKnownSid(WinBuiltinAdministratorsSid, NULL, admin_sid,  &sid_size);
+    if(b)
+    {
+        b = LookupAccountSidW(NULL, admin_sid, name, &nlen, domain, &dlen, &snu);
+    }
+
+    free (admin_sid);
+
+    return b;
+}
+
+/*
  * Check whether user is a member of Administrators group or
  * the group specified in s->ovpn_admin_group
  */
@@ -125,6 +153,7 @@ IsAuthorizedUser (SID *sid, settings_t *s)
     const WCHAR *admin_group[2];
     WCHAR username[MAX_NAME];
     WCHAR domain[MAX_NAME];
+    WCHAR sysadmin_group[MAX_NAME];
     DWORD err, len = MAX_NAME;
     int i;
     BOOL ret = FALSE;
@@ -147,7 +176,17 @@ IsAuthorizedUser (SID *sid, settings_t *s)
         goto out;
     }
 
-    admin_group[0] = SYSTEM_ADMIN_GROUP;
+    if (GetBuiltinAdminGroupName(sysadmin_group, _countof(sysadmin_group)))
+    {
+        admin_group[0] = sysadmin_group;
+    }
+    else
+    {
+        MsgToEventLog (M_SYSERR, TEXT("Failed to get the name of Administrators group. Using the default."));
+        /* use the default value */
+        admin_group[0] = SYSTEM_ADMIN_GROUP;
+    }
+
 #ifdef UNICODE
     admin_group[1] = s->ovpn_admin_group;
 #else
-- 
1.7.10.4


