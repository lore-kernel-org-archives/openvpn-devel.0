From: Gert Doering <gert@...1296...>
Date: Thu,  9 Oct 2025 19:19:11 +0200
Message-ID: <20251009171916.12811-1-gert@...1296...>
In-Reply-To: <gerrit.1759751230000.I9b099924286f9bccb6833e1e40606abe72714bbb@...2715...>
References: <gerrit.1759751230000.I9b099924286f9bccb6833e1e40606abe72714bbb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Preserve ifconfig(_ipv6)_local across
 reconnect
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

From: Lev Stipakov <lev@...515...>

Turns out that ifconfig_(ipv6)_local options are set once
and are not reset on a reconnect.

Consider following scenario:

 - connect first time, server pushes ifconfig-ipv6
 - add a ipv6 network route because ifconfig_ipv6_local is set
 - reconnect, server doesn't push ifconfig-ipv6

Because of ifconfig_ipv6_local is not reset and holds the value
set by the first connect, client adds a ipv6 network route -
but this is wrong, since ipv6 wasn't pushed this time by the server.

Fix by saving/restoring ifconfig(_ipv6)_local in a
struct options_pre_connect along with other options which
preserves the initial values until --pull modifications
are applied.

Github: OpenVPN/openvpn#850
Change-Id: I9b099924286f9bccb6833e1e40606abe72714bbb
Signed-off-by: Lev Stipakov <lev@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1248
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1248
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f35738d..d1ce551 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3143,6 +3143,9 @@
         o->pre_connect->client_nat_defined = true;
     }
 
+    o->pre_connect->ifconfig_local = o->ifconfig_local;
+    o->pre_connect->ifconfig_ipv6_local = o->ifconfig_ipv6_local;
+
     o->pre_connect->route_default_gateway = o->route_default_gateway;
     o->pre_connect->route_ipv6_default_gateway = o->route_ipv6_default_gateway;
 
@@ -3193,6 +3196,9 @@
             o->routes_ipv6 = NULL;
         }
 
+        o->ifconfig_local = pp->ifconfig_local;
+        o->ifconfig_ipv6_local = pp->ifconfig_ipv6_local;
+
         o->route_default_gateway = pp->route_default_gateway;
         o->route_ipv6_default_gateway = pp->route_ipv6_default_gateway;
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b033068..445fd25 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -64,6 +64,9 @@
     bool tuntap_options_defined;
     struct tuntap_options tuntap_options;
 
+    const char *ifconfig_local;
+    const char *ifconfig_ipv6_local;
+
     bool routes_defined;
     struct route_option_list *routes;
 

