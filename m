From: Gert Doering <gert@...1296...>
Date: Wed, 23 Oct 2024 13:39:23 +0200
Message-ID: <20241023113923.7420-1-gert@...1296...>
In-Reply-To: <gerrit.1729681493000.I8526aadb5151ddc997c836d5a691bcdfee700938@...2715...>
References: <gerrit.1729681493000.I8526aadb5151ddc997c836d5a691bcdfee700938@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix for msbuild/mingw GHA failures
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Commit ("event/multi: add event_arg object to make
event handling more generic") accidentally removed
a variable declaration and its usage because of a
rebase, this fix restore the wiped out
unsigned int *persistent in multi_tcp_wait().

Change-Id: I8526aadb5151ddc997c836d5a691bcdfee700938
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/785
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 67e3e8e..6faf45a 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -254,6 +254,7 @@
                struct multi_tcp *mtcp)
 {
     int status;
+    unsigned int *persistent = &mtcp->tun_rwflags;
     socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
                                  &c->c2.link_socket->ev_arg);
 
@@ -271,7 +272,7 @@
         persistent = NULL;
     }
 #endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif

