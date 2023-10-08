From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  8 Oct 2023 12:34:15 +0200
Message-Id: <20231008103415.19625-1-frank@...2641...>
In-Reply-To: <gerrit.1692709613000.I052bebe720ddf26340827f25b94705945e470bfa@...2715...>
References: <gerrit.1692709613000.I052bebe720ddf26340827f25b94705945e470bfa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove last uses of inet_ntoa
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

inet_ntoa is officially deprecated and in some places
its use already causes warnings (e.g. Fedora submissions).
Since we mostly use inet_ntop already, just convert the
remaining usages to that.

Change-Id: I052bebe720ddf26340827f25b94705945e470bfa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/326
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 739ed40..feb62b2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3058,9 +3058,11 @@
         /* listen on our local TUN/TAP IP address */
         struct in_addr ia;
         int ret;
+        char buf[INET_ADDRSTRLEN];
 
         ia.s_addr = htonl(tun_local_ip);
-        ret = openvpn_getaddrinfo(GETADDR_PASSIVE, inet_ntoa(ia), NULL, 0, NULL,
+        inet_ntop(AF_INET, &ia, buf, sizeof(buf));
+        ret = openvpn_getaddrinfo(GETADDR_PASSIVE, buf, NULL, 0, NULL,
                                   AF_INET, &man->settings.local);
         ASSERT(ret==0);
         man_connection_init(man);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 9212186..ff64938 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -342,7 +342,9 @@
             goto fail;
         }
         special.s_addr = htonl(special.s_addr);
-        ret = openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL,
+        char buf[INET_ADDRSTRLEN];
+        inet_ntop(AF_INET, &special, buf, sizeof(buf));
+        ret = openvpn_getaddrinfo(0, buf, NULL, 0, NULL,
                                   AF_INET, network_list);
     }
     else
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 501e023..903f98b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2901,16 +2901,16 @@
 print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
 {
     struct in_addr ia;
-    struct buffer out = alloc_buf_gc(64, gc);
+    char *out = gc_malloc(INET_ADDRSTRLEN, true, gc);
 
     if (addr || !(flags & IA_EMPTY_IF_UNDEF))
     {
         CLEAR(ia);
         ia.s_addr = (flags & IA_NET_ORDER) ? addr : htonl(addr);
 
-        buf_printf(&out, "%s", inet_ntoa(ia));
+        inet_ntop(AF_INET, &ia, out, INET_ADDRSTRLEN);
     }
-    return BSTR(&out);
+    return out;
 }
 
 /*
@@ -2920,16 +2920,14 @@
 const char *
 print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
 {
-    struct buffer out = alloc_buf_gc(64, gc);
-    char tmp_out_buf[64];       /* inet_ntop wants pointer to buffer */
+    char *out = gc_malloc(INET6_ADDRSTRLEN, true, gc);
 
     if (memcmp(&a6, &in6addr_any, sizeof(a6)) != 0
         || !(flags & IA_EMPTY_IF_UNDEF))
     {
-        inet_ntop(AF_INET6, &a6, tmp_out_buf, sizeof(tmp_out_buf)-1);
-        buf_printf(&out, "%s", tmp_out_buf );
+        inet_ntop(AF_INET6, &a6, out, INET6_ADDRSTRLEN);
     }
-    return BSTR(&out);
+    return out;
 }
 
 /*
@@ -2978,7 +2976,7 @@
 {
     char name_buf[256];
 
-    char buf[128];
+    char buf[INET6_ADDRSTRLEN];
     switch (addr->addr.sa.sa_family)
     {
         case AF_INET:
@@ -2991,7 +2989,8 @@
                 openvpn_snprintf(name_buf, sizeof(name_buf), "%s", name_prefix);
             }
 
-            setenv_str(es, name_buf, inet_ntoa(addr->addr.in4.sin_addr));
+            inet_ntop(AF_INET, &addr->addr.in4.sin_addr, buf, sizeof(buf));
+            setenv_str(es, name_buf, buf);
 
             if ((flags & SA_IP_PORT) && addr->addr.in4.sin_port)
             {
@@ -3007,13 +3006,12 @@
                 memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12],
                        sizeof(ia.s_addr));
                 openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
-                openvpn_snprintf(buf, sizeof(buf), "%s", inet_ntoa(ia) );
+                inet_ntop(AF_INET, &ia, buf, sizeof(buf));
             }
             else
             {
                 openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix);
-                getnameinfo(&addr->addr.sa, sizeof(struct sockaddr_in6),
-                            buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);
+                inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof(buf));
             }
             setenv_str(es, name_buf, buf);
 

