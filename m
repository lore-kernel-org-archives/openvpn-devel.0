From: David Sommerseth <dazo@...384...>
Date: Fri, 10 Dec 2010 01:30:49 +0100
Message-Id: <1291941053-748-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH v2 0/4] OpenVPN plug-in API version 3
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
Cc: David Sommerseth <dazo@...384...>

This is the second round of implementing a new plug-in API for OpenVPN.  This
API uses structs for both passing arguments to and from the plug-in functions.

The reason for this approach is to avoid modifying the function API itself to
add more information being sent to or from the plug-in functions.

In addition this patchset will also add a X509 certificate OpenSSL structure
to the openvpn_plugin_func_v3() calls, which contains the complete parsed
certificate sent from the client.

David Sommerseth (4):
  Define the new openvpn_plugin_{open,func}_v3() API
  Implement the core v3 plug-in function calls.
  Extend the v3 plug-in API to send over X509 certificates
  Added a simple plug-in demonstrating the v3 plug-in API.

 init.c                   |    2 +-
 misc.c                   |    2 +-
 multi.c                  |    8 +-
 openvpn-plugin.h         |  229 ++++++++++++++++++++++++++++++++++++++++++-
 pf.c                     |    2 +-
 plugin.c                 |   48 ++++++++--
 plugin.h                 |    6 +-
 plugin/examples/log_v3.c |  245 ++++++++++++++++++++++++++++++++++++++++++++++
 socket.c                 |    2 +-
 ssl.c                    |    6 +-
 10 files changed, 530 insertions(+), 20 deletions(-)
 create mode 100644 plugin/examples/log_v3.c

-- 
1.7.2.3


