From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 21 Feb 2012 17:44:13 +0000
Message-ID: <1329846253-23464-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <20120220213246.GV7024@...1296...>
References: <20120220213246.GV7024@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mask out X_OK when calling WIN32 API
	_waccess()
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

This reverts commit 4ebc587e. Instead of defining X_OK 0 for MSVC,
this undefined mode value is now simply masked out close to where
it causes the trouble; in the call to _waccess() as suggested
during the discussion on the development mailing list:
http://thread.gmane.org/gmane.network.openvpn.devel/5452

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 misc.c          |    2 +-
 win/config.h.in |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc.c b/misc.c
index a07780f..67345bc 100644
--- a/misc.c
+++ b/misc.c
@@ -629,7 +629,7 @@ openvpn_access (const char *path, int mode)
 {
 #ifdef WIN32
   struct gc_arena gc = gc_new ();
-  int ret = _waccess (wide_string (path, &gc), mode);
+  int ret = _waccess (wide_string (path, &gc), mode & ~X_OK);
   gc_free (&gc);
   return ret;
 #else
diff --git a/win/config.h.in b/win/config.h.in
index fcb8d6c..b5c31b8 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -243,7 +243,7 @@ typedef unsigned long in_addr_t;
 #endif
 
 #ifndef X_OK
-#define X_OK 0
+#define X_OK 1
 #endif
 
 #ifndef F_OK
-- 
1.7.8.3


