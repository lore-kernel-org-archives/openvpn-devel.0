From: Selva Nair <selva.nair@...277...>
Date: Wed, 30 Nov 2016 16:51:36 -0500
Message-Id: <1480542696-7123-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Do not restart dns client service as a part
	of --register-dns processing
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

As reported and discussed on Trac #775, restarting dns service has
unwanted side effects when there are dependent services. And it
appears unnecessary to restart this service to get DNS registered
on Windows.

Resolve by removing two actions from --register-dns:
'net stop dnscache' and 'net start dnscache' run through the service
or directly.

Trac: #775
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/tun.c             | 18 ++----------------
 src/openvpnserv/interactive.c |  8 +-------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 560b1a8..572e168 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4597,23 +4597,9 @@ ipconfig_register_dns (const struct env_set *es)
   bool status;
   const char err[] = "ERROR: Windows ipconfig command failed";
 
-  msg (D_TUNTAP_INFO, "Start net commands...");
+  msg (D_TUNTAP_INFO, "Start ipconfig commands for register-dns...");
   netcmd_semaphore_lock ();
 
-  argv_printf (&argv, "%s%sc stop dnscache",
-	       get_win_sys_path(),
-	       WIN_NET_PATH_SUFFIX);
-  argv_msg (D_TUNTAP_INFO, &argv);
-  status = openvpn_execve_check (&argv, es, 0, err);
-  argv_reset(&argv);
-
-  argv_printf (&argv, "%s%sc start dnscache",
-	       get_win_sys_path(),
-	       WIN_NET_PATH_SUFFIX);
-  argv_msg (D_TUNTAP_INFO, &argv);
-  status = openvpn_execve_check (&argv, es, 0, err);
-  argv_reset(&argv);
-
   argv_printf (&argv, "%s%sc /flushdns",
 	       get_win_sys_path(),
 	       WIN_IPCONFIG_PATH_SUFFIX);
@@ -4629,7 +4615,7 @@ ipconfig_register_dns (const struct env_set *es)
   argv_reset(&argv);
 
   netcmd_semaphore_release ();
-  msg (D_TUNTAP_INFO, "End net commands...");
+  msg (D_TUNTAP_INFO, "End ipconfig commands for register-dns...");
 }
 
 void
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6c6772d..df1c214 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -893,8 +893,7 @@ RegisterDNS (LPVOID unused)
   WCHAR sys_path[MAX_PATH];
   DWORD timeout = RDNS_TIMEOUT * 1000; /* in milliseconds */
 
-  /* default paths of net and ipconfig commands */
-  WCHAR net[MAX_PATH]   = L"C:\\Windows\\system32\\net.exe";
+  /* default path of ipconfig command */
   WCHAR ipcfg[MAX_PATH] = L"C:\\Windows\\system32\\ipconfig.exe";
 
   struct
@@ -903,8 +902,6 @@ RegisterDNS (LPVOID unused)
       WCHAR *cmdline;
       DWORD timeout;
     } cmds [] = {
-                  { net,   L"net stop dnscache",     timeout },
-                  { net,   L"net start dnscache",    timeout },
                   { ipcfg, L"ipconfig /flushdns",    timeout },
                   { ipcfg, L"ipconfig /registerdns", timeout },
                 };
@@ -914,9 +911,6 @@ RegisterDNS (LPVOID unused)
 
   if(GetSystemDirectory(sys_path, MAX_PATH))
     {
-      _snwprintf (net, MAX_PATH, L"%s\\%s", sys_path, L"net.exe");
-      net[MAX_PATH-1] = L'\0';
-
       _snwprintf (ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
       ipcfg[MAX_PATH-1] = L'\0';
     }
-- 
2.1.4


