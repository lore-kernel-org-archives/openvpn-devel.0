From: David Sommerseth <davids@...515...>
Date: Mon,  8 Aug 2016 21:28:04 +0200
Message-Id: <1470684488-21307-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4 0/4] Query User Input patches
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

Lets see if fourth time is the charm.  This patch set reworks the
whole interface of quering the user for input.  This will be the 
building block for enabling OpenVPN to gather as much information as
possible at the initalization point, as well as providing an API
for other more advanced mechanisms to query the user for input in the
OS.

Previous attempts can be found here:
<https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/1439311312-2682-1-git-send-email-openvpn.list%40topphemmelig.net/#msg34365281>
<https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/1430942786-31419-1-git-send-email-openvpn.list%40topphemmelig.net/#msg34089983>
<https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/1416138935-12614-1-git-send-email-openvpn.list%40topphemmelig.net/#msg33044439>

David Sommerseth (4):
  Rework the user input interface to make it more modular
  Re-implement the systemd support using the new query user API
  autotools: Add support for extracting version information from
    pkg-config modules
  systemd: Do not mask usernames when querying for it via
    systemd-ask-password

 configure.ac                  |   3 +-
 m4/pkg.m4                     |   9 +-
 src/openvpn/Makefile.am       |   2 +-
 src/openvpn/console.c         | 228 +++++-------------------------------
 src/openvpn/console.h         |  89 +++++++++++++-
 src/openvpn/console_builtin.c | 261 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/console_systemd.c | 122 ++++++++++++++++++++
 src/openvpn/misc.c            |  58 +++++++---
 src/openvpn/pkcs11.c          |   7 +-
 9 files changed, 550 insertions(+), 229 deletions(-)
 create mode 100644 src/openvpn/console_builtin.c
 create mode 100644 src/openvpn/console_systemd.c

-- 
1.8.3.1


