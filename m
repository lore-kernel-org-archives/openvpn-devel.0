Date: Sun, 22 Nov 2015 16:19:18 +0100 (CET)
Message-Id: <201511221519.tAMFJISP030237@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1448106060-19469-1-git-send-email-steffan@...1856...>
References: <1448106060-19469-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: polarssl: don't use deprecated
	functions anymore
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

ACK, based on "it looks reasonable" and "passes all my tests" (and there
is a certain matter of trust here that these functions really are what
should be used :-) - googling turned up depreciation comments in various
polar/embedssl headers for the "easy ones", like md_free_ctx() though)

Your patch has been applied to the master branch.

commit 67a67e39895d9c2c7af08e7fb38ba341e6be8fb6

Author: Steffan Karger
Date:   Sat Nov 21 12:41:00 2015 +0100

     polarssl: don't use deprecated functions anymore

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1448106060-19469-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10544
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


