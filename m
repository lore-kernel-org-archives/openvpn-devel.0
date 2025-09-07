From: Gert Doering <gert@...1296...>
Date: Sun,  7 Sep 2025 23:12:46 +0200
Message-ID: <20250907211252.23924-1-gert@...1296...>
In-Reply-To: <gerrit.1757240524000.I6480d6f741c2368a0d951004b91167d5943f8f9d@...2715...>
References: <gerrit.1757240524000.I6480d6f741c2368a0d951004b91167d5943f8f9d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] replace assert() calls with ASSERT()
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

OpenVPN's ASSERT() macro will do a bit more than the standard-libc
assert() call, namely print out which function and what expression
failed, before calling _exit(1).  Also, it can not be accidentially
compiled-away (-DNDEBUG).

Use of ASSERT() generally only advised in cases of "this must not happen,
but if it does, it's a programming or state corruption error that we
must know about".  Use of assert() is lacking the extra debug info, and as
such, not advised at all.

Change-Id: I6480d6f741c2368a0d951004b91167d5943f8f9d
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: mandree <matthias.andree@...68...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1171
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
mandree <matthias.andree@...68...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 931f9f6..65303cd 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -100,7 +100,7 @@
 
             in->sin_len = sizeof(*in);
             data = nvlist_get_binary(nvl, "address", &len);
-            assert(len == sizeof(in->sin_addr));
+            ASSERT(len == sizeof(in->sin_addr));
             memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
             in->sin_port = nvlist_get_number(nvl, "port");
             break;
@@ -114,7 +114,7 @@
 
             in6->sin6_len = sizeof(*in6);
             data = nvlist_get_binary(nvl, "address", &len);
-            assert(len == sizeof(in6->sin6_addr));
+            ASSERT(len == sizeof(in6->sin6_addr));
             memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
             in6->sin6_port = nvlist_get_number(nvl, "port");
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 39ea8e4..2821cd4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -319,7 +319,7 @@
 static unsigned int
 management_callback_remote_entry_count(void *arg)
 {
-    assert(arg);
+    ASSERT(arg);
     struct context *c = (struct context *)arg;
     struct connection_list *l = c->options.connection_list;
 
@@ -329,8 +329,8 @@
 static bool
 management_callback_remote_entry_get(void *arg, unsigned int index, char **remote)
 {
-    assert(arg);
-    assert(remote);
+    ASSERT(arg);
+    ASSERT(remote);
 
     struct context *c = (struct context *)arg;
     struct connection_list *l = c->options.connection_list;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0616a17..6858a69 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3486,9 +3486,9 @@
     {
         /* Copy --dhcp-options to tuntap_options */
         struct dhcp_options *dhcp = &dns->from_dhcp;
-        assert(sizeof(dhcp->dns) == sizeof(tt->dns));
-        assert(sizeof(dhcp->dns6) == sizeof(tt->dns6));
-        assert(sizeof(dhcp->domain_search_list) == sizeof(tt->domain_search_list));
+        ASSERT(sizeof(dhcp->dns) == sizeof(tt->dns));
+        ASSERT(sizeof(dhcp->dns6) == sizeof(tt->dns6));
+        ASSERT(sizeof(dhcp->domain_search_list) == sizeof(tt->domain_search_list));
 
         tt->domain = dhcp->domain;
         tt->dns_len = dhcp->dns_len;

