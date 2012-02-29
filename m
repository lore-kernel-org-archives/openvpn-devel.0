From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:50 +0200
Message-Id: <1330546342-17794-21-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 20/52] cleanup: rename tap-windows function
	from win32 to win
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac            |   18 +++---
 errlevel.h              |    2 +-
 error.c                 |    6 +-
 forward.c               |    2 +-
 options.c               |    8 +-
 service-win32/service.h |    2 +-
 sig.c                   |    2 +-
 tap-windows.h           |   34 ++++++------
 tun.c                   |  142 +++++++++++++++++++++++-----------------------
 tun.h                   |    6 +-
 version.m4              |    6 +-
 win/autodefs.h.in       |    6 +-
 win/openvpn.nsi         |    8 +-
 13 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/configure.ac b/configure.ac
index 937ce1f..3346e9f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -959,15 +959,15 @@ if test "$SELINUX" = "yes"; then
    )
 fi
 
-TAP_COMPONENT_ID="PRODUCT_TAP_ID"
-TAP_WIN32_MIN_MAJOR="PRODUCT_TAP_WIN32_MIN_MAJOR"
-TAP_WIN32_MIN_MINOR="PRODUCT_TAP_WIN32_MIN_MINOR"
-AC_DEFINE_UNQUOTED([TAP_ID], ["${TAP_ID}"], [The TAP-Win32 id])
-AC_DEFINE_UNQUOTED([TAP_WIN32_MIN_MAJOR], [${TAP_WIN32_MIN_MAJOR}], [The TAP-Win32 version number is defined in tap-win32/SOURCES])
-AC_DEFINE_UNQUOTED([TAP_WIN32_MIN_MINOR], [${TAP_WIN32_MIN_MINOR}], [The TAP-Win32 version number is defined in tap-win32/SOURCES])
-AC_SUBST([TAP_COMPONENT_ID])
-AC_SUBST([TAP_WIN32_MIN_MAJOR])
-AC_SUBST([TAP_WIN32_MIN_MINOR])
+TAP_WIN_COMPONENT_ID="PRODUCT_TAP_WIN_COMPONENT_ID"
+TAP_WIN_MIN_MAJOR="PRODUCT_TAP_WIN_MIN_MAJOR"
+TAP_WIN_MIN_MINOR="PRODUCT_TAP_WIN_MIN_MINOR"
+AC_DEFINE_UNQUOTED([TAP_WIN_COMPONENT_ID], ["${TAP_WIN_COMPONENT_ID}"], [The tap-windows id])
+AC_DEFINE_UNQUOTED([TAP_WIN_MIN_MAJOR], [${TAP_WIN_MIN_MAJOR}], [The tap-windows version number is required for OpenVPN])
+AC_DEFINE_UNQUOTED([TAP_WIN_MIN_MINOR], [${TAP_WIN_MIN_MINOR}], [The tap-windows version number is required for OpenVPN])
+AC_SUBST([TAP_WIN_COMPONENT_ID])
+AC_SUBST([TAP_WIN_MIN_MAJOR])
+AC_SUBST([TAP_WIN_MIN_MINOR])
 
 win32datadir="\${datadir}/${PACKAGE}-win32"
 AC_SUBST(win32datadir)
diff --git a/errlevel.h b/errlevel.h
index 74729c9..3ee4ebc 100644
--- a/errlevel.h
+++ b/errlevel.h
@@ -113,7 +113,7 @@
 
 #define D_LINK_RW            LOGLEV(6, 69, M_DEBUG)  /* show TCP/UDP reads/writes (terse) */
 #define D_TUN_RW             LOGLEV(6, 69, M_DEBUG)  /* show TUN/TAP reads/writes */
-#define D_TAP_WIN32_DEBUG    LOGLEV(6, 69, M_DEBUG)  /* show TAP-Win32 driver debug info */
+#define D_TAP_WIN_DEBUG      LOGLEV(6, 69, M_DEBUG)  /* show TAP-Windows driver debug info */
 #define D_CLIENT_NAT         LOGLEV(6, 69, M_DEBUG)  /* show client NAT debug info */
 
 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
diff --git a/error.c b/error.c
index ede33d0..34c4184 100644
--- a/error.c
+++ b/error.c
@@ -614,8 +614,8 @@ x_check_status (int status,
 	    }
 	}
 #elif defined(WIN32)
