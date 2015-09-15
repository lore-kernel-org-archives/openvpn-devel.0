From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 11:23:31 +0200
Message-Id: <1442309019-7586-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/8] Miscallenous patches for OpenVPN
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

Submission of multiple patches that are still in my OpenVPN for Android
"fork" of OpenVPN for Android.

Some of the patches are specific for the Android version (1, 3-6)

2 and 7 are cleanup patches (remove unused function and remove an Inline).

The only major patch is the timeout patch. (8). We talked about changing it
this way in the Munich meeting.

Arne Schwabe (8):
  Add support for requesting the fd again to rebind to the next
    interface.
  Remove #ifdefs for client nat support.
  Don’t redirect the gateway on Android even if requested
  Use pseudo gw as default gw on Android as a workaround for not being
    able to read /proc/net/route
  Fix loglevel of protect socket message
  Extend network-change command to allow reprotecting on the same
    network (for short connection losses)
  Remove unused function h_errno_msg
  Remove http-proxy-timeout, socks timeout and set default of
    server-poll-timeout to 120s

 doc/openvpn.8                | 33 ++++++----------------
 src/openvpn/clinat.c         |  4 ---
 src/openvpn/clinat.h         |  2 +-
 src/openvpn/forward-inline.h |  2 +-
 src/openvpn/forward.c        | 19 +++++++++----
 src/openvpn/forward.h        |  2 +-
 src/openvpn/init.c           | 67 +++++++++++++++++++++++++++++++++-----------
 src/openvpn/interval.h       |  9 ++++++
 src/openvpn/manage.c         | 31 ++++++++++++++++++++
 src/openvpn/manage.h         |  3 ++
 src/openvpn/multi.c          |  2 --
 src/openvpn/openvpn.h        |  8 +++---
 src/openvpn/options.c        | 56 ++++++------------------------------
 src/openvpn/options.h        | 10 -------
 src/openvpn/proxy.c          | 22 +++++++++------
 src/openvpn/proxy.h          |  2 +-
 src/openvpn/push.c           |  2 --
 src/openvpn/route.c          | 18 ++++++++++++
 src/openvpn/socket.c         | 31 ++++++--------------
 src/openvpn/socket.h         |  7 +++--
 src/openvpn/syshead.h        |  5 ----
 21 files changed, 177 insertions(+), 158 deletions(-)

-- 
2.3.2 (Apple Git-55)


