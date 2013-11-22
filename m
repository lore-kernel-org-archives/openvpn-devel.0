Date: Fri, 22 Nov 2013 19:33:14 +0100
Message-Id: <201311221833.rAMIXEoj002340@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change the type of all ports in
	openvpn to const char* and let getaddrinfo resolve the port
	together with the hostname.
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

Feature-ACK from "the group" in Munich.  

Code review ACK and (lightly) tested for a few cases by me.

Patch has been applied to the master branch.

commit 076fd3e46bbbe6261317d58cc2442f8eccc927ce (master)

Author: Arne Schwabe
Date:   Thu Nov 21 21:08:02 2013 +0100

     Change the type of all ports in openvpn to const char* and let getaddrinfo resolve the port together with the hostname.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385064495-25877-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8018
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


