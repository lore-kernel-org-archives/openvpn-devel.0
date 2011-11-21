MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Mon, 21 Nov 2011 12:59:24 +0100
Message-id: <1321876765-16500-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix FreeBSD/OpenBSD/NetBSD compiler
 warnings in get_default_gateway()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On these platforms (including DragonFly), get_default_gateway() would in some
cases return false.  As get_default_gateway() is defined as a void function, and
none of the callers expect a return value -> just return without any value.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 route.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/route.c b/route.c
index d632b45..be23a89 100644
--- a/route.c
+++ b/route.c
@@ -2581,7 +2581,7 @@ get_default_gateway (struct route_gateway_info *rgi)
       warn("writing to routing socket");
       gc_free (&gc);
       close(s);
-      return false;
+      return;
     }
 
   do {
@@ -2605,7 +2605,7 @@ get_default_gateway (struct route_gateway_info *rgi)
   else
     {
       gc_free (&gc);
-      return false;
+      return;
     }
 
 
@@ -2947,7 +2947,7 @@ get_default_gateway (struct route_gateway_info *rgi)
       warn("writing to routing socket");
       gc_free (&gc);
       close(s);
-      return false;
+      return;
     }
 
   do {
@@ -2971,7 +2971,7 @@ get_default_gateway (struct route_gateway_info *rgi)
   else
     {
       gc_free (&gc);
-      return false;
+      return;
     }
 
 
-- 
1.7.4.4


