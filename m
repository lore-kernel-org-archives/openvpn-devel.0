From: Arne Schwabe <arne@...1227...>
Date: Sun,  3 Feb 2013 12:12:31 +0100
Message-Id: <1359889951-3369-1-git-send-email-arne@...1227...>
In-Reply-To: <510D3B74.3060007@...1114...>
References: <510D3B74.3060007@...1114...>
Subject: [Openvpn-devel] [PATCH] Remove dead code path and putenv
	functionality
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

The construct_name_value function call will always fail so this code path is never used. Since we now always have a valid environment in static_context->c2.es it is better to have a ASSERT(es) than to call this code patch.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/misc.c     |   24 ++++--------------------
 src/openvpn/platform.c |   28 ----------------------------
 2 files changed, 4 insertions(+), 48 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fcc8552..b8fb9d7 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -707,13 +707,6 @@ env_set_remove_from_environment (const struct env_set *es)
 
 static struct env_item *global_env = NULL; /* GLOBAL */
 
-void
-manage_env (char *str)
-{
-  remove_env_item (str, true, &global_env);
-  add_env_item (str, false, &global_env, NULL);
-}
-
 #endif
 
 /* add/modify/delete environmental strings */
@@ -789,9 +782,9 @@ setenv_str_ex (struct env_set *es,
   if (value)
     val_tmp = string_mod_const (value, value_include, value_exclude, value_replace, &gc);
 
-  if (es)
-    {
-      if (val_tmp)
+  ASSERT (es);
+
+  if (val_tmp)
 	{
 	  const char *str = construct_name_value (name_tmp, val_tmp, &gc);
 	  env_set_add (es, str);
@@ -799,17 +792,8 @@ setenv_str_ex (struct env_set *es,
 	  msg (M_INFO, "SETENV_ES '%s'", str);
 #endif
 	}
-      else
-	env_set_del (es, name_tmp);
-    }
   else
-    {
-      char *str = construct_name_value (name_tmp, val_tmp, NULL);
-      if (platform_putenv(str))
-      {
-        msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
-      }
-    }
+	env_set_del (es, name_tmp);
 
   gc_free (&gc);
 }
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index e79de7a..16d4dac 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -275,34 +275,6 @@ platform_unlink (const char *filename)
 #endif
 }
 
-int platform_putenv(char *string)
-{
-  int status;
-#if defined(WIN32)
-  struct gc_arena gc = gc_new ();
-  char *s = string_alloc(string, &gc);
-  char *value = strchr(s, '=');
-  if (value!=NULL)
-    {
-      *value = '\0';
-      value++;
-      if (*value == '\0')
-        value = NULL;
-    }
-
-  status = SetEnvironmentVariableW (wide_string (s, &gc),
-      wide_string (value, &gc)) ? 1: 0;
-  gc_free (&gc);
-#elif defined(HAVE_PUTENV)
-  void manage_env (char *str); /* TODO: Resolve properly */
-  status = putenv (string);
-  if (!status)
-    manage_env (string);
-#endif
-
-  return status;
-}
-
 FILE *
 platform_fopen (const char *path, const char *mode)
 {
-- 
1.7.9.5


