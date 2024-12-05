From: Gert Doering <gert@...1296...>
Date: Thu,  5 Dec 2024 22:41:58 +0100
Message-ID: <20241205214158.23542-1-gert@...1296...>
In-Reply-To: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
References: <gerrit.1732795471000.If645c3faf149bac82167a91be13541b30a1b8d6a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix some formatting related to if/else
 and macros
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

From: Frank Lichtenheld <frank@...2641...>

Make it clearer where the blocks are.

Change-Id: If645c3faf149bac82167a91be13541b30a1b8d6a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/821
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index bbdbc04..9e28e87 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -500,7 +500,7 @@
             push_option(o, print_opt_route_gateway_dhcp(&o->gc), M_USAGE);
         }
     }
-    else
+
     /*
      * HELPER DIRECTIVE:
      *
@@ -511,7 +511,7 @@
      * pull
      * tls-client
      */
-    if (o->client)
+    else if (o->client)
     {
         o->pull = true;
         o->tls_client = true;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index f296788..e79a118 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1822,7 +1822,9 @@
     }
     else
 #endif
-    man->connection.sd_cli = socket_do_accept(man->connection.sd_top, &act, false);
+    {
+        man->connection.sd_cli = socket_do_accept(man->connection.sd_top, &act, false);
+    }
 
     if (socket_defined(man->connection.sd_cli))
     {
@@ -1971,9 +1973,11 @@
         }
         else
 #endif
-        msg(D_LINK_ERRORS | M_ERRNO,
-            "MANAGEMENT: connect to %s failed",
-            print_sockaddr(man->settings.local->ai_addr, &gc));
+        {
+            msg(D_LINK_ERRORS | M_ERRNO,
+                "MANAGEMENT: connect to %s failed",
+                print_sockaddr(man->settings.local->ai_addr, &gc));
+        }
         throw_signal_soft(SIGTERM, "management-connect-failed");
         goto done;
     }
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 1db5422..c52540c 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -274,10 +274,10 @@
 
             /* Query passwords before becoming a daemon if we don't use the
              * management interface to get them. */
-#ifdef ENABLE_MANAGEMENT
             if (!(c.options.management_flags & MF_QUERY_PASSWORDS))
-#endif
-            init_query_passwords(&c);
+            {
+                init_query_passwords(&c);
+            }
 
             /* become a daemon if --daemon */
             if (c.first_time)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2e584c7..3d33844 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3861,8 +3861,9 @@
         }
         else
 #endif
-
-        rgi6->gateway.addr_ipv6 = gw;
+        {
+            rgi6->gateway.addr_ipv6 = gw;
+        }
         rgi6->flags |= RGI_ADDR_DEFINED;
 
         if (ifp)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index efd742c..01874fe 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3389,8 +3389,10 @@
     }
     else
 #endif
-    buf->len = recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), 0,
-                        &from->dest.addr.sa, &fromlen);
+    {
+        buf->len = recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), 0,
+                            &from->dest.addr.sa, &fromlen);
+    }
     /* FIXME: won't do anything when sock->info.af == AF_UNSPEC */
     if (buf->len >= 0 && expectedlen && fromlen != expectedlen)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1f8eb1e..33c22b4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -327,7 +327,9 @@
         }
         else
 #endif /* ifdef ENABLE_MANAGEMENT */
-        get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, flags);
+        {
+            get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, flags);
+        }
     }
 }
 

