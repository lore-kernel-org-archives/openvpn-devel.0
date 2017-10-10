From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:18 +0200
Message-Id: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 01/13] snwprintf() => _snwprintf()
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

From: Simon Rozman <simon@...2293...>

---
 src/openvpnserv/interactive.c | 12 ++++++------
 src/openvpnserv/validate.c    |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index fe9c7d6..9d473e4 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -402,8 +402,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
 
         if (!CheckOption(workdir, 2, argv_tmp, &settings))
         {
-            snwprintf(buf, _countof(buf), msg1, argv[0], workdir,
-                      settings.ovpn_admin_group);
+            _snwprintf(buf, _countof(buf), msg1, argv[0], workdir,
+                       settings.ovpn_admin_group);
             buf[_countof(buf) - 1] = L'\0';
             ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
         }
@@ -421,15 +421,15 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
         {
             if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
             {
-                snwprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
-                          settings.ovpn_admin_group);
+                _snwprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
+                           settings.ovpn_admin_group);
                 buf[_countof(buf) - 1] = L'\0';
                 ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
             else
             {
-                snwprintf(buf, _countof(buf), msg2, argv[i],
-                          settings.ovpn_admin_group);
+                _snwprintf(buf, _countof(buf), msg2, argv[i],
+                           settings.ovpn_admin_group);
                 buf[_countof(buf) - 1] = L'\0';
                 ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index f6a97e9..7a2d0e3 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -65,7 +65,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
     {
-        snwprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
+        _snwprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
         tmp[_countof(tmp)-1] = L'\0';
         config_file = tmp;
     }
-- 
2.9.0.windows.1


