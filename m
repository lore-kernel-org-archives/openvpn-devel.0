From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 May 2016 23:12:50 -0400
Message-Id: <1463195570-27908-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH (master)] Properly handle possible realloc
	failure
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d83ea65..5ff80fa 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1326,15 +1326,19 @@ UpdateWaitHandles (LPHANDLE *handles_ptr, LPDWORD count,
       if (pos == size)
         {
           size += 10;
-          handles = realloc (handles, size * sizeof (HANDLE));
-          if (handles == NULL)
+          LPHANDLE tmp = realloc (handles, size * sizeof (HANDLE));
+          if (tmp == NULL)
             return ERROR_OUTOFMEMORY;
+          else
+            {
+              handles = tmp;
+              *handles_ptr = handles;
+            }
         }
       handles[pos++] = threads->data;
       threads = threads->next;
     }
 
-  *handles_ptr = handles;
   *count = pos;
   return NO_ERROR;
 }
-- 
1.7.10.4

