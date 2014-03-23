Date: Sun, 23 Mar 2014 20:22:11 +0100 (CET)
Message-Id: <201403231922.s2NJMBTA029310@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395407925-25518-7-git-send-email-arne@...1227...>
References: <1395407925-25518-7-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix for server selecting
	address family
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

I take this as "fixes fallout of the of the grand socket.c restructuring",
so ACK, even if I won't claim to truly understand under which conditions
this makes a difference.

Patch has been applied to the master branch.

commit 45184804c477aed2ae91ce23d6606da1bfccbaa7
Author: Arne Schwabe
Date:   Fri Mar 21 14:18:39 2014 +0100

     Fix for server selecting address family

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395407925-25518-7-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8371
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


