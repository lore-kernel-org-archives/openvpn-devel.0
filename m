From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Feb 2012 18:30:39 +0100
Message-ID: <1329413441-22538-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] do not use mode_t on Windows
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

The MSVC headers do not define mode_t. open() uses an int for
the permissions instead. Fixes building with the MSVC based
buildsystem.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 misc.h  |    2 +-
 win32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc.h b/misc.h
index 8c0bae1..e7a0b55 100644
--- a/misc.h
+++ b/misc.h
@@ -158,7 +158,7 @@ openvpn_fopen (const char *path, const char *mode)
 #endif
 
 #ifdef WIN32
-int openvpn_open (const char *path, int flags, mode_t mode);
+int openvpn_open (const char *path, int flags, int mode);
 #else
 static inline int
 openvpn_open (const char *path, int flags, mode_t mode)
diff --git a/win32.c b/win32.c
index 5b38918..a8f4ed9 100644
--- a/win32.c
+++ b/win32.c
@@ -1064,7 +1064,7 @@ openvpn_fopen (const char *path, const char *mode)
 }
 
 int
-openvpn_open (const char *path, int flags, mode_t mode)
+openvpn_open (const char *path, int flags, int mode)
 {
   struct gc_arena gc = gc_new ();
   int fd = _wopen (wide_string (path, &gc), flags, mode);
-- 
1.7.5.4


