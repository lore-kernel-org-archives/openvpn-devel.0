From: davids@...1347...
Date: Fri,  5 Sep 2014 17:25:27 +0200
Message-Id: <1409930731-15263-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH 0/4] Clean-up of the systemd integration
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
Cc: fcrozat@...1519...

From: David Sommerseth <davids@...1347...>

There were a few issues with the systemd implementation,
where the openvpn binary would have zombie processes attached
to itself when systemd-ask-password was used.  In addition
to not always properly closing the communcation pipes used.

This patch set also avoids OpenVPN failing if systemd-ask-password
is not found, but rather falls back to the normal console method.


David Sommerseth (4):
  Don't let openvpn_popen() keep zombies around
  Don't try to use systemd-ask-password if it is not available
  Clean up the pipe closing in openvpn_popen()
  White-space clean-up of openvpn_popen()

 src/openvpn/console.c | 11 ++++----
 src/openvpn/misc.c    | 75 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 47 insertions(+), 39 deletions(-)

--
kind regards,

David Sommerseth

-- 
1.8.3.1


