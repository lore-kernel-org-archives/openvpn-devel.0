Date: Tue, 15 Sep 2015 13:27:50 +0200 (CEST)
Message-Id: <201509151127.t8FBRoIb079211@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1442309019-7586-5-git-send-email-arne@...1227...>
References: <1442309019-7586-5-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use pseudo gw as default gw on
	Android as a workaround for not being able to read /proc/net/route
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

ACK.  To be expected :-) - and why bother creating error messages
when the VPN API does not need this information anyway.

I wondered why the part after "   /* scan adapter list */" is still
active, but this is about "which locally connected networks exist?"
(--redirect-gateway block-local), so that's still useful.

Your patch has been applied to the master branch.

commit 429f0560e3a908ffa00f18ba1a81af03ba05751e
Author: Arne Schwabe
Date:   Tue Sep 15 11:23:35 2015 +0200

     Use pseudo gw as default gw on Android as a workaround for not being able to read /proc/net/route

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1442309019-7586-5-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10111
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


