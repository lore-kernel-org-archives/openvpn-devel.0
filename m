Date: Wed, 8 Jun 2016 20:37:44 +0200 (CEST)
Message-Id: <201606081837.u58IbipG047197@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465388443-15484-2-git-send-email-steffan@...1856...>
References: <1465388443-15484-2-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't limit max incoming
	message size based on c2->frame
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

Another ACK from me.  

I'm not sure I understand all the intricacies of our buffer/frame handling 
and *why* there is always enough "capacity" present, but since we're never 
reading more bytes than we have capacity, this is definitely *safe*.

Obviously the old code never requested more bytes than capacity (buf_safe()),
so the new code will read() "at least as many bytes as before" - and since
I remember that there is quite a bit of headroom in the frame stuff, the
goal should be achieved.

Your patch has been applied to the master and release/2.3 branch (the latter
because it helps with certain incompatibilities in --*-mtu setup, which
otherwise lead to hard-to-debug TLS failures).

commit 3c1b19e04745177185decd14da82c71458442b82 (master)
commit 358f513c008bf01fadb82759ac75ffb8613fc785 (release/2.3)

Author: Steffan Karger
Date:   Wed Jun 8 14:20:39 2016 +0200

     Don't limit max incoming message size based on c2->frame

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465388443-15484-2-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11850
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


