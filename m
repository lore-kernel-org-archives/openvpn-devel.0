From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 18 Jul 2012 16:35:37 +0300
Message-Id: <1342618537-8267-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz27P1YrdLFmL-DR7L1dgORwUyBa-NGRqPNo8Ex+3Q7vag@...278...>
References: <CAOazyz27P1YrdLFmL-DR7L1dgORwUyBa-NGRqPNo8Ex+3Q7vag@...278...>
Subject: [Openvpn-devel] [PATCH] plugin: load plugin relative to plugindir
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Currently openvpn requires/endorses specifying full path in plugin
parameter. As build system already aware of plugin location, it is
possible to load plugin relative to this directory, so full path is not
required nor more secured.

Windows is a little more complex as user may change installation
directory at install time, so we read plugindir location from the
registry, installer will set this value.

This replaces the old unused logic of the PLUGIN_LIBDIR macro.

The old unused logic of  ENABLE_PLUGIN_SEARCH is also removed as plugins
are relative to the plugindir.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/Makefile.am |    1 +
 src/openvpn/options.c   |    3 +
 src/openvpn/plugin.c    |  107 ++++++++++++++++++++++++++++++++---------------
 3 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 5d38628..ad78357 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -23,6 +23,7 @@ INCLUDES = \
 	-I$(top_srcdir)/src/compat
 
 AM_CFLAGS = \
+	-DOPENVPN_PLUGINDIR="\"$(plugindir)\"" \
 	$(TAP_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bccdf0c..9109b04 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3458,6 +3458,9 @@ usage_version (void)
   msg (M_INFO|M_NOPREFIX, "git revision: %s", CONFIGURE_GIT_REVISION);
 #endif
 #endif
+#ifdef OPENVPN_PLUGINDIR
+  msg (M_INFO|M_NOPREFIX, "build plugindir: %s", OPENVPN_PLUGINDIR);
+#endif
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7ce2f5e..5975361 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -196,46 +196,88 @@ static void
 plugin_init_item (struct plugin *p, const struct plugin_option *o)
 {
   struct gc_arena gc = gc_new ();
-  bool rel = false;
 
   p->so_pathname = o->so_pathname;
   p->plugin_type_mask = plugin_supported_types ();
 
 #ifndef WIN32
-
-  p->handle = NULL;
-#if defined(PLUGIN_LIBDIR)
-  if (!absolute_pathname (p->so_pathname))
-    {
-      char full[PATH_MAX];
-
-      openvpn_snprintf (full, sizeof(full), "%s/%s", PLUGIN_LIBDIR, p->so_pathname);
-      p->handle = dlopen (full, RTLD_NOW);
-#if defined(ENABLE_PLUGIN_SEARCH)
-      if (!p->handle)
-	{
-	  rel = true;
-	  p->handle = dlopen (p->so_pathname, RTLD_NOW);
-	}
-#endif
-    }
-  else
-#endif
-    {
-      rel = !absolute_pathname (p->so_pathname);
-      p->handle = dlopen (p->so_pathname, RTLD_NOW);
-    }
-  if (!p->handle)
-    msg (M_ERR, "PLUGIN_INIT: could not load plugin shared object %s: %s", p->so_pathname, dlerror());
+  {
+    char _abs_so_pathname[PATH_MAX];
+    const char *abs_so_pathname;
+
+    if (absolute_pathname (p->so_pathname))
+      abs_so_pathname = p->so_pathname;
+    else
+      {
+      	openvpn_snprintf(_abs_so_pathname, SIZE(_abs_so_pathname), "%s%c%s", OPENVPN_PLUGINDIR, OS_SPECIFIC_DIRSEP, p->so_pathname);
+        abs_so_pathname = _abs_so_pathname;
+      }
+
+    p->handle = dlopen (abs_so_pathname, RTLD_NOW);
+    if (!p->handle)
+      msg (M_ERR, "PLUGIN_INIT: could not load plugin shared object '%s': %s", abs_so_pathname, dlerror());
 
 # define PLUGIN_SYM(var, name, flags) libdl_resolve_symbol (p->handle, (void*)&p->var, name, p->so_pathname, flags)
 
+  }
 #else
-
-  rel = !absolute_pathname (p->so_pathname);
-  p->module = LoadLibraryW (wide_string (p->so_pathname, &gc));
-  if (!p->module)
-    msg (M_ERR, "PLUGIN_INIT: could not load plugin DLL: %s", p->so_pathname);
+  {
+    WCHAR _abs_so_pathname[PATH_MAX];
+    WCHAR *abs_so_pathname;
+
+    if (absolute_pathname (p->so_pathname))
+      abs_so_pathname = wide_string(p->so_pathname, &gc);
+    else
+      {
+         WCHAR _plugindir[PATH_MAX];
+         WCHAR _plugindir_expanded[PATH_MAX];
+         WCHAR *plugindir = NULL;
+         HKEY key;
+
+         if (RegOpenKeyExW(
+             HKEY_LOCAL_MACHINE,
+             L"SOFTWARE\\OpenVPN",
+             0,
+             KEY_READ,
+             &key
+           ) == ERROR_SUCCESS)
+           {
+             DWORD len = sizeof (_plugindir);
+             DWORD data_type;
+
+             if (RegQueryValueExW(
+                 key,
+                 L"plugindir",
+                 NULL,
+                 &data_type,
+                 (PBYTE)_plugindir,
+                 &len) == ERROR_SUCCESS &&
+                 data_type == REG_SZ)
+               {
+                 plugindir = _plugindir;
+               }
+           }
+
+         if (plugindir == NULL)
+           plugindir = wide_string (OPENVPN_PLUGINDIR, &gc);
+
+         if (ExpandEnvironmentStringsW(plugindir, _plugindir_expanded, SIZE(_plugindir_expanded)) != 0)
+	   plugindir = _plugindir_expanded;
+
+	 if (
+	   _snwprintf(_abs_so_pathname, SIZE(_abs_so_pathname), L"%s%C%s", plugindir, OS_SPECIFIC_DIRSEP, wide_string(p->so_pathname, &gc)) == SIZE(_abs_so_pathname) &&
+	   _abs_so_pathname[SIZE(_abs_so_pathname)-1] != L'\0')
+	   {
+             msg (M_ERR, "PLUGIN_INIT: plugin name too long: '%s'", p->so_pathname);
+	   }
+	 abs_so_pathname = _abs_so_pathname;
+      }
+
+    p->module = LoadLibraryW (abs_so_pathname);
+
+    if (!p->module)
+      msg (M_ERR, "PLUGIN_INIT: could not load plugin DLL: '%S'", abs_so_pathname);
+  }
 
 # define PLUGIN_SYM(var, name, flags) dll_resolve_symbol (p->module, (void*)&p->var, name, p->so_pathname, flags)
 
@@ -278,9 +320,6 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   else
     p->requested_initialization_point = OPENVPN_PLUGIN_INIT_PRE_DAEMON;
 
-  if (rel)
-    msg (M_WARN, "WARNING: plugin '%s' specified by a relative pathname -- using an absolute pathname would be more secure", p->so_pathname);
-
   p->initialized = true;
 
   gc_free (&gc);
-- 
1.7.8.6


