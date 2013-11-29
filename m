Date: Fri, 29 Nov 2013 21:29:30 +0100
Message-Id: <201311292029.rATKTUFT018802@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385382680-5912-7-git-send-email-arne@...1227...>
References: <1385382680-5912-7-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement listing on IPv4/IPv6
	dual socket on all platform
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

ACK.

Some minor changes (v6only moved into the if() clause where the
setsockopt() is called, option.bind_ipv6_only initialization fixed, 
--ipv6only fixed in manpage), but no actual functional changes.

Patch has been applied to the master branch and pushed.

commit a2c2faaeae66867055ee411aff924ef75bf28cce (master)

Author: Arne Schwabe
Date:   Mon Nov 25 13:31:18 2013 +0100

     Implement listing on IPv4/IPv6 dual socket on all platform

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385382680-5912-7-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8052
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


