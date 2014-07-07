From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Jul 2014 14:12:22 +0200
Message-Id: <1404735142-31420-4-git-send-email-arne@...1227...>
In-Reply-To: <1404735142-31420-1-git-send-email-arne@...1227...>
References: <1404735142-31420-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/4] Remove ENABLE_BUFFER_LIST
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

it is unconditionally enabled and OpenVPN does not compile if disabled
---
 src/openvpn/buffer.c  | 5 -----
 src/openvpn/buffer.h  | 6 ------
 src/openvpn/syshead.h | 5 -----
 3 files changed, 16 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 3661141..46f874b 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -976,9 +976,6 @@ valign4 (const struct buffer *buf, const char *file, const int line)
 /*
  * struct buffer_list
  */
-
-#ifdef ENABLE_BUFFER_LIST
-
 struct buffer_list *
 buffer_list_new (const int max_size)
 {
@@ -1154,5 +1151,3 @@ buffer_list_file (const char *fn, int max_line_len)
     }
   return bl;
 }
-
-#endif
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 19fa1fa..7469da6 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -904,9 +904,6 @@ check_malloc_return (void *p)
 /*
  * Manage lists of buffers
  */
-
-#ifdef ENABLE_BUFFER_LIST
-
 struct buffer_entry
 {
   struct buffer buf;
@@ -936,7 +933,4 @@ void buffer_list_pop (struct buffer_list *ol);
 void buffer_list_aggregate (struct buffer_list *bl, const size_t max);
 
 struct buffer_list *buffer_list_file (const char *fn, int max_line_len);
-
-#endif
-
 #endif /* BUFFER_H */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index fb07160..dc511cb 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -594,11 +594,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Compile the struct buffer_list code
- */
-#define ENABLE_BUFFER_LIST
-
-/*
  * Should we include OCC (options consistency check) code?
  */
 #ifndef ENABLE_SMALL
-- 
1.8.5.2 (Apple Git-48)


