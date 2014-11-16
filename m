From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 16 Nov 2014 12:55:31 +0100
Message-Id: <1416138935-12614-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH 0/4] Reworking the interface for querying
	users
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

These patches enhances the mechanism in OpenVPN which queries the user
for username, passwords, PIN codes, etc.  When the management interface
is not in use, the current behaviour is to ask for this information
sequentially via the console OpenVPN is running on.

The first patch will introduce a more modular approach which also
standardizes an API for bulk operations.  This means that it is
possible to implement more advanced mechanisms asking for both
username and passwords at the same time through a single call
in the core OpenVPN code.  This patch also temporarily removes the
systemd implementation.

The second patch will re-implements systemd support using this new
API with the same functionality as before this patch set.

The third patch is a re-submission of an earlier patch, which is
needed by the fourth patch.  It is sent separately, as it provides
extra version information on a general basis and is not strictly
connected to systemd.

The fourth and last patch is a rebased patch of an earlier submission,
removing the masking of usernames.  This only happens when the proper
systemd version which supports an --echo argument is found.

All patches has been tested locally with different configurations,
requiring username, password and passphrases to PKCS#12 files.  The
challenge/response interface has not been tested, as well as PKCS#11.
All runs via valgrind shows no memory leaks with this new
implementation.

David Sommerseth (4):
  Rework the user input interface to make it more modular
  Re-implement the systemd support using the new query user API
  autotools: Add support for extracting version information from
    pkg-config modules
  systemd: Do not mask usernames when querying for it via
    systemd-ask-password

 configure.ac                  |   3 +-
 m4/pkg.m4                     |   7 +-
 src/openvpn/Makefile.am       |  15 ++-
 src/openvpn/console.c         | 228 ++++++---------------------------------
 src/openvpn/console.h         |  92 +++++++++++++++-
 src/openvpn/console_builtin.c | 246 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/console_systemd.c |  89 +++++++++++++++
 src/openvpn/misc.c            |  79 +++++++++++---
 src/openvpn/pkcs11.c          |  14 ++-
 9 files changed, 558 insertions(+), 215 deletions(-)
 create mode 100644 src/openvpn/console_builtin.c
 create mode 100644 src/openvpn/console_systemd.c

-- 
1.8.3.1


