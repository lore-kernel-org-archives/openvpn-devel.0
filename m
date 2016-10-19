Date: Wed, 19 Oct 2016 23:04:44 +0200 (CEST)
Message-Id: <201610192104.u9JL4i4a059769@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1476903807-28763-1-git-send-email-steffan@...1856...>
References: <1476903807-28763-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove verbose msg() from
	send_push_reply()
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

ACK.  Not Lev to blaim, I put that debug there - back in the "how do
I get ifconfig-ipv6 into that buffer?" times :-) - but it definitely
makes sense to kick it.

Your patch has been applied to the master branch - it would make sense
to remove that in release/2.3 as well, but the surrounding code is
different enough that "just cherrypicking" fails and I'm lazy.

commit f3145272584ac60e061ade0325bb72bada674957 (master)
Author: Steffan Karger
Date:   Wed Oct 19 21:03:27 2016 +0200

     Remove verbose msg() from send_push_reply()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1476903807-28763-1-git-send-email-steffan@...1856...>
     URL: http://www.mail-archive.com/search?l=mid&q=1476903807-28763-1-git-send-email-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


