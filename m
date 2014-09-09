From: David Sommerseth <openvpn.list@...1114...>
Date: Tue,  9 Sep 2014 19:26:11 +0200
Message-Id: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH v2 0/2] Further systemd cleanups
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
To: openvpn-devel@lists.sourceforge.net

From: David Sommerseth <davids@...1347...>

This replaces patch 2/4 [1] and patch 3/4 [2] of the last round,
just fixing up things from the review.

Patch 1/4 [3] got an ACK and have been applied, while patch 4/4 [4]
will be considered in a bigger scope.

[1] <http://thread.gmane.org/gmane.network.openvpn.devel/9023/focus=9024>
[2] <http://thread.gmane.org/gmane.network.openvpn.devel/9023/focus=9020>
[3] <http://thread.gmane.org/gmane.network.openvpn.devel/9023/focus=9021>
[4] <http://thread.gmane.org/gmane.network.openvpn.devel/9023/focus=9022>

David Sommerseth (2):
  Don't try to use systemd-ask-password if it is not available
  Clean up the pipe closing in openvpn_popen()

 src/openvpn/console.c |  8 +++++---
 src/openvpn/misc.c    | 18 ++++++++++--------
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
1.8.3.1


