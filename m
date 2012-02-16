From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Feb 2012 18:30:38 +0100
Message-ID: <1329413441-22538-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] replace check for TARGET_WIN32 with
	WIN32
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

Use of TARGET_WIN32 breaks MSVC builds as it is only defined
for mingw builds done with the autotools buildsystem.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 misc.c    |    6 +++---
 misc.h    |    6 +++---
 openvpn.c |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc.c b/misc.c
index 58096fa..a07780f 100644
--- a/misc.c
+++ b/misc.c
@@ -356,7 +356,7 @@ int
 openvpn_chdir (const char* dir)
 {
 #ifdef HAVE_CHDIR
-#ifdef TARGET_WIN32
+#ifdef WIN32
   int res;
   struct gc_arena gc = gc_new ();
   res = _wchdir (wide_string (dir, &gc));
@@ -598,7 +598,7 @@ openvpn_system (const char *command, const struct env_set *es, unsigned int flag
   /*
    * execute the command
    */
-#ifdef TARGET_WIN32
+#ifdef WIN32
   gc = gc_new ();
   ret = _wsystem (wide_string (command, &gc));
   gc_free (&gc);
@@ -627,7 +627,7 @@ openvpn_system (const char *command, const struct env_set *es, unsigned int flag
 int
 openvpn_access (const char *path, int mode)
 {
-#ifdef TARGET_WIN32
+#ifdef WIN32
   struct gc_arena gc = gc_new ();
   int ret = _waccess (wide_string (path, &gc), mode);
   gc_free (&gc);
diff --git a/misc.h b/misc.h
index 2413f53..8c0bae1 100644
--- a/misc.h
+++ b/misc.h
@@ -147,7 +147,7 @@ openvpn_run_script (const struct argv *a, const struct env_set *es, const unsign
   return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
 };
 
-#ifdef TARGET_WIN32
+#ifdef WIN32
 FILE * openvpn_fopen (const char *path, const char *mode);
 #else
 static inline FILE *
@@ -157,7 +157,7 @@ openvpn_fopen (const char *path, const char *mode)
 }
 #endif
 
-#ifdef TARGET_WIN32
+#ifdef WIN32
 int openvpn_open (const char *path, int flags, mode_t mode);
 #else
 static inline int
@@ -167,7 +167,7 @@ openvpn_open (const char *path, int flags, mode_t mode)
 }
 #endif
 
-#ifdef TARGET_WIN32
+#ifdef WIN32
 int openvpn_stat (const char *path, struct stat *buf);
 #else
 static inline int
diff --git a/openvpn.c b/openvpn.c
index 84289d2..b2175a1 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -131,7 +131,7 @@ main (int argc, char *argv[])
   return 1;
 #endif
 
-#ifdef TARGET_WIN32
+#ifdef WIN32
   SetConsoleOutputCP (CP_UTF8);
 #endif
 
-- 
1.7.5.4


