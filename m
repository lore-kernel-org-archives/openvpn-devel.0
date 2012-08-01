From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 1 Aug 2012 13:37:37 +0200
Message-ID: <1343821058-11456-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] add x_msg_va() log function
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

This change allows other functions to access the functionality in x_msg().
Needed for the plug-in logging API.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/error.c |   11 ++++++++---
 src/openvpn/error.h |    2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 8396fe0..6848425 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -201,8 +201,15 @@ int x_msg_line_num; /* GLOBAL */
 
 void x_msg (const unsigned int flags, const char *format, ...)
 {
-  struct gc_arena gc;
   va_list arglist;
+  va_start (arglist, format);
+  x_msg_va (flags, format, arglist);
+  va_end (arglist);
+}
+
+void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
+{
+  struct gc_arena gc;
 #if SYSLOG_CAPABILITY
   int level;
 #endif
@@ -237,9 +244,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
   m1 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
   m2 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
 
-  va_start (arglist, format);
   vsnprintf (m1, ERR_BUF_SIZE, format, arglist);
-  va_end (arglist);
   m1[ERR_BUF_SIZE - 1] = 0; /* windows vsnprintf needs this */
 
   if ((flags & M_ERRNO) && e)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index aedb7c3..27c48b6 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -182,6 +182,8 @@ void x_msg (const unsigned int flags, const char *format, ...)
 #endif
     ; /* should be called via msg above */
 
+void x_msg_va (const unsigned int flags, const char *format, va_list arglist);
+
 /*
  * Function prototypes
  */
-- 
1.7.9.5


