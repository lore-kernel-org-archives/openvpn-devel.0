Date: Tue, 8 Nov 2016 10:17:21 +0100 (CET)
Message-Id: <201611080917.uA89HLn8032153@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1478594363-12752-1-git-send-email-gert@...1296...>
References: <1478594363-12752-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: check c->c2.link_socket before
	calling do_init_route_ipv6_list()
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

commit 71e7c5f25174a3046a32720d3d6eb77f87458217
Author: Gert Doering
Date:   Tue Nov 8 09:39:23 2016 +0100

     check c->c2.link_socket before calling do_init_route_ipv6_list()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1478594363-12752-1-git-send-email-gert@...1296...>
     URL: http://www.mail-archive.com/search?l=mid&q=1478594363-12752-1-git-send-email-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


