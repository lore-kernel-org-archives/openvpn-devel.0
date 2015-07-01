Date: Wed, 1 Jul 2015 17:39:43 +0200 (CEST)
Message-Id: <201507011539.t61FdhZl007032@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1435693496-10931-1-git-send-email-steffan@...1856...>
References: <1435693496-10931-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Increase control channel packet
	size for faster handshakes
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master branch.

I intend to apply it to 2.3 as well, but want to give it a bit more
beating - it looks good, but running in production for a few days should
give us more data.

Added "trac #545" to the commit message.

(As you've noted, this is not yet perfect - there is still quite a bit of
"small packet chatter" going on, even if both sides have the patch - and
there seems to be an arbitrary delay of 2 seconds between "ok, TLS is good!"
and "SENT CONTROL.*PUSH_REQUEST"... -> so, more investigation needed)

commit fc91d4b0071178e298052078431fb86f03be84fc (master)

Author: Steffan Karger
Date:   Tue Jun 30 21:44:56 2015 +0200

     Increase control channel packet size for faster handshakes

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1435693496-10931-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9841
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


