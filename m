From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 10 Jul 2015 15:22:26 +0200
Message-Id: <1436534548-21507-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH 0/2] Provide OpenVPN version information to
	plug-ins
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

These two patches enables both OpenVPN version information at 
compile time and run time.  This can be used by plug-ins to adjust
it's behavoiour and available features based on which OpenVPN plug-in
API it is compiled against and run against.

This should further help writing plug-ins which can be used against
a broader set of OpenVPN binaries.

David Sommerseth (2):
  Provide compile time OpenVPN version information to plug-ins
  Provide OpenVPN runtime version information to plug-ins

 .gitignore                                        |  1 +
 configure.ac                                      |  7 +++++++
 include/Makefile.am                               |  1 +
 include/{openvpn-plugin.h => openvpn-plugin.h.in} | 16 +++++++++++++++-
 sample/sample-plugins/log/log_v3.c                |  6 ++++++
 src/openvpn/plugin.c                              | 21 ++++++++++++++++++++-
 version.m4                                        |  7 ++++++-
 7 files changed, 56 insertions(+), 3 deletions(-)
 rename include/{openvpn-plugin.h => openvpn-plugin.h.in} (97%)

-- 
1.8.3.1


