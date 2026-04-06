From: Gert Doering <gert@...1296...>
Date: Mon,  6 Apr 2026 09:26:11 +0200
Message-ID: <20260406072617.27790-1-gert@...1296...>
In-Reply-To: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
References: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] push: Make prepare_push_reply return void
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

It returned a constant value so it didn't actually
mean anything.

While here also make it static.

Identified by cppcheck.

Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1616
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1616
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 835c433..564ce86 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -631,10 +631,8 @@
  * @param c             context structure storing data for VPN tunnel
  * @param gc            gc arena for allocating push options
  * @param push_list     push list to where options are added
- *
- * @return true on success, false on failure.
  */
-bool
+static void
 prepare_push_reply(struct context *c, struct gc_arena *gc, struct push_list *push_list)
 {
     struct tls_multi *tls_multi = c->c2.tls_multi;
@@ -734,8 +732,6 @@
                 client_max_mtu, o->ce.tun_mtu, o->ce.tun_mtu);
         }
     }
-
-    return true;
 }
 
 static bool
@@ -1011,7 +1007,8 @@
             struct push_list push_list = { 0 };
             struct gc_arena gc = gc_new();
 
-            if (prepare_push_reply(c, &gc, &push_list) && send_push_reply(c, &push_list))
+            prepare_push_reply(c, &gc, &push_list);
+            if (send_push_reply(c, &push_list))
             {
                 ret = PUSH_MSG_REQUEST;
                 c->c2.sent_push_reply_expiry = now + 30;

