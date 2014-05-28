Date: Wed, 28 May 2014 22:39:12 +0200 (CEST)
Message-Id: <201405282039.s4SKdCSr011968@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <53863C41.1020408@...1856...>
References: <53863C41.1020408@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix merge error in a6c573d,
	the ssl ctx is now abstracted.
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

Argh...  so why didn't this blow up in my or buildbot's face?  I *did* 
test this...

Anyway. ACK. Patch has been applied to the master branch.

Yes, de-warn patches welcome, though I dislike "just sprinkle casts around"
patches :-)

commit efb304cf4904cbf5d926ab7a6ecde101472fa023
Author: Steffan Karger
Date:   Wed May 28 21:40:34 2014 +0200

     Fix merge error in a6c573d, the ssl ctx is now abstracted.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <53863C41.1020408@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8745
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


