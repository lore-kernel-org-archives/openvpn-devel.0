From: David Sommerseth <davids@...1347...>
Date: Tue,  7 Feb 2012 11:58:53 +0100
Message-Id: <1328612333-10321-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix assert() situations where gc_malloc()
	is called without a gc_arena object
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

In commit bee92b479414d12035b0422f81ac5fcfe14fa645 the gc_malloc() was hardened
to always require a gc_arena object for garbage collection.  Some places in the
code expected the old behaviour of a normal malloc() in these cases, that is a
memory allocation without garbage collection.

This old behaviour is partly restored by allowing string_alloc() to do a non-gc
based allocation if no gc_arena object is available.  In addition some other
places string_alloc() will now be called with a gc_arena pointer where such an
object is available.

The alloc_buf() function has also been refactored to not use gc_malloc() at
all.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 buffer.c     |   25 ++++++++++++++++++++++---
 init.c       |    2 +-
 openvpn.c    |    2 +-
 options.c    |    2 ++
 pf.c         |    2 +-
 ssl_verify.c |    2 ++
 6 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/buffer.c b/buffer.c
index c39bbcb..f9335f0 100644
--- a/buffer.c
+++ b/buffer.c
@@ -54,11 +54,21 @@ alloc_buf_debug (size_t size, const char *file, int line)
 alloc_buf (size_t size)
 #endif
 {
+  struct buffer buf;
+
+  if (!buf_size_valid (size))
+    buf_size_error (size);
+  buf.capacity = (int)size;
+  buf.offset = 0;
+  buf.len = 0;
 #ifdef DMALLOC
-  return alloc_buf_gc_debug (size, NULL, file, line);
+  buf.data = openvpn_dmalloc (file, line, size);
 #else
-  return alloc_buf_gc (size, NULL);
+  buf.data = calloc (1, size);
 #endif
+  check_malloc_return(buf.data);
+
+  return buf;
 }
 
 struct buffer
@@ -518,7 +528,16 @@ string_alloc (const char *str, struct gc_arena *gc)
 #ifdef DMALLOC
       ret = (char *) gc_malloc_debug (n, false, gc, file, line);
 #else
-      ret = (char *) gc_malloc (n, false, gc);
+      if (gc) {
+        ret = (char *) gc_malloc (n, false, gc);
+      } else {
+        /* If there are no garbage collector available, it's expected
+         * that the caller cleans up afterwards.  This is coherent with the
+         * earlier behaviour when gc_malloc() would be called with gc == NULL
+         */
+        ret = calloc(1, n);
+        check_malloc_return(ret);
+      }
 #endif
       memcpy (ret, str, n);
       return ret;
diff --git a/init.c b/init.c
index 525f441..f0c3693 100644
--- a/init.c
+++ b/init.c
@@ -3012,7 +3012,7 @@ do_close_ifconfig_pool_persist (struct context *c)
 static void
 do_inherit_env (struct context *c, const struct env_set *src)
 {
-  c->c2.es = env_set_create (NULL);
+  c->c2.es = env_set_create (&c->c2.gc);
   c->c2.es_owned = true;
   env_set_inherit (c->c2.es, src);
 }
diff --git a/openvpn.c b/openvpn.c
index f5f2bce..84289d2 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -164,7 +164,7 @@ main (int argc, char *argv[])
 	  gc_init (&c.gc);
 
 	  /* initialize environmental variable store */
-	  c.es = env_set_create (NULL);
+	  c.es = env_set_create (&c.gc);
 #ifdef WIN32
 	  set_win_sys_path_via_env (c.es);
 #endif
diff --git a/options.c b/options.c
index 6b8ae22..bec11e5 100644
--- a/options.c
+++ b/options.c
@@ -4301,6 +4301,8 @@ add_option (struct options *options,
 	      msg( msglevel, "ifconfig-ipv6: /netbits must be between 64 and 124, not '/%d'", netbits );
 	      goto err;
 	    }
+          /* FIXME: Check if ipv6_local might miss a free().  It might leak
+           * via get_ipv6_addr() -> string_alloc() ? */
 	  options->ifconfig_ipv6_local = ipv6_local;
 	  options->ifconfig_ipv6_netbits = netbits;
 	  options->ifconfig_ipv6_remote = p[2];
diff --git a/pf.c b/pf.c
index 6b4cba4..79915fa 100644
--- a/pf.c
+++ b/pf.c
@@ -566,7 +566,7 @@ pf_init_context (struct context *c)
         if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
           {
             event_timeout_init (&c->c2.pf.reload, 1, now);
-            c->c2.pf.filename = string_alloc (pf_file, NULL);
+            c->c2.pf.filename = string_alloc (pf_file, &c->c2.gc);
             c->c2.pf.enabled = true;
 #ifdef ENABLE_DEBUG
             if (check_debug_level (D_PF_DEBUG))
diff --git a/ssl_verify.c b/ssl_verify.c
index e45f149..37d4982 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -83,6 +83,7 @@ set_common_name (struct tls_session *session, const char *common_name)
     }
   if (common_name)
     {
+      /* FIXME: Last alloc will never be freed */
       session->common_name = string_alloc (common_name, NULL);
 #ifdef ENABLE_PF
       {
@@ -703,6 +704,7 @@ man_def_auth_set_client_reason (struct tls_multi *multi, const char *client_reas
       multi->client_reason = NULL;
     }
   if (client_reason && strlen (client_reason))
+    /* FIXME: Last alloc will never be freed */
     multi->client_reason = string_alloc (client_reason, NULL);
 }
 
-- 
1.7.4.4


