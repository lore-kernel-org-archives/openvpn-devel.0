Date: Thu, 22 Oct 2015 20:05:41 +0200 (CEST)
Message-Id: <201510221805.t9MI5fGp061973@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1445411606-13369-1-git-send-email-lstipakov@...277...>
References: <1445411606-13369-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace variable length array
	with malloc
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

ACK.  Looks sane and is totally in line with coding conventions :-) - and
very useful to actually have a gc around!

Your patch has been applied to the master branch.

commit 41e4b67a229e774ebc57a882c386e10d80e10e7e
Author: Lev Stipakov
Date:   Wed Oct 21 10:13:26 2015 +0300

     Replace variable length array with malloc

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1445411606-13369-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10344
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


