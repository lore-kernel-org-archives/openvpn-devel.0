Date: Sun, 13 Dec 2015 20:00:26 +0100 (CET)
Message-Id: <201512131900.tBDJ0QHK007100@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1449873472-14954-1-git-send-email-lstipakov@...277...>
References: <1449873472-14954-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use adapter index for
	add/delete_route_ipv6
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

ACK, and thanks.  Code looks good and I'm reasonably sure that it will
do the right thing - waiting for buildbot now to produce a windows binary
to actually test it :-) - then applying the 2.3 version to 2.3

Chances are good that this will break compilation with older MSVC versions,
though (as the "struct buffer out = ..." part is now right in the middle
of a block which wasn't allowed in earlier versions).

Your patch has been applied to the master branch.

commit 6417a6f8a01c702e7c8f19f01b696c3b0d2dc1f1 (master)

Author: Lev Stipakov
Date:   Sat Dec 12 00:37:52 2015 +0200

     Use adapter index for add/delete_route_ipv6

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1449873472-14954-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10759
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


