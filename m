Date: Sun, 29 Nov 2015 20:27:43 +0100 (CET)
Message-Id: <201511291927.tATJRh8S019794@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1448823144-1497-1-git-send-email-arne@...1227...>
References: <1448823144-1497-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reflect enable-password-save
	change in documentation
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

ACK, thanks.

Your patch has been applied to the master and release/2.3 branch.

Changes.rst did not exist in that branch yet, so git decided to copy over
the whole Changes.rst file from 2.4 :-) - adapted to 2.3.x (not complete yet)

commit 1e9c1f09cba95ebf72083c746cf847056a61c761 (master)
commit fbf3763aab42c0f4de8362474edaaa2ea580dd17 (release/2.3)

Author: Arne Schwabe
Date:   Sun Nov 29 19:52:24 2015 +0100

     Reflect enable-password-save change in documentation

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1448823144-1497-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10665
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


