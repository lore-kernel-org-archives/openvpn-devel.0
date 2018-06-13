From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jun 2018 20:28:24 +0800
Message-Id: <20180613122824.4207-4-a@...2181...>
In-Reply-To: <20180613122824.4207-1-a@...2181...>
References: <20180613122824.4207-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 3/3] tun: get rid of tt->did_ifconfig
 member
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

tt->did_ifconfig is currently only read by the Linux platform, but
it is currently uselessly set also by every other system.

The Linux platform does not actually even need this member and can
directly rely on tt->did_ifconfig_setup.

For the reasons above, remove the tt->did_ifconfig at all and use
tt->did_ifconfig_setup where needed (close_tun() on Linux).

Signed-off-by: Antonio Quartulli <antonio@...515...>

---

Changes from v1:
- fix typ0 in commit message


 src/openvpn/tun.c | 12 +-----------
 src/openvpn/tun.h |  1 -
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 12b33ae7..48e7cc2e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -987,7 +987,6 @@ do_ifconfig(struct tuntap *tt,
             argv_msg(M_INFO, &argv);
             openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
         }
-        tt->did_ifconfig = true;
 #else  /* ifdef ENABLE_IPROUTE */
         if (tun)
         {
@@ -1026,7 +1025,6 @@ do_ifconfig(struct tuntap *tt,
             argv_msg(M_INFO, &argv);
             openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
         }
-        tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
@@ -1186,8 +1184,6 @@ do_ifconfig(struct tuntap *tt,
             add_route(&r, tt, 0, NULL, es);
         }
 
-        tt->did_ifconfig = true;
-
 #elif defined(TARGET_OPENBSD)
 
         in_addr_t remote_end;           /* for "virtual" subnet topology */
@@ -1265,7 +1261,6 @@ do_ifconfig(struct tuntap *tt,
             /* and, hooray, we explicitely need to add a route... */
             add_route_connected_v6_net(tt, es);
         }
-        tt->did_ifconfig = true;
 
 #elif defined(TARGET_NETBSD)
 
@@ -1327,7 +1322,6 @@ do_ifconfig(struct tuntap *tt,
             /* and, hooray, we explicitely need to add a route... */
             add_route_connected_v6_net(tt, es);
         }
-        tt->did_ifconfig = true;
 
 #elif defined(TARGET_DARWIN)
         /*
@@ -1384,7 +1378,6 @@ do_ifconfig(struct tuntap *tt,
 
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, es, S_FATAL, "Mac OS X ifconfig failed");
-        tt->did_ifconfig = true;
 
         /* Add a network route for the local tun interface */
         if (!tun && tt->topology == TOP_SUBNET)
@@ -1457,7 +1450,6 @@ do_ifconfig(struct tuntap *tt,
 
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
-        tt->did_ifconfig = true;
 
         /* Add a network route for the local tun interface */
         if (!tun && tt->topology == TOP_SUBNET)
@@ -1507,7 +1499,6 @@ do_ifconfig(struct tuntap *tt,
 
             argv_msg(M_INFO, &argv);
             openvpn_execve_check(&argv, aix_es, S_FATAL, "AIX ifconfig failed");
-            tt->did_ifconfig = true;
 
             if (do_ipv6)
             {
@@ -1545,7 +1536,6 @@ do_ifconfig(struct tuntap *tt,
 
                     break;
             }
-            tt->did_ifconfig = true;
         }
 
         if (do_ipv6)
@@ -2104,7 +2094,7 @@ close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
-    if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
+    if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig_setup)
     {
         struct argv argv = argv_new();
         struct gc_arena gc = gc_new();
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 6c57ad0d..9495d602 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -138,7 +138,6 @@ struct tuntap
 
     bool did_ifconfig_setup;
     bool did_ifconfig_ipv6_setup;
-    bool did_ifconfig;
 
     bool persistent_if;         /* if existed before, keep on program end */
 
-- 
2.17.1


