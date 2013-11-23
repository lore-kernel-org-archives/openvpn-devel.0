Date: Sat, 23 Nov 2013 15:38:18 +0100
Message-Id: <201311231438.rANEcIhD004708@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385064495-25877-2-git-send-email-arne@...1227...>
References: <1385064495-25877-2-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Simplify print_sockaddr_ex
	function, merge duplicate ipv4/ipv6 logic.
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

ACK, with two fixes taken from patch 11/14 in that series, namely this
hunk for socket.c:

@@ -2235,12 +2209,14 @@ print_sockaddr_ex (const struct sockaddr *sa,
     case AF_INET6:
       buf_puts (&out, "[AF_INET6]");
       salen = sizeof (struct sockaddr_in6);   
-      addr_is_defined = IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
+      addr_is_defined = !IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
       break;
+    case AF_UNSPEC:
+      return "[AF_UNSPEC]";
     default:
       ASSERT(0);
     }

Without these fixes, master + 02/14 will build but crash upon startup
trying to print it's local socket address, which will (if not bound) be
"AF_UNSPEC".  If possible, I want each of the individual steps in the
patch set to lead to a working openvpn binary, so we can bisect more 
easily should it become necessary later on.

Patch has been applied to the master branch.

commit d3310d2ea46a71c35313a653c9454fc468cb9c55

Author: Arne Schwabe
Date:   Thu Nov 21 21:08:03 2013 +0100

     Simplify print_sockaddr_ex function, merge duplicate ipv4/ipv6 logic.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385064495-25877-2-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8023
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


