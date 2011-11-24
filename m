MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Thu, 24 Nov 2011 23:10:25 +0100
Message-id: <1322172626-18434-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] RFC: Improve file checking during start-up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

The following patch has been laying in my repository for some time, unsure
why it's been there for so long.  I can't see nor recall if I posted it to
this -devel list either.  If there are things I should have fixed up before
re-posting it (if this is a repost), I appologise for that.

Please review this patch.  I don't know if this is the best approach, and if
others have better ideas for solving this.

David Sommerseth (1):
  Do some file/directory tests before really starting openvpn

 options.c |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 151 insertions(+), 0 deletions(-)

-- 
1.7.4.4


