Date: Wed, 26 Mar 2014 15:21:17 +0100 (CET)
Message-Id: <201403261421.s2QELHUU000938@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395407925-25518-11-git-send-email-arne@...1227...>
References: <1395407925-25518-11-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clean up of socket code.
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Stared at the code for a while, discussed on IRC, with this small
change to bring "use TCP to talk to a socks proxy, then use UDP to connect
to OpenVPN server" back to working state:


diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d2f8240..b769171 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -872,7 +872,8 @@ create_socket (struct link_socket* sock, struct addrinfo* addr)
 	   * currently resolve two remote addresses is not supported,
 	   * TODO: Rewrite the whole resolve_remote */
 	  struct addrinfo addrinfo_tmp = *addr;
-	  addr->ai_protocol = IPPROTO_TCP;
+	  addrinfo_tmp.ai_socktype = SOCK_STREAM;
+	  addrinfo_tmp.ai_protocol = IPPROTO_TCP;
 	  sock->ctrl_sd = create_socket_tcp (&addrinfo_tmp);
 	}
 #endif


Patch has been applied to the master branch.

commit 7dbe04de74ea01bd77461ec82253dd769381c711

Author: Arne Schwabe
Date:   Fri Mar 21 14:18:43 2014 +0100

     Clean up of socket code.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395407925-25518-11-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8370
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


