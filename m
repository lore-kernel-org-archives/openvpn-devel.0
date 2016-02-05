Date: Fri, 5 Feb 2016 08:47:57 +0100 (CET)
Message-Id: <201602050747.u157lvme041239@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20160202191122.GE1675@...2119...>
References: <20160202191122.GE1675@...2119...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix undefined signed shift
	overflow
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
To: Michael McConville <mmcco@...2118...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks for sending it to the list.

Your patch has been applied to the master and release/2.3 branch
(manually applying to release/2.3 as the code there has three copies
of the offending IPv4 code, and the IPv6 code isn't there yet...)

Tested on FreeBSD 10.1 ("openvpn --show-gateway")

commit d4d5d9259aeba152d5969fea048267fc97ca7530 (master)
commit d9eeaab65373a4a4d7511b9bac2dec90b1afed4f (release/2.3)

Author: Michael McConville
Date:   Tue Feb 2 14:11:22 2016 -0500

     Fix undefined signed shift overflow

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20160202191122.GE1675@...2119...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11050
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


