From: Gert Doering <gert@...1296...>
Date: Tue, 15 Apr 2025 17:51:24 +0200
Message-ID: <20250415155131.12458-1-gert@...1296...>
In-Reply-To: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
References: <gerrit.1741780483000.I44d308301dfb7c22600d8632a553288f52b3068f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] win: allow OpenVPN service account to
 use any command-line options
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

From: Lev Stipakov <lev@...515...>

Since 2.7, OpenVPN service (used to start persistent connections)
runs under limited virtual service account NT SERVICE\OpenVPNService.

Since it should be able to use all command-line options
and cannot be made member of "OpenVPN Administrators" group,
it has to be handled separately.

Change-Id: I44d308301dfb7c22600d8632a553288f52b3068f
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/906
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 39b39aa..4a11e6c 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -130,6 +130,14 @@
     {
         goto out;
     }
+
+    error = GetRegString(key, L"ovpn_service_user", s->ovpn_service_user,
+                         sizeof(s->ovpn_service_user), OVPN_SERVICE_USER);
+    if (error != ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
     /* set process priority */
     if (!_wcsicmp(priority, L"IDLE_PRIORITY_CLASS"))
     {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c6963b3..871dc6a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2491,7 +2491,7 @@
      * OR user is authorized to run any config.
      */
     if (!ValidateOptions(pipe, sud.directory, sud.options, errmsg, _countof(errmsg))
-        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group))
+        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group, settings.ovpn_service_user))
     {
         ReturnError(pipe, ERROR_STARTUP_DATA, errmsg, 1, &exit_event);
         goto out;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 7112f26..cbe213b 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -66,6 +66,7 @@
     WCHAR ext_string[16];
     WCHAR log_dir[MAX_PATH];
     WCHAR ovpn_admin_group[MAX_NAME];
+    WCHAR ovpn_service_user[MAX_NAME];
     DWORD priority;
     BOOL append;
 } settings_t;
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 23d78af..9f176c0 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -140,12 +140,8 @@
     return b;
 }
 
-/*
- * Check whether user is a member of Administrators group or
- * the group specified in ovpn_admin_group
- */
 BOOL
-IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group)
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group, const WCHAR *ovpn_service_user)
 {
     const WCHAR *admin_group[2];
     WCHAR username[MAX_NAME];
@@ -164,6 +160,12 @@
         domain[0] = '\0';
     }
 
+    /* is this service account? */
+    if ((wcscmp(username, ovpn_service_user) == 0) && (wcscmp(domain, L"NT SERVICE") == 0))
+    {
+        return TRUE;
+    }
+
     if (GetBuiltinAdminGroupName(sysadmin_group, _countof(sysadmin_group)))
     {
         admin_group[0] = sysadmin_group;
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 61a0ad6..5cd6d16 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -29,11 +29,16 @@
 
 /* Authorized groups who can use any options and config locations */
 #define SYSTEM_ADMIN_GROUP L"Administrators"
-#define OVPN_ADMIN_GROUP L"OpenVPN Administrators"
-/* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin_group */
+#define OVPN_ADMIN_GROUP L"OpenVPN Administrators" /* may be set in HKLM\Software\OpenVPN\ovpn_admin_group */
+#define OVPN_SERVICE_USER L"OpenVPNService" /* may be set in HKLM\Software\OpenVPN\ovpn_service_user */
 
+/*
+ * Check whether user is a member of Administrators group or
+ * the group specified in ovpn_admin_group or
+ * OpenVPN Virtual Service Account user
+ */
 BOOL
-IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group);
+IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group, const WCHAR *ovpn_service_user);
 
 BOOL
 CheckOption(const WCHAR *workdir, int narg, WCHAR *argv[], const settings_t *s);

