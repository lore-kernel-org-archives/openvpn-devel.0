From: David Sommerseth <davids@...515...>
Date: Wed, 24 Jun 2020 20:07:30 +0200
Message-Id: <20200624180741.426-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/11] man-page overhaul project
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

This is the first real review round of the man-page overhaul project.
Since the n/groff based openvpn.8 format is fairly cumbersome to edit,
we agreed at the 2019 Hackathon in Trento to move the man page into
something more editing and management friendly.

This set of patches converts the openvpn.8 file into the
ReStructuredText format (.rst) which can easily be converted into both
man and html files using python-docutils.  The advantage of this format
is that it is easy to edit in any plain text editors and displays
reasonably well in any terminals.  And it will be easier to review
patches man page updates sent to the mailing list.

To avoid everyone building the OpenVPN source tarball to have the full
python stack available, the doc/Makefile.am file has been adopted to
generate the man and html files when we create the source tarball
we distribute in releases.  Only users only pulling down the source
directly from git will need to have python-docutils available.

As I worked my way through the man page, there were several things
which was less good.  Lots of options where misplaced in not related
sections, a few options where documented several places.  And lots
of the sections overlapped quite a bit.  From patch 5/11 splits
the whole man page into several smaller files; one file per section.
This is all tied into a single man-page/html file when running the
rst2man/rst2html tools.  The following patches just cleans up and
moves some options into more suitable sections.


I will continue to update my own git branch containing this work as
review comments come in until this is merged into master.  You can
find it here:

  https://gitlab.com/dazo/openvpn/-/tree/dev/man-reformatting/doc



kind regards,

David Sommerseth
OpenVPN Inc.



David Sommerseth (11):
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

 .gitignore                               |    1 +
 INSTALL                                  |    3 +-
 configure.ac                             |   15 +-
 doc/Makefile.am                          |   56 +-
 doc/README.man                           |   23 +
 doc/man-sections/advanced-options.rst    |  107 +
 doc/man-sections/client-options.rst      |  355 +
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
 doc/man-sections/plugin-options.rst      |   52 +
 doc/man-sections/protocol-options.rst    |  228 +
 doc/man-sections/proxy-options.rst       |   66 +
 doc/man-sections/renegotiation.rst       |   53 +
 doc/man-sections/script-options.rst      |  807 +++
 doc/man-sections/server-options.rst      |  769 +++
 doc/man-sections/signals.rst             |   30 +
 doc/man-sections/tls-options.rst         |  643 ++
 doc/man-sections/unsupported-options.rst |   33 +
 doc/man-sections/vpn-network-options.rst |  531 ++
 doc/man-sections/windows-options.rst     |  245 +
 doc/openvpn.8                            | 7631 ----------------------
 doc/openvpn.8.rst                        |  169 +
 30 files changed, 5794 insertions(+), 7646 deletions(-)
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


