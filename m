From: Gert Doering <gert@...1296...>
Date: Wed, 25 Jun 2025 18:26:31 +0200
Message-ID: <20250625162638.7769-1-gert@...1296...>
In-Reply-To: <gerrit.1750855403000.I5d9535d46e5a5488f4a2b637a6fcb99aad668fee@...2715...>
References: <gerrit.1750855403000.I5d9535d46e5a5488f4a2b637a6fcb99aad668fee@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco linux: avoid sending local port to
 ovpn
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

From: Ralf Lici <ralf@...2726...>

When sending an OVPN_CMD_NEW_PEER netlink message to ovpn, we currently
attempt to include the local port along with the local address. However,
`dco_multi_get_localaddr()` does not record the port, so we end up
sending a zero value. This zero is rejected by ovpn's netlink policy,
leading to an error and aborted connection.

Since openvpn does not actually need to send the local port because the
module retrieves it directly from the socket, this commit ensures that
only the local address is sent.

Change-Id: I5d9535d46e5a5488f4a2b637a6fcb99aad668fee
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Antonio Quartulli <antonio@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1068
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0345413..22a445a 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -265,13 +265,11 @@
         {
             NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV4, sizeof(struct in_addr),
                     &((struct sockaddr_in *)localaddr)->sin_addr);
-            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_in *)localaddr)->sin_port);
         }
         else if (localaddr->sa_family == AF_INET6)
         {
             NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV6, sizeof(struct in6_addr),
                     &((struct sockaddr_in6 *)localaddr)->sin6_addr);
-            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_in6 *)localaddr)->sin6_port);
         }
     }
 

