Date: Mon, 27 Jul 2015 20:30:25 +0200 (CEST)
Message-Id: <201507271830.t6RIUOSO011717@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1438011191-19389-1-git-send-email-arne@...1227...>
References: <1438011191-19389-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix commit e473b7c if an inline
	file happens to have a line break exactly at buffer limit
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

Your patch has been applied to the master and release/2.3 branch.

I've removed the extra blank line that sneaked in.

commit d40cbf0e2601b35bfb1c0551c6f3907b5c5178ff (master)
commit 57576475f5d6e5dd9cdb64fa0edcf283ce4a05c9 (release/2.3)

Author: Arne Schwabe
Date:   Mon Jul 27 17:33:11 2015 +0200

     Fix commit e473b7c if an inline file happens to have a line break exactly at buffer limit

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1438011191-19389-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9956
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


