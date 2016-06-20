Date: Mon, 20 Jun 2016 20:32:56 +0200 (CEST)
Message-Id: <201606201832.u5KIWukm075578@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1456993146-63968-9-git-send-email-james@...515...>
References: <1456993146-63968-9-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Added directive to specify HTTP
	proxy credentials in config.
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Another ACK from me - the patch did not apply easily to current master
as there was a change in context last December.  So did a more in-depth
review to ensure that the actual logic of get_user_pass_cr() is still 
matching the expectations of this change, and it should be fine.

(Somewhere in our patch queue, there's the "permit auth-user-pass as
<INLINE>", but since that didn't apply and nobody felt like rebasing it,
an eventual rebase will need to take *this* change into account as well)

Your patch has been applied to the master branch.

commit c9a35a20812aafdacc3682a0379f52126bd567ae
Author: James Yonan
Date:   Thu Mar 3 01:19:05 2016 -0700

     Added directive to specify HTTP proxy credentials in config.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1456993146-63968-9-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11283
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


