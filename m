Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:25 +0200
Message-Id: <1412978966-15392-9-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
References: <5437B156.1020408@...1114...>
	<1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH 8/9] client-connect: Add deferred support to
	the client-connect script handler
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

This patch introduces the concept of a return value file for the client-connect
handlers. (This is very similar to the auth value file used during deferred
authentication.)  The file name is stored in the client_connect_state struct.

In addition, the patch also allows the storage of the client config file name
in struct client_connect_state.

Both changes are used by the client-connect script handler to support deferred
client-connection handling.  The deferred return value file (deferred_ret_file)
is passed to the actual script via the environment.  If the script succeeds and
writes the value for deferral into the deferred_ret_file, the handler knows to
indicate deferral.  Later on, the deferred handler checks whether the value of
the deferred_ret_file has been updated to success or failure.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/multi.h |   3 +
 2 files changed, 171 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c044d67..a3d94fa 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1610,6 +1610,125 @@ multi_client_connect_early_setup (struct multi_context *m,
   multi_client_connect_setenv (m, mi);
 }
 
+
+static void
+ccs_delete_deferred_ret_file (struct multi_instance *mi)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  if (ccs->deferred_ret_file)
+    {
+      setenv_del (mi->context.c2.es, "client_connect_deferred_file");
+      platform_unlink (ccs->deferred_ret_file);
+      free (ccs->deferred_ret_file);
+      ccs->deferred_ret_file = NULL;
+    }
+}
+
+static bool
+ccs_gen_deferred_ret_file (struct multi_instance *mi)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  struct gc_arena gc = gc_new ();
+  const char *fn;
+
+  if (ccs->deferred_ret_file)
+    ccs_delete_deferred_ret_file (mi);
+
+  fn = create_temp_file (mi->context.options.tmp_dir, "ccr", &gc);
+  if (!fn)
+    {
+      gc_free (&gc);
+      return false;
+    }
+  ccs->deferred_ret_file = string_alloc (fn, NULL);
+
+  setenv_str (mi->context.c2.es, "client_connect_deferred_file",
+	      ccs->deferred_ret_file);
+
+  gc_free (&gc);
+  return true;
+}
+
+/*
+ * Tests whether the deferred return value file exists and returns the
+ * contained return value.
+ *
+ * Returns CC_RET_SKIPPED if the file doesn't exist or is empty.
+ * Returns CC_RET_DEFERRED, CC_RET_SUCCEEDED or CC_RET_FAILED depending on
+ * the value stored in the file.
+ */
+static enum client_connect_return
+ccs_test_deferred_ret_file (struct multi_instance *mi)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  enum client_connect_return ret = CC_RET_SKIPPED;
+  FILE *fp = fopen (ccs->deferred_ret_file, "r");
+  if (fp)
+    {
+      const int c = fgetc (fp);
+      switch (c)
+	{
+	case '0':
+	  ret = CC_RET_FAILED;
+	  break;
+	case '1':
+	  ret = CC_RET_SUCCEEDED;
+	  break;
+	case '2':
+	  ret = CC_RET_DEFERRED;
+	  break;
+	case EOF:
+	  ret = CC_RET_SKIPPED;
+	  break;
+	default:
+	  /* We received an unknown/unexpected value.  Assume failure. */
+	  ret = CC_RET_FAILED;
+	}
+      fclose (fp);
+    }
+  return ret;
+}
+
+
+static void
+ccs_delete_config_file (struct multi_instance *mi)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  if (ccs->config_file)
+    {
+      setenv_del (mi->context.c2.es, "client_connect_config_file");
+      platform_unlink (ccs->config_file);
+      free (ccs->config_file);
+      ccs->config_file = NULL;
+    }
+}
+
+static bool
+ccs_gen_config_file (struct multi_instance *mi)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  struct gc_arena gc = gc_new ();
+  const char *fn;
+
+  if (ccs->config_file)
+    ccs_delete_config_file (mi);
+
+  fn = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
+  if (!fn)
+    {
+      gc_free (&gc);
+      return false;
+    }
+  ccs->config_file = string_alloc (fn, NULL);
+
+  setenv_str (mi->context.c2.es, "client_connect_config_file",
+	      ccs->config_file);
+
+  gc_free (&gc);
+  return true;
+}
+
+
 /*
  * Try to source a dynamic config file from the
  * --client-config-dir directory.
@@ -1775,14 +1894,14 @@ multi_client_connect_call_script (struct multi_context *m,
 
   if (mi->context.options.client_connect_script)
     {
-      struct gc_arena gc = gc_new ();
+      struct client_connect_state *ccs = mi->client_connect_state;
       struct argv argv = argv_new ();
-      const char *dc_file;
+      ASSERT (ccs);
 
       setenv_str (mi->context.c2.es, "script_type", "client-connect");
 
-      dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
-      if (!dc_file)
+      if (!ccs_gen_config_file (mi) ||
+	  !ccs_gen_deferred_ret_file (mi))
 	{
 	  ret = CC_RET_FAILED;
 	  goto script_failed;
@@ -1790,19 +1909,56 @@ multi_client_connect_call_script (struct multi_context *m,
 
       argv_printf (&argv, "%sc %s",
 		   mi->context.options.client_connect_script,
-		   dc_file);
+		   ccs->config_file);
 
       if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
 	{
-	  multi_client_connect_post (m, mi, dc_file, option_types_found);
-	  ret = CC_RET_SUCCEEDED;
+	  if (ccs_test_deferred_ret_file (mi) == CC_RET_DEFERRED)
+	    ret = CC_RET_DEFERRED;
+	  else
+	    {
+	      multi_client_connect_post (m, mi, ccs->config_file,
+					 option_types_found);
+	      ret = CC_RET_SUCCEEDED;
+	    }
 	}
       else
 	ret = CC_RET_FAILED;
 
 script_failed:
+      if (ret != CC_RET_DEFERRED)
+	{
+	  ccs_delete_config_file (mi);
+	  ccs_delete_deferred_ret_file (mi);
+	}
+
       argv_reset (&argv);
-      gc_free (&gc);
+    }
+  return ret;
+}
+
+static enum client_connect_return
+multi_client_handle_deferred (struct multi_context *m,
+			      struct multi_instance *mi,
+			      unsigned int *option_types_found)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  enum client_connect_return ret = CC_RET_SKIPPED;
+  ASSERT (option_types_found);
+  ASSERT (ccs);
+
+  ret = ccs_test_deferred_ret_file (mi);
+
+  if (ret == CC_RET_SKIPPED)
+    /* Skipped and deferred are equivalent in this context. */
+    ret = CC_RET_DEFERRED;
+
+  if (ret != CC_RET_DEFERRED)
+    {
+      ccs_delete_deferred_ret_file (mi);
+
+      multi_client_connect_post (m, mi, ccs->config_file, option_types_found);
+      ccs_delete_config_file (mi);
     }
   return ret;
 }
@@ -1945,6 +2101,9 @@ delete_client_connect_state (struct multi_instance *mi)
   ASSERT (mi);
   if (mi->client_connect_state)
     {
+      ccs_delete_deferred_ret_file (mi);
+      ccs_delete_config_file (mi);
+
       free (mi->client_connect_state);
       mi->client_connect_state = NULL;
     }
@@ -1975,7 +2134,7 @@ static const struct client_connect_handlers client_connect_handlers[] = {
   },
   {
     main: multi_client_connect_call_script,
-    deferred: multi_client_connect_fail
+    deferred: multi_client_handle_deferred
   },
   {
     main: multi_client_connect_mda,
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 16dd99d..137228d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -69,6 +69,9 @@ struct client_connect_state
   /* Remember which option classes where processed for delayed option
      handling. */
   unsigned int option_types_found;
+
+  char *deferred_ret_file;
+  char *config_file;
 };
 
 /**
-- 
2.1.1


