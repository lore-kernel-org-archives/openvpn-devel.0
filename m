Date: Tue, 15 Sep 2015 13:21:57 +0200 (CEST)
Message-Id: <201509151121.t8FBLvs7079169@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1442309019-7586-7-git-send-email-arne@...1227...>
References: <1442309019-7586-7-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend network-change command
	to allow reprotecting on the same network (for short
	connection losses)
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

ACK.  Android specific, no obvious code issues.

Taking the "management <-> managmenet" typo of 1/8 into account.

Your patch has been applied to the master branch.

commit d967ec289df5c5196f68a3708a9f36a5ba354833

Author: Arne Schwabe
Date:   Tue Sep 15 11:23:37 2015 +0200

     Extend network-change command to allow reprotecting on the same network (for short connection losses)

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1442309019-7586-7-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10106
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


