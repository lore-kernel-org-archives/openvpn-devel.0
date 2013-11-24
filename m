Date: Sun, 24 Nov 2013 19:55:19 +0100 (CET)
Message-Id: <201311241855.rAOItJKs002140@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385309584-23209-1-git-send-email-gert@...1296...>
References: <1385309584-23209-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove fields from "ip -6 route
	show" output that distort results.
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

Patch has been applied to the master and release/2.3 branch, with a
slightly changed commit message (to make clear that this is about 
t_client.sh, not about openvpn itself).

commit 8c19087034cb1076874075b9e2896ea3f7be59cf (master)
commit 8a553107046b5f214f869f936ba198535571e941 (release/2.3)

Author: Gert Doering <gert@...1296...>
Date:   Sun Nov 24 17:13:04 2013 +0100

     t_client.sh: ignore fields from "ip -6 route show" output that distort results.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1385309584-23209-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8047


--
kind regards,




