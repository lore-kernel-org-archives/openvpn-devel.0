Date: Sun, 13 Dec 2015 21:36:00 +0100 (CET)
Message-Id: <201512132036.tBDKa0Dn007472@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1449875430-15579-1-git-send-email-lstipakov@...277...>
References: <1449875430-15579-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use adapter index for
	add/delete_route_ipv6
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  I have not actually built or tested a 2.3 binary, but since
the code is nearly the same as for master and that one works nicely, I
assume this works as well.

Your patch has been applied to the release/2.3 branch.

commit ca8cead8fd8c00154f35b90593442e2bfa8f735d (release/2.3)

Author: Lev Stipakov
Date:   Sat Dec 12 01:10:30 2015 +0200

     Use adapter index for add/delete_route_ipv6

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1449875430-15579-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10760
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


