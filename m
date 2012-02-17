From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Feb 2012 09:39:35 +0100
Message-ID: <1329467975-30716-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] move variable declaration to top of function
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

MSVC chokes on this as it's not according to C89.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/buffer.c b/buffer.c
index 6800e6e..391085b 100644
--- a/buffer.c
+++ b/buffer.c
@@ -321,9 +321,9 @@ gc_malloc (size_t size, bool clear, struct gc_arena *a)
 #endif
 {
   void *ret;
+  struct gc_entry *e;
   ASSERT (NULL != a);
 
-  struct gc_entry *e;
 #ifdef DMALLOC
   e = (struct gc_entry *) openvpn_dmalloc (file, line, size + sizeof (struct gc_entry));
 #else
-- 
1.7.5.4


