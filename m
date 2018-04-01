From: Christian Hesse <list@...1798...>
Date: Sun,  1 Apr 2018 21:13:06 +0200
Message-Id: <20180401191309.32211-1-list@...1798...>
Subject: [Openvpn-devel] [RFC 0/3] follow-up netlink support,
 systemd integration
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>

This series is a follow-up to 'add netlink support for Linux' by Antonio
Quartulli. It enhances integration with systemd and improves system security
by running the openvpn process with a dedicated user.

Christian Hesse (3):
  systemd: run openvpn with dedicated user
  systemd: do not downgrade UID/GID
  systemd: create configuration directories from tmpfiles

 configure.ac                              | 8 ++++++++
 distro/systemd/Makefile.am                | 4 ++++
 distro/systemd/openvpn-client@...2221... | 4 +++-
 distro/systemd/openvpn-server@...2221... | 4 +++-
 distro/systemd/sysusers-openvpn.conf      | 1 +
 distro/systemd/tmpfiles-openvpn.conf      | 6 ++++--
 src/openvpn/init.c                        | 8 ++++++++
 7 files changed, 31 insertions(+), 4 deletions(-)

