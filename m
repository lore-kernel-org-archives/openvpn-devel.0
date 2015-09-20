Date: Sun, 20 Sep 2015 14:47:07 +0200 (CEST)
Message-Id: <201509201247.t8KCl7YG014501@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1441985627-14822-9-git-send-email-gert@...1296...>
References: <1441985627-14822-9-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_default_gateway_ipv6():
	*BSD / MacOS / Solaris PF_ROUTE implementation
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch.

As for Linux, we'll revisit the "multiple routing tables" topic when
a use case arrives (and we've built generic infrastructure to handle this)

commit 2ff366f78a2bf8d0a2744db9b59f7274b671a042
Author: Gert Doering
Date:   Fri Sep 11 17:33:45 2015 +0200

     get_default_gateway_ipv6(): *BSD / MacOS / Solaris PF_ROUTE implementation

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1441985627-14822-9-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10082


--
kind regards,

Gert Doering


