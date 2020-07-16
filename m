From: David Sommerseth <davids@...515...>
Date: Fri, 17 Jul 2020 00:53:30 +0200
Message-Id: <20200716225338.611-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/8] man-page overhaul project - round 2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

In the community meeting 2020-07-16, it was agreed to try to squash
several commits and reduce the number of patches.  In addition to
split up the biggest patch into two parts to try to sneak everything
into the mailing list without sending too large patches.

I've kept a few changes separate, as they are not strictly tied to
this overhaul but these changes are important to get included.

Richard Bonhomme has also contributed with a lot of language
improvements which now has been squashed into one of these commits
below.  Unfortunately this squashing removed him as the author of
that commit, but I wanted to be sure he gets the proper credit somehow.


kind regards,

David Sommerseth
OpenVPN Inc




David Sommerseth (7):
  doc/man: Add an .rst formatted version of the man page
  doc/man: Replace old man page with generated man page
  doc/man: Split up and reorganize main man page
  doc/man: Complete openvpn.8.rst splitting
  doc/man: Mark compression options as deprecated
  doc/man: Adopt compression documentation
  doc/man: Documentation for --bind-dev / VRFs on Linux

Richard Bonhomme (1):
  doc/man: Update --txqueuelen default setting (Now OS default)

 .gitignore                                    |    1 +
 INSTALL                                       |    3 +-
 configure.ac                                  |   15 +-
 doc/Makefile.am                               |   56 +-
 doc/README.man                                |   23 +
 doc/man-sections/advanced-options.rst         |  107 +
 doc/man-sections/client-options.rst           |  354 +
 doc/man-sections/connection-profiles.rst      |   75 +
 doc/man-sections/encryption-options.rst       |  136 +
 doc/man-sections/examples.rst                 |  241 +
 doc/man-sections/generic-options.rst          |  436 +
 doc/man-sections/inline-files.rst             |   25 +
 doc/man-sections/link-options.rst             |  410 +
 doc/man-sections/log-options.rst              |   74 +
 doc/man-sections/management-options.rst       |  136 +
 doc/man-sections/network-config.rst           |   10 +
 doc/man-sections/pkcs11-options.rst           |   81 +
 doc/man-sections/plugin-options.rst           |   60 +
 doc/man-sections/protocol-options.rst         |  262 +
 doc/man-sections/proxy-options.rst            |   66 +
 doc/man-sections/renegotiation.rst            |   53 +
 doc/man-sections/script-options.rst           |  807 ++
 doc/man-sections/server-options.rst           |  769 ++
 doc/man-sections/signals.rst                  |   30 +
 doc/man-sections/tls-options.rst              |  643 ++
 doc/man-sections/unsupported-options.rst      |   33 +
 .../virtual-routing-and-forwarding.rst        |   78 +
 doc/man-sections/vpn-network-options.rst      |  535 ++
 doc/man-sections/windows-options.rst          |  245 +
 doc/openvpn.8                                 | 7659 -----------------
 doc/openvpn.8.rst                             |  169 +
 31 files changed, 5918 insertions(+), 7674 deletions(-)
 create mode 100644 doc/README.man
 create mode 100644 doc/man-sections/advanced-options.rst
 create mode 100644 doc/man-sections/client-options.rst
 create mode 100644 doc/man-sections/connection-profiles.rst
 create mode 100644 doc/man-sections/encryption-options.rst
 create mode 100644 doc/man-sections/examples.rst
 create mode 100644 doc/man-sections/generic-options.rst
 create mode 100644 doc/man-sections/inline-files.rst
 create mode 100644 doc/man-sections/link-options.rst
 create mode 100644 doc/man-sections/log-options.rst
 create mode 100644 doc/man-sections/management-options.rst
 create mode 100644 doc/man-sections/network-config.rst
 create mode 100644 doc/man-sections/pkcs11-options.rst
 create mode 100644 doc/man-sections/plugin-options.rst
 create mode 100644 doc/man-sections/protocol-options.rst
 create mode 100644 doc/man-sections/proxy-options.rst
 create mode 100644 doc/man-sections/renegotiation.rst
 create mode 100644 doc/man-sections/script-options.rst
 create mode 100644 doc/man-sections/server-options.rst
 create mode 100644 doc/man-sections/signals.rst
 create mode 100644 doc/man-sections/tls-options.rst
 create mode 100644 doc/man-sections/unsupported-options.rst
 create mode 100644 doc/man-sections/virtual-routing-and-forwarding.rst
 create mode 100644 doc/man-sections/vpn-network-options.rst
 create mode 100644 doc/man-sections/windows-options.rst
 delete mode 100644 doc/openvpn.8
 create mode 100644 doc/openvpn.8.rst

-- 
2.26.0


