From: ValdikSS <iam@...2070...>
Date: Sun,  7 Aug 2016 14:44:04 +0300
Message-Id: <1470570245-28327-2-git-send-email-iam@...2070...>
In-Reply-To: <1470570245-28327-1-git-send-email-iam@...2070...>
References: <1470570245-28327-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH 2/3] Do not pass env for system commands on
	Windows
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

---
 src/openvpn/route.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index c327866..822d02b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1487,7 +1487,7 @@ add_route (struct route_ipv4 *r,
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
       {
 	netcmd_semaphore_lock ();
-	status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add command failed");
+	status = openvpn_execve_check (&argv, NULL, 0, "ERROR: Windows route add command failed");
 	netcmd_semaphore_release ();
       }
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
@@ -1498,7 +1498,7 @@ add_route (struct route_ipv4 *r,
 	  {
 	    msg (D_ROUTE, "Route addition fallback to route.exe");
 	    netcmd_semaphore_lock ();
-	    status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add command failed [adaptive]");
+	    status = openvpn_execve_check (&argv, NULL, 0, "ERROR: Windows route add command failed [adaptive]");
 	    netcmd_semaphore_release ();
 	  }
       }
@@ -1827,7 +1827,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
       argv_msg (D_ROUTE, &argv);
 
       netcmd_semaphore_lock ();
-      status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add ipv6 command failed");
+      status = openvpn_execve_check (&argv, NULL, 0, "ERROR: Windows route add ipv6 command failed");
       netcmd_semaphore_release ();
     }
 
@@ -1993,7 +1993,7 @@ delete_route (struct route_ipv4 *r,
   else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
     {
       netcmd_semaphore_lock ();
-      openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete command failed");
+      openvpn_execve_check (&argv, NULL, 0, "ERROR: Windows route delete command failed");
       netcmd_semaphore_release ();
     }
   else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
@@ -2004,7 +2004,7 @@ delete_route (struct route_ipv4 *r,
 	{
 	  msg (D_ROUTE, "Route deletion fallback to route.exe");
 	  netcmd_semaphore_lock ();
-	  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete command failed [adaptive]");
+	  openvpn_execve_check (&argv, NULL, 0, "ERROR: Windows route delete command failed [adaptive]");
 	  netcmd_semaphore_release ();
 	}
     }
@@ -2241,7 +2241,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
       argv_msg (D_ROUTE, &argv);
 
       netcmd_semaphore_lock ();
-      openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete ipv6 command failed");
+      openvpn_execve_check (&argv, NULL, 0, "ERROR: Windows route delete ipv6 command failed");
       netcmd_semaphore_release ();
     }
 
-- 
2.5.5


