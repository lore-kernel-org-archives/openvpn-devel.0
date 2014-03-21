From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:33 +0100
Message-Id: <1395407925-25518-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/12] Patches from OpenVPN for Android
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

To minimise the difference between my local ics-openvpn OpenVPN branch and 
the official master I am sending the patches which I think should be applied to 
master but are not yet applied yet.

Arne Schwabe (12):
  Fix connecting to localhost on Android
  Move the initialization of the environment to the top so c2.es is
    initialized
  Workaround broken Android 4.4 VpnService API for persist-tun mode
  Implement an easy parsable log output that allows access to flags of
    the log message
  Introduce an option to resolve dns names in advance for —remote,
    —local and http-proxy
  Fix for server selecting address family
  Don’t show the connection profile store in options->ce if there is a
    connection_list defined.
  Add gateway and device to android control messages
  Don’t redirect the gateway on Android even if requested
  Clean up of socket code.
  Fix assert when using port-share
  Fix client-nat only working is also mss-fix is specified.

 doc/openvpn.8         |   6 +
 src/openvpn/buffer.c  |  38 ++++
 src/openvpn/buffer.h  |  28 ++-
 src/openvpn/error.c   |  28 ++-
 src/openvpn/error.h   |   2 +
 src/openvpn/forward.c |  13 +-
 src/openvpn/init.c    |  60 +++--
 src/openvpn/manage.c  |  48 +++-
 src/openvpn/manage.h  |   5 +
 src/openvpn/openvpn.h |   3 +
 src/openvpn/options.c |  27 ++-
 src/openvpn/options.h |   5 +-
 src/openvpn/ps.c      |   2 +-
 src/openvpn/route.c   |  15 +-
 src/openvpn/socket.c  | 599 ++++++++++++++++++++++++++++++++------------------
 src/openvpn/socket.h  |  45 +++-
 src/openvpn/tun.c     |  29 ++-
 17 files changed, 681 insertions(+), 272 deletions(-)

-- 
1.8.5.2 (Apple Git-48)