-      /* get possible driver error from TAP-Win32 driver */
-      extended_msg = tap_win32_getinfo (tt, &gc);
+      /* get possible driver error from TAP-Windows driver */
+      extended_msg = tap_win_getinfo (tt, &gc);
 #endif
       if (!ignore_sys_error (my_errno))
 	{
@@ -741,7 +741,7 @@ strerror_win32 (DWORD errnum, struct gc_arena *gc)
 #if 1
   switch (errnum) {
     /*
-     * When the TAP-Win32 driver returns STATUS_UNSUCCESSFUL, this code
+     * When the TAP-Windows driver returns STATUS_UNSUCCESSFUL, this code
      * gets returned to user space.
      */
   case ERROR_GEN_FAILURE:
diff --git a/forward.c b/forward.c
index 96c6b9a..ace7d2a 100644
--- a/forward.c
+++ b/forward.c
@@ -1292,7 +1292,7 @@ pre_select (struct context *c)
   c->c2.timeval.tv_usec = 0;
 
 #if defined(WIN32)
-  if (check_debug_level (D_TAP_WIN32_DEBUG))
+  if (check_debug_level (D_TAP_WIN_DEBUG))
     {
       c->c2.timeval.tv_sec = 1;
       if (tuntap_defined (c->c1.tuntap))
diff --git a/options.c b/options.c
index f11849d..cd7aba4 100644
--- a/options.c
+++ b/options.c
@@ -657,7 +657,7 @@ static const char usage_message[] =
   "Windows Specific:\n"
   "--win-sys path    : Pathname of Windows system directory. Default is the pathname\n"
   "                    from SystemRoot environment variable.\n"
-  "--ip-win32 method : When using --ifconfig on Windows, set TAP-Win32 adapter\n"
+  "--ip-win32 method : When using --ifconfig on Windows, set TAP-Windows adapter\n"
   "                    IP address using method = manual, netsh, ipapi,\n"
   "                    dynamic, or adaptive (default = adaptive).\n"
   "                    Dynamic method allows two optional parameters:\n"
@@ -673,7 +673,7 @@ static const char usage_message[] =
   "                    adaptive (default) -- Try ipapi then fall back to exe.\n"
   "                    ipapi -- Use IP helper API.\n"
   "                    exe -- Call the route.exe shell command.\n"
-  "--dhcp-option type [parm] : Set extended TAP-Win32 properties, must\n"
+  "--dhcp-option type [parm] : Set extended TAP-Windows properties, must\n"
   "                    be used with --ip-win32 dynamic.  For options\n"
   "                    which allow multiple addresses,\n"
   "                    --dhcp-option must be repeated.\n"
@@ -704,7 +704,7 @@ static const char usage_message[] =
   "                  after TAP adapter is up and routes have been added.\n"
   "Windows Standalone Options:\n"
   "\n"
-  "--show-adapters : Show all TAP-Win32 adapters.\n"
+  "--show-adapters : Show all TAP-Windows adapters.\n"
   "--show-net      : Show " PACKAGE_NAME "'s view of routing table and net adapter list.\n"
   "--show-valid-subnets : Show valid subnets for --dev tun emulation.\n"
   "--allow-nonadmin [TAP-adapter] : Allow " PACKAGE_NAME " running without admin privileges\n"
@@ -6046,7 +6046,7 @@ add_option (struct options *options,
   else if (streq (p[0], "show-adapters"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      show_tap_win32_adapters (M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX);
+      show_tap_win_adapters (M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX);
       openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
   else if (streq (p[0], "show-net"))
diff --git a/service-win32/service.h b/service-win32/service.h
index 028d075..cf41ed7 100644
--- a/service-win32/service.h
+++ b/service-win32/service.h
@@ -69,7 +69,7 @@ extern "C" {
 // displayed name of the service
 #define SZSERVICEDISPLAYNAME PACKAGE_NAME " Service"
 // list of service dependencies - "dep1\0dep2\0\0"
-#define SZDEPENDENCIES       TAP_ID "\0Dhcp\0\0"
+#define SZDEPENDENCIES       TAP_WIN_COMPONENT_ID "\0Dhcp\0\0"
 //////////////////////////////////////////////////////////////////////////////
 
 
diff --git a/sig.c b/sig.c
index a5703f0..df8035e 100644
--- a/sig.c
+++ b/sig.c
@@ -268,7 +268,7 @@ print_status (const struct context *c, struct status_output *so)
 #ifdef WIN32
   if (tuntap_defined (c->c1.tuntap))
     status_printf (so, "TAP-WIN32 driver status,\"%s\"",
-	 tap_win32_getinfo (c->c1.tuntap, &gc));
+	 tap_win_getinfo (c->c1.tuntap, &gc));
 #endif
 
   status_printf (so, "END");
diff --git a/tap-windows.h b/tap-windows.h
index 0655672..243a4a2 100644
--- a/tap-windows.h
+++ b/tap-windows.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
@@ -21,32 +21,32 @@
  *  distribution); if not, write to the Free Software Foundation, Inc.,
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#ifndef __TAP_H
-#define __TAP_H
+#ifndef __TAP_WIN_H
+#define __TAP_WIN_H
 
 //=============
 // TAP IOCTLs
 //=============
 
-#define TAP_CONTROL_CODE(request,method) \
+#define TAP_WIN_CONTROL_CODE(request,method) \
   CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
 
 // Present in 8.1
 
-#define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE (1, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE (3, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE (4, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE (5, METHOD_BUFFERED)
-#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE (7, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE (8, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE (9, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_MAC               TAP_WIN_CONTROL_CODE (1, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_VERSION           TAP_WIN_CONTROL_CODE (2, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_MTU               TAP_WIN_CONTROL_CODE (3, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_INFO              TAP_WIN_CONTROL_CODE (4, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT TAP_WIN_CONTROL_CODE (5, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_SET_MEDIA_STATUS      TAP_WIN_CONTROL_CODE (6, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ      TAP_WIN_CONTROL_CODE (7, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_GET_LOG_LINE          TAP_WIN_CONTROL_CODE (8, METHOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT   TAP_WIN_CONTROL_CODE (9, METHOD_BUFFERED)
 
 // Added in 8.2
 
-/* obsoletes TAP_IOCTL_CONFIG_POINT_TO_POINT */
-#define TAP_IOCTL_CONFIG_TUN            TAP_CONTROL_CODE (10, METHOD_BUFFERED)
+/* obsoletes TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT */
+#define TAP_WIN_IOCTL_CONFIG_TUN            TAP_WIN_CONTROL_CODE (10, METHOD_BUFFERED)
 
 //=================
 // Registry keys
@@ -63,6 +63,6 @@
 #define USERMODEDEVICEDIR "\\\\.\\Global\\"
 #define SYSDEVICEDIR      "\\Device\\"
 #define USERDEVICEDIR     "\\DosDevices\\Global\\"
-#define TAPSUFFIX         ".tap"
+#define TAP_WIN_SUFFIX    ".tap"
 
 #endif
diff --git a/tun.c b/tun.c
index 81b66fb..b3df14e 100644
--- a/tun.c
+++ b/tun.c
@@ -1176,7 +1176,7 @@ do_ifconfig (struct tuntap *tt,
 	    break;
 	  case IPW32_SET_NETSH:
 	    if (!strcmp (actual, "NULL"))
-	      msg (M_FATAL, "Error: When using --ip-win32 netsh, if you have more than one TAP-Win32 adapter, you must also specify --dev-node");
+	      msg (M_FATAL, "Error: When using --ip-win32 netsh, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
 
 	    netsh_ifconfig (&tt->options,
 			    actual,
@@ -1195,7 +1195,7 @@ do_ifconfig (struct tuntap *tt,
 	char * saved_actual;
 
 	if (!strcmp (actual, "NULL"))
-	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Win32 adapter, you must also specify --dev-node");
+	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
 
 	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d store=active */
 	argv_printf (&argv,
@@ -2786,7 +2786,7 @@ get_tap_reg (struct gc_arena *gc)
 
 	      if (status == ERROR_SUCCESS && data_type == REG_SZ)
 		{
-		  if (!strcmp (component_id, TAP_COMPONENT_ID))
+		  if (!strcmp (component_id, TAP_WIN_COMPONENT_ID))
 		    {
 		      struct tap_reg *reg;
 		      ALLOC_OBJ_CLEAR_GC (reg, struct tap_reg, gc);
@@ -2953,7 +2953,7 @@ void show_valid_win32_tun_subnets (void)
   int col = 0;
 
   printf ("On Windows, point-to-point IP support (i.e. --dev tun)\n");
-  printf ("is emulated by the TAP-Win32 driver.  The major limitation\n");
+  printf ("is emulated by the TAP-Windows driver.  The major limitation\n");
   printf ("imposed by this approach is that the --ifconfig local and\n");
   printf ("remote endpoints must be part of the same 255.255.255.252\n");
   printf ("subnet.  The following list shows examples of endpoint\n");
@@ -2978,7 +2978,7 @@ void show_valid_win32_tun_subnets (void)
 }
 
 void
-show_tap_win32_adapters (int msglev, int warnlev)
+show_tap_win_adapters (int msglev, int warnlev)
 {
   struct gc_arena gc = gc_new ();
 
@@ -2997,7 +2997,7 @@ show_tap_win32_adapters (int msglev, int warnlev)
 
   msg (msglev, "Available TAP-WIN32 adapters [name, GUID]:");
 
-  /* loop through each TAP-Win32 adapter registry entry */
+  /* loop through each TAP-Windows adapter registry entry */
   for (tr = tap_reg; tr != NULL; tr = tr->next)
     {
       links = 0;
@@ -3025,7 +3025,7 @@ show_tap_win32_adapters (int msglev, int warnlev)
 	}
     }
 
-  /* check for TAP-Win32 adapter duplicated GUIDs */
+  /* check for TAP-Windows adapter duplicated GUIDs */
   for (tr = tap_reg; tr != NULL; tr = tr->next)
     {
       for (tr1 = tap_reg; tr1 != NULL; tr1 = tr1->next)
@@ -3037,22 +3037,22 @@ show_tap_win32_adapters (int msglev, int warnlev)
 
   /* warn on registry inconsistencies */
   if (warn_tap_dup)
-    msg (warnlev, "WARNING: Some TAP-Win32 adapters have duplicate GUIDs");
+    msg (warnlev, "WARNING: Some TAP-Windows adapters have duplicate GUIDs");
 
   if (warn_panel_dup)
-    msg (warnlev, "WARNING: Some TAP-Win32 adapters have duplicate links from the Network Connections control panel");
+    msg (warnlev, "WARNING: Some TAP-Windows adapters have duplicate links from the Network Connections control panel");
 
   if (warn_panel_null)
-    msg (warnlev, "WARNING: Some TAP-Win32 adapters have no link from the Network Connections control panel");
+    msg (warnlev, "WARNING: Some TAP-Windows adapters have no link from the Network Connections control panel");
 
   gc_free (&gc);
 }
 
 /*
- * Confirm that GUID is a TAP-Win32 adapter.
+ * Confirm that GUID is a TAP-Windows adapter.
  */
 static bool
-is_tap_win32 (const char *guid, const struct tap_reg *tap_reg)
+is_tap_win (const char *guid, const struct tap_reg *tap_reg)
 {
   const struct tap_reg *tr;
 
@@ -3086,7 +3086,7 @@ name_to_guid (const char *name, const struct tap_reg *tap_reg, const struct pane
 
   for (pr = panel_reg; pr != NULL; pr = pr->next)
     {
-      if (name && !strcmp (pr->name, name) && is_tap_win32 (pr->guid, tap_reg))
+      if (name && !strcmp (pr->name, name) && is_tap_win (pr->guid, tap_reg))
 	return pr->guid;
     }
 
@@ -3094,10 +3094,10 @@ name_to_guid (const char *name, const struct tap_reg *tap_reg, const struct pane
 }
 
 static void
-at_least_one_tap_win32 (const struct tap_reg *tap_reg)
+at_least_one_tap_win (const struct tap_reg *tap_reg)
 {
   if (!tap_reg)
-    msg (M_FATAL, "There are no TAP-Win32 adapters on this system.  You should be able to create a TAP-Win32 adapter by going to Start -> All Programs -> " PACKAGE_NAME " -> Add a new TAP-Win32 virtual ethernet adapter.");
+    msg (M_FATAL, "There are no TAP-Windows adapters on this system.  You should be able to create a TAP-Windows adapter by going to Start -> All Programs -> " PACKAGE_NAME " -> Add a new TAP-Windows virtual ethernet adapter.");
 }
 
 /*
@@ -3181,7 +3181,7 @@ get_device_guid (const char *name,
     }
 
   /* Check if GUID was explicitly specified as --dev-node parameter */
-  if (is_tap_win32 (name, tap_reg))
+  if (is_tap_win (name, tap_reg))
     {
       const char *act = guid_to_name (name, panel_reg);
       buf_printf (&ret, "%s", name);
@@ -3767,7 +3767,7 @@ show_adapters (int msglev)
 }
 
 /*
- * Set a particular TAP-Win32 adapter (or all of them if
+ * Set a particular TAP-Windows adapter (or all of them if
  * adapter_name == NULL) to allow it to be opened from
  * a non-admin account.  This setting will only persist
  * for the lifetime of the device object.
@@ -3789,7 +3789,7 @@ tap_allow_nonadmin_access_handle (const char *device_path, HANDLE hand)
     }
   else
     {
-      msg (M_INFO|M_NOPREFIX, "TAP-Win32 device: %s [Non-admin access allowed]", device_path);
+      msg (M_INFO|M_NOPREFIX, "TAP-Windows device: %s [Non-admin access allowed]", device_path);
     }
 }
 
@@ -3804,7 +3804,7 @@ tap_allow_nonadmin_access (const char *dev_node)
   char actual_buffer[256];
   char device_path[256];
 
-  at_least_one_tap_win32 (tap_reg);
+  at_least_one_tap_win (tap_reg);
 
   if (dev_node)
     {
@@ -3812,13 +3812,13 @@ tap_allow_nonadmin_access (const char *dev_node)
       device_guid = get_device_guid (dev_node, actual_buffer, sizeof (actual_buffer), tap_reg, panel_reg, &gc);
 
       if (!device_guid)
-	msg (M_FATAL, "TAP-Win32 adapter '%s' not found", dev_node);
+	msg (M_FATAL, "TAP-Windows adapter '%s' not found", dev_node);
 
-      /* Open Windows TAP-Win32 adapter */
+      /* Open Windows TAP-Windows adapter */
       openvpn_snprintf (device_path, sizeof(device_path), "%s%s%s",
 			USERMODEDEVICEDIR,
 			device_guid,
-			TAPSUFFIX);
+			TAP_WIN_SUFFIX);
       
       hand = CreateFile (
 			 device_path,
@@ -3853,11 +3853,11 @@ tap_allow_nonadmin_access (const char *dev_node)
 	  if (!device_guid)
 	    break;
 
-	  /* Open Windows TAP-Win32 adapter */
+	  /* Open Windows TAP-Windows adapter */
 	  openvpn_snprintf (device_path, sizeof(device_path), "%s%s%s",
 			    USERMODEDEVICEDIR,
 			    device_guid,
-			    TAPSUFFIX);
+			    TAP_WIN_SUFFIX);
 
 	  hand = CreateFile (
 			     device_path,
@@ -3902,7 +3902,7 @@ dhcp_release_by_adapter_index(const DWORD adapter_index)
 	  ret = true;
 	}
       else
-	msg (M_WARN, "NOTE: Release of DHCP-assigned IP address lease on TAP-Win32 adapter failed: %s (code=%u)",
+	msg (M_WARN, "NOTE: Release of DHCP-assigned IP address lease on TAP-Windows adapter failed: %s (code=%u)",
 	     strerror_win32 (status, &gc),
 	     (unsigned int)status);
     }
@@ -3936,7 +3936,7 @@ dhcp_renew_by_adapter_index (const DWORD adapter_index)
 	  ret = true;
 	}
       else
-	msg (M_WARN, "WARNING: Failed to renew DHCP IP address lease on TAP-Win32 adapter: %s (code=%u)",
+	msg (M_WARN, "WARNING: Failed to renew DHCP IP address lease on TAP-Windows adapter: %s (code=%u)",
 	     strerror_win32 (status, &gc),
 	     (unsigned int)status);
     }
@@ -4281,7 +4281,7 @@ netsh_get_id (const char *dev_node, struct gc_arena *gc)
   struct buffer actual = alloc_buf_gc (256, gc);
   const char *guid;
 
-  at_least_one_tap_win32 (tap_reg);
+  at_least_one_tap_win (tap_reg);
 
   if (dev_node)
     {
@@ -4291,7 +4291,7 @@ netsh_get_id (const char *dev_node, struct gc_arena *gc)
     {
       guid = get_unspecified_device_guid (0, BPTR (&actual), BCAP (&actual), tap_reg, panel_reg, gc);
 
-      if (get_unspecified_device_guid (1, NULL, 0, tap_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Win32 adapter */
+      if (get_unspecified_device_guid (1, NULL, 0, tap_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Windows adapter */
 	guid = NULL;
     }
 
@@ -4304,7 +4304,7 @@ netsh_get_id (const char *dev_node, struct gc_arena *gc)
 }
 
 /*
- * Called iteratively on TAP-Win32 wait-for-initialization polling loop
+ * Called iteratively on TAP-Windows wait-for-initialization polling loop
  */
 void
 tun_standby_init (struct tuntap *tt)
@@ -4535,7 +4535,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     const struct panel_reg *panel_reg = get_panel_reg (&gc);
     char actual_buffer[256];
 
-    at_least_one_tap_win32 (tap_reg);
+    at_least_one_tap_win (tap_reg);
 
     if (dev_node)
       {
@@ -4543,13 +4543,13 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
         device_guid = get_device_guid (dev_node, actual_buffer, sizeof (actual_buffer), tap_reg, panel_reg, &gc);
 
 	if (!device_guid)
-	  msg (M_FATAL, "TAP-Win32 adapter '%s' not found", dev_node);
+	  msg (M_FATAL, "TAP-Windows adapter '%s' not found", dev_node);
 
-        /* Open Windows TAP-Win32 adapter */
+        /* Open Windows TAP-Windows adapter */
         openvpn_snprintf (device_path, sizeof(device_path), "%s%s%s",
    		          USERMODEDEVICEDIR,
 		          device_guid,
-		          TAPSUFFIX);
+		          TAP_WIN_SUFFIX);
 
         tt->hand = CreateFile (
 			       device_path,
@@ -4579,13 +4579,13 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 						       &gc);
 
 	    if (!device_guid)
-	      msg (M_FATAL, "All TAP-Win32 adapters on this system are currently in use.");
+	      msg (M_FATAL, "All TAP-Windows adapters on this system are currently in use.");
 
-            /* Open Windows TAP-Win32 adapter */
+            /* Open Windows TAP-Windows adapter */
             openvpn_snprintf (device_path, sizeof(device_path), "%s%s%s",
        		  	      USERMODEDEVICEDIR,
 			      device_guid,
-			      TAPSUFFIX);
+			      TAP_WIN_SUFFIX);
 
             tt->hand = CreateFile (
 			 	   device_path,
@@ -4618,20 +4618,20 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
   {
     ULONG info[3];
     CLEAR (info);
-    if (DeviceIoControl (tt->hand, TAP_IOCTL_GET_VERSION,
+    if (DeviceIoControl (tt->hand, TAP_WIN_IOCTL_GET_VERSION,
 			 &info, sizeof (info),
 			 &info, sizeof (info), &len, NULL))
       {
-	msg (D_TUNTAP_INFO, "TAP-Win32 Driver Version %d.%d %s",
+	msg (D_TUNTAP_INFO, "TAP-Windows Driver Version %d.%d %s",
 	     (int) info[0],
 	     (int) info[1],
 	     (info[2] ? "(DEBUG)" : ""));
 
       }
-    if (!(info[0] == TAP_WIN32_MIN_MAJOR && info[1] >= TAP_WIN32_MIN_MINOR))
-      msg (M_FATAL, "ERROR:  This version of " PACKAGE_NAME " requires a TAP-Win32 driver that is at least version %d.%d -- If you recently upgraded your " PACKAGE_NAME " distribution, a reboot is probably required at this point to get Windows to see the new driver.",
-	   TAP_WIN32_MIN_MAJOR,
-	   TAP_WIN32_MIN_MINOR);
+    if (!(info[0] == TAP_WIN_MIN_MAJOR && info[1] >= TAP_WIN_MIN_MINOR))
+      msg (M_FATAL, "ERROR:  This version of " PACKAGE_NAME " requires a TAP-Windows driver that is at least version %d.%d -- If you recently upgraded your " PACKAGE_NAME " distribution, a reboot is probably required at this point to get Windows to see the new driver.",
+	   TAP_WIN_MIN_MAJOR,
+	   TAP_WIN_MIN_MINOR);
 
     /* usage of numeric constants is ugly, but this is really tied to
      * *this* version of the driver
@@ -4655,17 +4655,17 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
   /* get driver MTU */
   {
     ULONG mtu;
-    if (DeviceIoControl (tt->hand, TAP_IOCTL_GET_MTU,
+    if (DeviceIoControl (tt->hand, TAP_WIN_IOCTL_GET_MTU,
 			 &mtu, sizeof (mtu),
 			 &mtu, sizeof (mtu), &len, NULL))
       {
 	tt->post_open_mtu = (int) mtu;
-	msg (D_MTU_INFO, "TAP-Win32 MTU=%d", (int) mtu);
+	msg (D_MTU_INFO, "TAP-Windows MTU=%d", (int) mtu);
       }
   }
 
   /*
-   * Preliminaries for setting TAP-Win32 adapter TCP/IP
+   * Preliminaries for setting TAP-Windows adapter TCP/IP
    * properties via --ip-win32 dynamic or --ip-win32 adaptive.
    */
   if (tt->did_ifconfig_setup)
@@ -4718,11 +4718,11 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 	  ep[1] = htonl (tt->local & tt->remote_netmask);
 	  ep[2] = htonl (tt->remote_netmask);
 
-	  status = DeviceIoControl (tt->hand, TAP_IOCTL_CONFIG_TUN,
+	  status = DeviceIoControl (tt->hand, TAP_WIN_IOCTL_CONFIG_TUN,
 				    ep, sizeof (ep),
 				    ep, sizeof (ep), &len, NULL);
 
-          msg (status ? M_INFO : M_FATAL, "Set TAP-Win32 TUN subnet mode network/local/netmask = %s/%s/%s [%s]",
+          msg (status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet mode network/local/netmask = %s/%s/%s [%s]",
 	       print_in_addr_t (ep[1], IA_NET_ORDER, &gc),
 	       print_in_addr_t (ep[0], IA_NET_ORDER, &gc),
 	       print_in_addr_t (ep[2], IA_NET_ORDER, &gc),
@@ -4734,14 +4734,14 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 	  ep[0] = htonl (tt->local);
 	  ep[1] = htonl (tt->remote_netmask);
 
-	  if (!DeviceIoControl (tt->hand, TAP_IOCTL_CONFIG_POINT_TO_POINT,
+	  if (!DeviceIoControl (tt->hand, TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,
 				ep, sizeof (ep),
 				ep, sizeof (ep), &len, NULL))
-	    msg (M_FATAL, "ERROR: The TAP-Win32 driver rejected a DeviceIoControl call to set Point-to-Point mode, which is required for --dev tun");
+	    msg (M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set Point-to-Point mode, which is required for --dev tun");
 	}
     }
 
-  /* should we tell the TAP-Win32 driver to masquerade as a DHCP server as a means
+  /* should we tell the TAP-Windows driver to masquerade as a DHCP server as a means
      of setting the adapter address? */
   if (dhcp_masq)
     {
@@ -4776,12 +4776,12 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       ASSERT (ep[3] > 0);
 
 #ifndef SIMULATE_DHCP_FAILED /* this code is disabled to simulate bad DHCP negotiation */
-      if (!DeviceIoControl (tt->hand, TAP_IOCTL_CONFIG_DHCP_MASQ,
+      if (!DeviceIoControl (tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
 			    ep, sizeof (ep),
 			    ep, sizeof (ep), &len, NULL))
-	msg (M_FATAL, "ERROR: The TAP-Win32 driver rejected a DeviceIoControl call to set TAP_IOCTL_CONFIG_DHCP_MASQ mode");
+	msg (M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
 
-      msg (M_INFO, "Notified TAP-Win32 driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
+      msg (M_INFO, "Notified TAP-Windows driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
 	   print_in_addr_t (tt->local, 0, &gc),
 	   print_in_addr_t (tt->adapter_netmask, 0, &gc),
 	   device_guid,
@@ -4796,10 +4796,10 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 	  if (build_dhcp_options_string (&buf, &tt->options))
 	    {
 	      msg (D_DHCP_OPT, "DHCP option string: %s", format_hex (BPTR (&buf), BLEN (&buf), 0, &gc));
-	      if (!DeviceIoControl (tt->hand, TAP_IOCTL_CONFIG_DHCP_SET_OPT,
+	      if (!DeviceIoControl (tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
 				    BPTR (&buf), BLEN (&buf),
 				    BPTR (&buf), BLEN (&buf), &len, NULL))
-		msg (M_FATAL, "ERROR: The TAP-Win32 driver rejected a TAP_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
+		msg (M_FATAL, "ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
 	    }
 	  else
 	    msg (M_WARN, "DHCP option string not set due to error");
@@ -4811,10 +4811,10 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
   /* set driver media status to 'connected' */
   {
     ULONG status = TRUE;
-    if (!DeviceIoControl (tt->hand, TAP_IOCTL_SET_MEDIA_STATUS,
+    if (!DeviceIoControl (tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
 			  &status, sizeof (status),
 			  &status, sizeof (status), &len, NULL))
-      msg (M_WARN, "WARNING: The TAP-Win32 driver rejected a TAP_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
+      msg (M_WARN, "WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
   }
 
   /* possible wait for adapter to come up */
@@ -4849,7 +4849,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       }
 
     /*
-     * If the TAP-Win32 driver is masquerading as a DHCP server
+     * If the TAP-Windows driver is masquerading as a DHCP server
      * make sure the TCP/IP properties for the adapter are
      * set correctly.
      */
@@ -4857,7 +4857,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       {
 	/* check dhcp enable status */
 	if (dhcp_status (index) == DHCP_STATUS_DISABLED)
-	  msg (M_WARN, "WARNING: You have selected '--ip-win32 dynamic', which will not work unless the TAP-Win32 TCP/IP properties are set to 'Obtain an IP address automatically'");
+	  msg (M_WARN, "WARNING: You have selected '--ip-win32 dynamic', which will not work unless the TAP-Windows TCP/IP properties are set to 'Obtain an IP address automatically'");
 
 	/* force an explicit DHCP lease renewal on TAP adapter? */
 	if (tt->options.dhcp_pre_release)
@@ -4883,7 +4883,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
 	/* check dhcp enable status */
 	if (dhcp_status (index) == DHCP_STATUS_DISABLED)
-	  msg (M_WARN, "NOTE: You have selected (explicitly or by default) '--ip-win32 ipapi', which has a better chance of working correctly if the TAP-Win32 TCP/IP properties are set to 'Obtain an IP address automatically'");
+	  msg (M_WARN, "NOTE: You have selected (explicitly or by default) '--ip-win32 ipapi', which has a better chance of working correctly if the TAP-Windows TCP/IP properties are set to 'Obtain an IP address automatically'");
 
 	/* delete previously added IP addresses which were not
 	   correctly deleted */
@@ -4917,13 +4917,13 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 }
 
 const char *
-tap_win32_getinfo (const struct tuntap *tt, struct gc_arena *gc)
+tap_win_getinfo (const struct tuntap *tt, struct gc_arena *gc)
 {
   if (tt && tt->hand != NULL)
     {
       struct buffer out = alloc_buf_gc (256, gc);
       DWORD len;
-      if (DeviceIoControl (tt->hand, TAP_IOCTL_GET_INFO,
+      if (DeviceIoControl (tt->hand, TAP_WIN_IOCTL_GET_INFO,
 			   BSTR (&out), BCAP (&out),
 			   BSTR (&out), BCAP (&out),
 			   &len, NULL))
@@ -4941,12 +4941,12 @@ tun_show_debug (struct tuntap *tt)
     {
       struct buffer out = alloc_buf (1024);
       DWORD len;
-      while (DeviceIoControl (tt->hand, TAP_IOCTL_GET_LOG_LINE,
+      while (DeviceIoControl (tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE,
 			      BSTR (&out), BCAP (&out),
 			      BSTR (&out), BCAP (&out),
 			      &len, NULL))
 	{
-	  msg (D_TAP_WIN32_DEBUG, "TAP-Win32: %s", BSTR (&out));
+	  msg (D_TAP_WIN_DEBUG, "TAP-Windows: %s", BSTR (&out));
 	}
       free_buf (&out);
     }
@@ -4986,7 +4986,7 @@ close_tun (struct tuntap *tt)
 	  DWORD status;
 	  if ((status = DeleteIPAddress (tt->ipapi_context)) != NO_ERROR)
 	    {
-	      msg (M_WARN, "Warning: DeleteIPAddress[%u] failed on TAP-Win32 adapter, status=%u : %s",
+	      msg (M_WARN, "Warning: DeleteIPAddress[%u] failed on TAP-Windows adapter, status=%u : %s",
 		   (unsigned int)tt->ipapi_context,
 		   (unsigned int)status,
 		   strerror_win32 (status, &gc));
@@ -4999,22 +4999,22 @@ close_tun (struct tuntap *tt)
 
       if (tt->hand != NULL)
 	{
-	  dmsg (D_WIN32_IO_LOW, "Attempting CancelIO on TAP-Win32 adapter");
+	  dmsg (D_WIN32_IO_LOW, "Attempting CancelIO on TAP-Windows adapter");
 	  if (!CancelIo (tt->hand))
-	    msg (M_WARN | M_ERRNO, "Warning: CancelIO failed on TAP-Win32 adapter");
+	    msg (M_WARN | M_ERRNO, "Warning: CancelIO failed on TAP-Windows adapter");
 	}
 
-      dmsg (D_WIN32_IO_LOW, "Attempting close of overlapped read event on TAP-Win32 adapter");
+      dmsg (D_WIN32_IO_LOW, "Attempting close of overlapped read event on TAP-Windows adapter");
       overlapped_io_close (&tt->reads);
 
-      dmsg (D_WIN32_IO_LOW, "Attempting close of overlapped write event on TAP-Win32 adapter");
+      dmsg (D_WIN32_IO_LOW, "Attempting close of overlapped write event on TAP-Windows adapter");
       overlapped_io_close (&tt->writes);
 
       if (tt->hand != NULL)
 	{
-	  dmsg (D_WIN32_IO_LOW, "Attempting CloseHandle on TAP-Win32 adapter");
+	  dmsg (D_WIN32_IO_LOW, "Attempting CloseHandle on TAP-Windows adapter");
 	  if (!CloseHandle (tt->hand))
-	    msg (M_WARN | M_ERRNO, "Warning: CloseHandle failed on TAP-Win32 adapter");
+	    msg (M_WARN | M_ERRNO, "Warning: CloseHandle failed on TAP-Windows adapter");
 	}
 
       if (tt->actual_name)
diff --git a/tun.h b/tun.h
index ad7b2b1..749bee5 100644
--- a/tun.h
+++ b/tun.h
@@ -164,7 +164,7 @@ struct tuntap
   ULONG ipapi_instance;
   in_addr_t adapter_netmask;
 
-  /* Windows adapter index for TAP-Win32 adapter,
+  /* Windows adapter index for TAP-Windows adapter,
      ~0 if undefined */
   DWORD adapter_index;
 
@@ -333,13 +333,13 @@ DWORD adapter_index_of_ip (const IP_ADAPTER_INFO *list,
 			   int *count,
 			   in_addr_t *netmask);
 
-void show_tap_win32_adapters (int msglev, int warnlev);
+void show_tap_win_adapters (int msglev, int warnlev);
 void show_adapters (int msglev);
 
 void tap_allow_nonadmin_access (const char *dev_node);
 
 void show_valid_win32_tun_subnets (void);
-const char *tap_win32_getinfo (const struct tuntap *tt, struct gc_arena *gc);
+const char *tap_win_getinfo (const struct tuntap *tt, struct gc_arena *gc);
 void tun_show_debug (struct tuntap *tt);
 
 bool dhcp_release_by_adapter_index(const DWORD adapter_index);
diff --git a/version.m4 b/version.m4
index ff9b35f..bfdbf4f 100644
--- a/version.m4
+++ b/version.m4
@@ -1,6 +1,6 @@
 dnl define the OpenVPN version
 define(PRODUCT_VERSION,[2.3_alpha1])
 dnl define the TAP version
-define(PRODUCT_TAP_ID,[tap0901])
-define(PRODUCT_TAP_WIN32_MIN_MAJOR,[9])
-define(PRODUCT_TAP_WIN32_MIN_MINOR,[9])
+define(PRODUCT_TAP_WIN_COMPONENT_ID,[tap0901])
+define(PRODUCT_TAP_WIN_MIN_MAJOR,[9])
+define(PRODUCT_TAP_WIN_MIN_MINOR,[9])
diff --git a/win/autodefs.h.in b/win/autodefs.h.in
index 372eb81..760b0df 100644
--- a/win/autodefs.h.in
+++ b/win/autodefs.h.in
@@ -6,9 +6,9 @@
  *
  * The TAP-Win32 version number is defined in tap-win32/SOURCES
  */
-#define TAP_COMPONENT_ID "@PRODUCT_TAP_ID@"
-#define TAP_WIN32_MIN_MAJOR @PRODUCT_TAP_WIN32_MIN_MAJOR@
-#define TAP_WIN32_MIN_MINOR @PRODUCT_TAP_WIN32_MIN_MINOR@
+#define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
+#define TAP_WIN_MIN_MAJOR @PRODUCT_TAP_WIN_MIN_MAJOR@
+#define TAP_WIN_MIN_MINOR @PRODUCT_TAP_WIN_MIN_MINOR@
 
 /* Friendly name for TAP driver */
 #define PRODUCT_TAP_DEVICE_DESCRIPTION "@PRODUCT_TAP_DEVICE_DESCRIPTION@"
diff --git a/win/openvpn.nsi b/win/openvpn.nsi
index 29d34f1..4167c89 100755
--- a/win/openvpn.nsi
+++ b/win/openvpn.nsi
@@ -44,7 +44,7 @@ SetCompressor lzma
 
 !define VERSION "${PRODUCT_VERSION}${DBG_POSTFIX}"
 
-!define TAP "${PRODUCT_TAP_ID}"
+!define TAP "${PRODUCT_TAP_WIN_COMPONENT_ID}"
 !define TAPDRV "${TAP}.sys"
 
 ; Default service settings
@@ -409,7 +409,7 @@ Section "TAP Virtual Ethernet Adapter" SecTAP
   File "${GEN}\amd64\${TAPDRV}"
 
   # Don't try to install TAP driver signature if it does not exist.
-  File /nonfatal "${GEN}\amd64\${PRODUCT_TAP_ID}.cat"
+  File /nonfatal "${GEN}\amd64\${PRODUCT_TAP_COMPONENT_ID}.cat"
 
 goto tapend
 
@@ -425,7 +425,7 @@ tap-32bit:
   File "${GEN}\i386\${TAPDRV}"
 
   # Don't try to install TAP driver signature if it does not exist.
-  File /nonfatal "${GEN}\i386\${PRODUCT_TAP_ID}.cat"
+  File /nonfatal "${GEN}\i386\${PRODUCT_TAP_COMPONENT_ID}.cat"
 
   tapend:
 
@@ -778,7 +778,7 @@ Section "Uninstall"
   Delete "$INSTDIR\log\README.txt"
 
   Delete "$INSTDIR\driver\OemWin2k.inf"
-  Delete "$INSTDIR\driver\${PRODUCT_TAP_ID}.cat"
+  Delete "$INSTDIR\driver\${PRODUCT_TAP_COMPONENT_ID}.cat"
   Delete "$INSTDIR\driver\${TAPDRV}"
 
   Delete "$INSTDIR\bin\openssl.exe"
-- 
1.7.3.4


