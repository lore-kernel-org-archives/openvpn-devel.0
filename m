Date: Wed, 10 Feb 2016 11:18:04 +0100 (CET)
Message-Id: <201602101018.u1AAI4mK027218@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1454876492-6588-1-git-send-email-lstipakov@...277...>
References: <1454876492-6588-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Report Windows bitness
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Looks reasonable, tested with a 32bit binary on 64bit windows, works
(have not tested all possible combinations due to resource constraints,
will test as soon as buildbot provides installers)

Your patch has been applied to the master branch.

I'll apply this to release/2.3 as well as it nicely complements 84eb66bf78b0
(but want to have this tested on all platforms first)

commit 15f78acfae2f99b74a72b5766559f28c2d1d3cac (master)

Author: Lev Stipakov
Date:   Sun Feb 7 22:21:32 2016 +0200

     Report Windows bitness

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1454876492-6588-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11086
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


