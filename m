From: David Sommerseth <dazo@...384...>
Date: Tue,  6 Nov 2012 11:03:36 +0100
Message-Id: <1352196216-11560-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Fix double-free issue in
	pf_destroy_context()
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

From: David Sommerseth <davids@...1347...>

In commit dc7be6d078ba106f9b0de12f3e879c3561c3c537 the string_alloc() call
in pf_init_context() was modified to use the gc_arena object for memory
allocation.  What was not taken into consideration was that pf_destroy_context()
was also freeing memory allocated by string_alloc(), and when pf_init_context()
is calling gc_free() a double-free situation showed up.

Lets remove the explict free, and let gc_free take care of all the memory handling.

Reported-by: cuzz@...1781...
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/pf.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 3c46801..aafe9ff 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -606,7 +606,6 @@ pf_destroy_context (struct pf_context *pfc)
   if (pfc->filename)
     {
       platform_unlink (pfc->filename);
-      free (pfc->filename);
     }
 #endif
   if (pfc->pfs)
-- 
1.7.10.2


