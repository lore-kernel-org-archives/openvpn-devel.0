From: Adriaan de Jong <dejong@...1435...>
Date: Sun, 5 Feb 2012 12:51:25 +0100
Message-ID: <1328442685-8550-2-git-send-email-dejong@...1435...>
In-Reply-To: <1328442685-8550-1-git-send-email-dejong@...1435...>
References: <1328442685-8550-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Removed support for calling gc_malloc
	with a NULL gc_arena struct
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 buffer.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/buffer.c b/buffer.c
index 2f8e4b8..c39bbcb 100644
--- a/buffer.c
+++ b/buffer.c
@@ -310,28 +310,19 @@ gc_malloc (size_t size, bool clear, struct gc_arena *a)
 #endif
 {
   void *ret;
-  if (a)
-    {
-      struct gc_entry *e;
-#ifdef DMALLOC
-      e = (struct gc_entry *) openvpn_dmalloc (file, line, size + sizeof (struct gc_entry));
-#else
-      e = (struct gc_entry *) malloc (size + sizeof (struct gc_entry));
-#endif
-      check_malloc_return (e);
-      ret = (char *) e + sizeof (struct gc_entry);
-      e->next = a->list;
-      a->list = e;
-    }
-  else
-    {
+  ASSERT (NULL != a);
+
+  struct gc_entry *e;
 #ifdef DMALLOC
-      ret = openvpn_dmalloc (file, line, size);
+  e = (struct gc_entry *) openvpn_dmalloc (file, line, size + sizeof (struct gc_entry));
 #else
-      ret = malloc (size);
+  e = (struct gc_entry *) malloc (size + sizeof (struct gc_entry));
 #endif
-      check_malloc_return (ret);
-    }
+  check_malloc_return (e);
+  ret = (char *) e + sizeof (struct gc_entry);
+  e->next = a->list;
+  a->list = e;
+
 #ifndef ZERO_BUFFER_ON_ALLOC
   if (clear)
 #endif
-- 
1.7.5.4


