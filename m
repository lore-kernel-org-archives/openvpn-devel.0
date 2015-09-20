Date: Sun, 20 Sep 2015 14:47:11 +0200 (CEST)
Message-Id: <201509201247.t8KClBEY014510@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1441985627-14822-10-git-send-email-gert@...1296...>
References: <1441985627-14822-10-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix IPv6 host routes to LAN
	gateway on OpenSolaris
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

As per Arne's suggestion, I've rewritten the comment quite a bit
(it already explained about "metric 0", but not about "it still
works on OpenSolaris").   Also removed the leftover "this has not been 
tested" comment about route deletion on OpenSolaris (it has!).

No functional changes.

Patch has been applied to the master branch.

commit fa5697f022110f557710f709c9ac0a3420bb073c
Author: Gert Doering
Date:   Fri Sep 11 17:33:46 2015 +0200

     Fix IPv6 host routes to LAN gateway on OpenSolaris

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1441985627-14822-10-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10092


--
kind regards,

Gert Doering


