From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:29:57 +0200
Message-Id: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/16] man-page overhaul project
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

The time has come to send this pile of patches to the mailing list,
which incorporates many improvements by Richard Bonhomme (Thanks a lot!).

I do however fear that patch 5/16 and possibly patch 1/16 and 2/16 will
be rejected by the sourceforge mailman instance as they might exceed some
mailing list limts.  The other patches are below 30KiB and should arrive
fine on the mailing list.

  Patch 1/16: <https://gitlab.com/dazo/openvpn/-/commit/32e72c9fc9ce329293a6007347e2b7a3e3e297ac.patch>
  Patch 2/16: <https://gitlab.com/dazo/openvpn/-/commit/69085b6fd378ffcf5f26836c0e8b53e6fc3ae900.patch>
  Patch 5/16: <https://gitlab.com/dazo/openvpn/-/commit/c4d2d70c204f4cbda398387df5672d02f874ae8a.patch>

All patches are available from here:
  <https://gitlab.com/dazo/openvpn/-/commits/dev/man-reformatting>

If it makes sense to squash some or all of these changes into a single
commit, I have no issues with that.


kind regards,

David Sommerseth
OpenVPN Inc


David Sommerseth (14):
  doc/man: Add an .rst formatted version of the man page
  doc/man: Replace old man page with generated man page
  doc/man: Move <connection> profiles section
  doc/man: Remove unsupported options in OpenVPN 2.5
  doc/man: Split up and reorganize main man page
  doc/man: Move --bind from generic to link section
  doc/man: Move --dhcp-option from client to vpn-network section
  doc/man: Mark compression options as deprecated
  doc/man: Move some options from link to advanced section
  doc/man: Moved --reneg-* options to its own section
  doc/man: Cleaned up the examples
  doc/man: Adopt compression documentation
  doc/man: Fix a few typos and improve style usage
  doc/man: Minor improvements to the plug-in section

Richard Bonhomme (2):
  doc/man: Misc grammar and typo fixes
  doc/man: Update --txqueuelen default setting (Now OS default)

 .gitignore                               |    1 +
 INSTALL                                  |    3 +-
 configure.ac                             |   15 +-
 doc/Makefile.am                          |   56 +-
 doc/README.man                           |   23 +
 doc/man-sections/advanced-options.rst    |  107 +
 doc/man-sections/client-options.rst      |  354 +
 doc/man-sections/connection-profiles.rst |   75 +
 doc/man-sections/encryption-options.rst  |  136 +
 doc/man-sections/examples.rst            |  241 +
 doc/man-sections/generic-options.rst     |  436 ++
 doc/man-sections/inline-files.rst        |   25 +
 doc/man-sections/link-options.rst        |  410 ++
 doc/man-sections/log-options.rst         |   74 +
 doc/man-sections/management-options.rst  |  136 +
 doc/man-sections/network-config.rst      |    9 +
 doc/man-sections/pkcs11-options.rst      |   81 +
 doc/man-sections/plugin-options.rst      |   60 +
 doc/man-sections/protocol-options.rst    |  262 +
 doc/man-sections/proxy-options.rst       |   66 +
 doc/man-sections/renegotiation.rst       |   53 +
 doc/man-sections/script-options.rst      |  807 +++
 doc/man-sections/server-options.rst      |  769 +++
 doc/man-sections/signals.rst             |   30 +
 doc/man-sections/tls-options.rst         |  643 ++
 doc/man-sections/unsupported-options.rst |   33 +
 doc/man-sections/vpn-network-options.rst |  531 ++
 doc/man-sections/windows-options.rst     |  245 +
 doc/openvpn.8                            | 7659 ----------------------
 doc/openvpn.8.rst                        |  169 +
 30 files changed, 5835 insertions(+), 7674 deletions(-)
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
 create mode 100644 doc/man-sections/vpn-network-options.rst
 create mode 100644 doc/man-sections/windows-options.rst
 delete mode 100644 doc/openvpn.8
 create mode 100644 doc/openvpn.8.rst

-- 
2.26.0


