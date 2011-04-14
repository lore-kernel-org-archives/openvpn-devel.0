From: David Sommerseth <davids@...1347...>
Date: Thu, 14 Apr 2011 16:29:58 +0200
Message-Id: <1302791399-23728-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH v2] Change the default --tmp-dir path to a
	more suitable path
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
Cc: David Sommerseth <davids@...1347...>

After all the discussions regarding the --tmp-dir patch [1], I have now
condenced everything into one single patch.  The main change is that
the new win_get_tempdir() function is simplified by using GetTempPath()
instead.

On Windows the fallback solution, if GetTempPath() returns NULL, is now to
behave as before - write temporary files in the directory where OpenVPN was
started.


[1] <http://thread.gmane.org/gmane.network.openvpn.devel/4561>


David Sommerseth (1):
  Change the default --tmp-dir path to a more suitable path

 options.c |   18 ++++++++++++++----
 win32.c   |   19 +++++++++++++++++++
 win32.h   |    3 +++
 3 files changed, 36 insertions(+), 4 deletions(-)

-- 
1.7.4.2


