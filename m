From: Gert Doering <gert@...1296...>
Date: Mon, 25 Mar 2024 08:14:48 +0100
Message-ID: <20240325071448.12143-1-gert@...1296...>
In-Reply-To: <gerrit.1704798536000.I8ef199463d46303129a3f563fd9eace780a58b8a@...2715...>
References: <gerrit.1704798536000.I8ef199463d46303129a3f563fd9eace780a58b8a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] phase2_tcp_server: fix Coverity issue
 "Dereference after null check"
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

As Coverity says:
Either the check against null is unnecessary, or there may be a null
pointer dereference.
In phase2_tcp_server: Pointer is checked against null but then
dereferenced anyway

There is only one caller (link_socket_init_phase2) and it already has
an ASSERT(sig_info). So use that here was well.

v2:
 - fix cleanly by actually asserting that sig_info is defined

Change-Id: I8ef199463d46303129a3f563fd9eace780a58b8a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/490
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 480f4e5..387cb40 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2005,7 +2005,8 @@
 phase2_tcp_server(struct link_socket *sock, const char *remote_dynamic,
                   struct signal_info *sig_info)
 {
-    volatile int *signal_received = sig_info ? &sig_info->signal_received : NULL;
+    ASSERT(sig_info);
+    volatile int *signal_received = &sig_info->signal_received;
     switch (sock->mode)
     {
         case LS_MODE_DEFAULT:
@@ -2031,7 +2032,7 @@
                                         false);
             if (!socket_defined(sock->sd))
             {
-                register_signal(sig_info, SIGTERM, "socket-undefiled");
+                register_signal(sig_info, SIGTERM, "socket-undefined");
                 return;
             }
             tcp_connection_established(&sock->info.lsa->actual);

