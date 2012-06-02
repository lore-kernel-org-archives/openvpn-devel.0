From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:35 +0200
Message-Id: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/8] Openvpn for Android patch set
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

These are the patches that currently are applied to the openvpn version distributed 
in the android version of openvpn. Only the last two patches are really android specific
the rest of the patches should also be useful on other platforms.

Arne Schwabe (8):
  Silence Port is now 1194 IANA warning if remote option with port is
    used
  Add the query to the error message. Makes the diagnose what went
    wrong from logs easier.
  Only use tmpdir if tmp_dir is really used.
  Explain that route-nopull also causes the client to ignore dhcp
    options.
  Add the name of the context where option is not allowed to the error
    message.
  Allow routes to be set before opening tun, similar to ifconfig before
    opening tun
  add ability to send/receive file descriptors via management
    interface, only used in android so. For now under #ifdef ANDROID
  Android platform specific changes.

 doc/openvpn.8         |    3 +-
 src/openvpn/console.c |    2 +-
 src/openvpn/init.c    |   11 +++++-
 src/openvpn/manage.c  |   88 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/manage.h  |    4 ++
 src/openvpn/options.c |   26 ++++++++++----
 src/openvpn/options.h |    2 +
 src/openvpn/route.c   |   25 +++++++++++++-
 src/openvpn/socket.c  |   10 +++++
 src/openvpn/ssl.c     |    2 +
 src/openvpn/syshead.h |    3 +-
 src/openvpn/tun.c     |   88 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/tun.h     |   19 ++++++++++-
 13 files changed, 267 insertions(+), 16 deletions(-)

-- 
1.7.7.5 (Apple Git-26)


