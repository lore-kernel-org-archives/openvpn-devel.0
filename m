From: David Sommerseth <dazo@...384...>
Date: Thu, 26 Aug 2010 23:43:57 +0200
Message-Id: <1282859040-25837-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 0/3] New OpenVPN plug-in API
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
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

In the IRC meeting August 26, the current plug-in API was discussed
in relation to a Trac ticket [1] which requested access to the complete
X509 certificate structures.

Several approaches was discussed, but a consensus was met that the current
plug-in API was not flexible enough to tackle this.  Instead of creating
yet another API which just adds the X509 structures usable by OpenSSL, it
was decided to try to design a new API which could be extended more easily
in the future, without implementing new functions constantly.

This patch series is a first-stab at such an a design.  It is designed to
support all the features of the v2 API, but the arguments to
openvpn_plugin_open_v3() and openvpn_plugin_func_v3() is different.  Most
of the input arguments, are now sent as a struct in stead.

The X509 certificate data is not yet provided via the plug-in as the
ticket [1] requests, but it prepares the ground to add this information
later on when a new plug-in API has been accepted and implemented.


Kind regards,

David Sommerseth


[1] https://community.openvpn.net/openvpn/ticket/44


David Sommerseth (3):
  Define the new openvpn_plugin_{open,func}_v3() API
  Implement the core v3 plug-in function calls.
  Added a simple plug-in demonstrating the v3 plug-in API.

 openvpn-plugin.h         |  181 ++++++++++++++++++++++++++++++++++++++++++++-
 plugin.c                 |   23 +++++-
 plugin.h                 |    2 +
 plugin/examples/log_v3.c |  188 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 389 insertions(+), 5 deletions(-)
 create mode 100644 plugin/examples/log_v3.c

-- 
1.7.2.2


