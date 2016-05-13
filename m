From: Selva Nair <selva.nair@...277...>
Date: Thu, 12 May 2016 22:40:45 -0400
Message-Id: <1463107245-30999-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1463107245-30999-1-git-send-email-selva.nair@...277...>
References: <1463107245-30999-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH master] Make error non-fatal while deleting
	address using netsh
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

Fixes Trac #71 (see comments 37 to 43)

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/tun.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index c87fb36..f79d067 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -68,7 +68,7 @@ static void netsh_ifconfig (const struct tuntap_options *to,
 			    const in_addr_t ip,
 			    const in_addr_t netmask,
 			    const unsigned int flags);
-static void netsh_command (const struct argv *a, int n);
+static void netsh_command (const struct argv *a, int n, int msglevel);
 
 static const char *netsh_get_id (const char *dev_node, struct gc_arena *gc);
 
@@ -1398,7 +1398,7 @@ do_ifconfig (struct tuntap *tt,
 			 NETSH_PATH_SUFFIX,
 			 iface,
 			 ifconfig_ipv6_local );
-	    netsh_command (&argv, 4);
+	    netsh_command (&argv, 4, M_FATAL);
 	  }
 
 	/* explicit route needed */
@@ -4597,7 +4597,7 @@ dhcp_renew (const struct tuntap *tt)
  */
 
 static void
-netsh_command (const struct argv *a, int n)
+netsh_command (const struct argv *a, int n, int msglevel)
 {
   int i;
   for (i = 0; i < n; ++i)
@@ -4612,7 +4612,7 @@ netsh_command (const struct argv *a, int n)
 	return;
       openvpn_sleep (4);
     }
-  msg (M_FATAL, "NETSH: command failed");
+  msg (msglevel, "NETSH: command failed");
 }
 
 void
@@ -4762,7 +4762,7 @@ netsh_ifconfig_options (const char *type,
 		   NETSH_PATH_SUFFIX,
 		   type,
 		   flex_name);
-      netsh_command (&argv, 2);
+      netsh_command (&argv, 2, M_FATAL);
     }
 
   /* add new DNS/WINS settings to TAP interface */
@@ -4783,7 +4783,7 @@ netsh_ifconfig_options (const char *type,
 			 type,
 			 flex_name,
 			 print_in_addr_t (addr_list[i], 0, &gc));
-	    netsh_command (&argv, 2);
+	    netsh_command (&argv, 2, M_FATAL);
 	  
 	    ++count;
 	  }
@@ -4858,7 +4858,7 @@ netsh_ifconfig (const struct tuntap_options *to,
 		       print_in_addr_t (ip, 0, &gc),
 		       print_in_addr_t (netmask, 0, &gc));
 
-	  netsh_command (&argv, 4);
+	  netsh_command (&argv, 4, M_FATAL);
 	}
     }
 
@@ -4904,7 +4904,7 @@ netsh_enable_dhcp (const struct tuntap_options *to,
 	       NETSH_PATH_SUFFIX,
 	       actual_name);
 
-  netsh_command (&argv, 4);
+  netsh_command (&argv, 4, M_FATAL);
 
   argv_reset (&argv);
 }
@@ -5648,7 +5648,7 @@ close_tun (struct tuntap *tt)
                            tt->actual_name,
                            ifconfig_ipv6_local);
 
-              netsh_command (&argv, 1);
+              netsh_command (&argv, 1, M_WARN);
               argv_reset (&argv);
             }
 	}
-- 
1.7.10.4


