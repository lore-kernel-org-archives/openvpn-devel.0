From: David Sommerseth <davids@...1347...>
Date: Thu, 16 Feb 2012 19:47:25 +0100
Message-Id: <1329418045-3218-1-git-send-email-davids@...1347...>
In-Reply-To: <20120216182908.GM7024@...1296...>
References: <20120216182908.GM7024@...1296...>
Subject: [Openvpn-devel] [PATCH v2] use the underscore version of stat on
	Windows
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

From: Heiko Hund <heiko.hund@...1489...>

MSVC does not know wstat(). Instead _wstat() must be used here.
Unfortunately _wstat() takes a 'struct _stat'. A type 'stat_t' is
introduced to handle this situation in a portable way.

[v2: Use openvpn_stat_t instead of stat_t (David Sommerseth)]

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
Signed-off-by: David Sommerseth <davids@...1347...>
---
 misc.h  |    6 ++++--
 pf.c    |    2 +-
 win32.c |    4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/misc.h b/misc.h
index e7a0b55..bdada42 100644
--- a/misc.h
+++ b/misc.h
@@ -168,10 +168,12 @@ openvpn_open (const char *path, int flags, mode_t mode)
 #endif
 
 #ifdef WIN32
-int openvpn_stat (const char *path, struct stat *buf);
+typedef struct _stat openvpn_stat_t;
+int openvpn_stat (const char *path, openvpn_stat_t *buf);
 #else
+typedef struct stat openvpn_stat_t;
 static inline int
-openvpn_stat (const char *path, struct stat *buf)
+openvpn_stat (const char *path, openvpn_stat_t *buf)
 {
   return stat (path, buf);
 }
diff --git a/pf.c b/pf.c
index a0e9fc8..0ef839e 100644
--- a/pf.c
+++ b/pf.c
@@ -498,7 +498,7 @@ pf_check_reload (struct context *c)
       && c->c2.pf.filename
       && event_timeout_trigger (&c->c2.pf.reload, &c->c2.timeval, ETT_DEFAULT))
     {
-      struct stat s;
+      openvpn_stat_t s;
       if (!openvpn_stat (c->c2.pf.filename, &s))
 	{
 	  if (s.st_mtime > c->c2.pf.file_last_mod)
diff --git a/win32.c b/win32.c
index a8f4ed9..2ba97fc 100644
--- a/win32.c
+++ b/win32.c
@@ -1073,10 +1073,10 @@ openvpn_open (const char *path, int flags, int mode)
 }
 
 int
-openvpn_stat (const char *path, struct stat *buf)
+openvpn_stat (const char *path, openvpn_stat_t *buf)
 {
   struct gc_arena gc = gc_new ();
-  int res = wstat (wide_string (path, &gc), buf);
+  int res = _wstat (wide_string (path, &gc), buf);
   gc_free (&gc);
   return res;
 }
-- 
1.7.4.4


