From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:43 +0200
Message-Id: <1330546342-17794-14-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 13/52] build: handle printf style format in
	mingw
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 buffer.h |   12 ++++++++++--
 error.h  |    6 +++++-
 misc.h   |   12 ++++++++++--
 status.h |    6 +++++-
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/buffer.h b/buffer.h
index 6c79007..9bc33db 100644
--- a/buffer.h
+++ b/buffer.h
@@ -312,7 +312,11 @@ has_digit (const unsigned char* src)
  */
 bool buf_printf (struct buffer *buf, const char *format, ...)
 #ifdef __GNUC__
-    __attribute__ ((format (printf, 2, 3)))
+#if __USE_MINGW_ANSI_STDIO
+	__attribute__ ((format (gnu_printf, 2, 3)))
+#else
+	__attribute__ ((format (__printf__, 2, 3)))
+#endif
 #endif
     ;
 
@@ -326,7 +330,11 @@ bool buf_puts (struct buffer *buf, const char *str);
  */
 bool openvpn_snprintf(char *str, size_t size, const char *format, ...)
 #ifdef __GNUC__
-    __attribute__ ((format (printf, 3, 4)))
+#if __USE_MINGW_ANSI_STDIO
+	__attribute__ ((format (gnu_printf, 3, 4)))
+#else
+	__attribute__ ((format (__printf__, 3, 4)))
+#endif
 #endif
     ;
 
diff --git a/error.h b/error.h
index aafd055..d2c04b0 100644
--- a/error.h
+++ b/error.h
@@ -178,7 +178,11 @@ bool dont_mute (unsigned int flags); /* check muting filter */
 
 void x_msg (const unsigned int flags, const char *format, ...)
 #ifdef __GNUC__
-    __attribute__ ((format (printf, 2, 3)))
+#if __USE_MINGW_ANSI_STDIO
+	__attribute__ ((format (gnu_printf, 2, 3)))
+#else
+	__attribute__ ((format (__printf__, 2, 3)))
+#endif
 #endif
     ; /* should be called via msg above */
 
diff --git a/misc.h b/misc.h
index dd6bd5a..a9548c5 100644
--- a/misc.h
+++ b/misc.h
@@ -435,13 +435,21 @@ void argv_printf_arglist (struct argv *a, const char *format, const unsigned int
 
 void argv_printf (struct argv *a, const char *format, ...)
 #ifdef __GNUC__
-  __attribute__ ((format (printf, 2, 3)))
+#if __USE_MINGW_ANSI_STDIO
+	__attribute__ ((format (gnu_printf, 2, 3)))
+#else
+	__attribute__ ((format (__printf__, 2, 3)))
+#endif
 #endif
   ;
 
 void argv_printf_cat (struct argv *a, const char *format, ...)
 #ifdef __GNUC__
-  __attribute__ ((format (printf, 2, 3)))
+#if __USE_MINGW_ANSI_STDIO
+	__attribute__ ((format (gnu_printf, 2, 3)))
+#else
+	__attribute__ ((format (__printf__, 2, 3)))
+#endif
 #endif
   ;
 
diff --git a/status.h b/status.h
index 0bdad4e..af16fd2 100644
--- a/status.h
+++ b/status.h
@@ -77,7 +77,11 @@ void status_flush (struct status_output *so);
 bool status_close (struct status_output *so);
 void status_printf (struct status_output *so, const char *format, ...)
 #ifdef __GNUC__
-    __attribute__ ((format (printf, 2, 3)))
+#if __USE_MINGW_ANSI_STDIO
+	__attribute__ ((format (gnu_printf, 2, 3)))
+#else
+	__attribute__ ((format (__printf__, 2, 3)))
+#endif
 #endif
     ;
 
-- 
1.7.3.4


