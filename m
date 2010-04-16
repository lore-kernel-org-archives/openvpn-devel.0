From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 16 Apr 2010 22:21:51 +0200
Message-Id: <1271449313-26315-2-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 1/3] Harden create_temp_filename()
	(version 2)
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

By hardening the create_temp_filename() function to check if the generated
filename exists and to create the temp file with only S_IRUSR|S_IWUSR bit
files set before calling the script, it should become even more difficult to
exploit such a scenario.

After a discussion on the mailing list, Fabian Knittel provided an enhanced
version of the inital patch which is added to this patch.

This patch also renames create_temp_filename() to create_temp_file(), as this
patch also creates the temporary file.  The function returns the filename of the
created file, or NULL on error.

Signed-off-by: David Sommerseth <dazo@...384...>
Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 misc.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 misc.h |    4 ++--
 2 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/misc.c b/misc.c
index b52a042..643ffad 100644
--- a/misc.c
+++ b/misc.c
@@ -1165,25 +1165,57 @@ test_file (const char *filename)
 
 /* create a temporary filename in directory */
 const char *
-create_temp_filename (const char *directory, const char *prefix, struct gc_arena *gc)
+create_temp_file (const char *directory, const char *prefix, struct gc_arena *gc)
 {
   static unsigned int counter;
   struct buffer fname = alloc_buf_gc (256, gc);
+  int fd;
+  const char *retfname = NULL;
+  unsigned int attempts = 0;
 
-  mutex_lock_static (L_CREATE_TEMP);
-  ++counter;
-  mutex_unlock_static (L_CREATE_TEMP);
-
-  {
-    uint8_t rndbytes[16];
-    const char *rndstr;
-
-    prng_bytes (rndbytes, sizeof (rndbytes));
-    rndstr = format_hex_ex (rndbytes, sizeof (rndbytes), 40, 0, NULL, gc);
-    buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
-  }
+  do
+    {
+      uint8_t rndbytes[16];
+      const char *rndstr;
+
+      ++attempts;
+      mutex_lock_static (L_CREATE_TEMP);
+      ++counter;
+      mutex_unlock_static (L_CREATE_TEMP);
+
+      prng_bytes (rndbytes, sizeof rndbytes);
+      rndstr = format_hex_ex (rndbytes, sizeof rndbytes, 40, 0, NULL, gc);
+      buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
+
+      retfname = gen_path (directory, BSTR (&fname), gc);
+      if (!retfname)
+        {
+          msg (M_FATAL, "Failed to create temporary filename and path");
+          return NULL;
+        }
+
+      /* Atomically create the file.  Errors out if the file already
+         exists.  */
+      fd = open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
+      if (fd != -1)
+        {
+          close (fd);
+          return retfname;
+        }
+      else if (fd == -1 && errno != EEXIST)
+        {
+          /* Something else went wrong, no need to retry.  */
+          struct gc_arena gcerr = gc_new ();
+          msg (M_FATAL, "Could not create temporary file '%s': %s",
+               retfname, strerror_ts (errno, &gcerr));
+          gc_free (&gcerr);
+          return NULL;
+        }
+    }
+  while (attempts < 6);
 
-  return gen_path (directory, BSTR (&fname), gc);
+  msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
+  return NULL;
 }
 
 /*
diff --git a/misc.h b/misc.h
index bf51e89..e3ce19e 100644
--- a/misc.h
+++ b/misc.h
@@ -218,8 +218,8 @@ long int get_random(void);
 /* return true if filename can be opened for read */
 bool test_file (const char *filename);
 
-/* create a temporary filename in directory */
-const char *create_temp_filename (const char *directory, const char *prefix, struct gc_arena *gc);
+/* create a temporary file in directory, returns the filename of the created file */
+const char *create_temp_file (const char *directory, const char *prefix, struct gc_arena *gc);
 
 /* put a directory and filename together */
 const char *gen_path (const char *directory, const char *filename, struct gc_arena *gc);
-- 
1.6.6.1


