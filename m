From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:29 +0100
Message-Id: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 0/8] Introduce ovpn-dco(-win) support
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
Cc: Antonio Quartulli <a@...2181...>

This is a first implementation of the ovpn-dco support in OpenVPN2.
It is sent as RFC because it is not intended for final review/merge, but
rather to collect additional feedback and allow users to test it.

This implementation supports both dco for Linux and for Windows.
* For Linux, please get the ovpn-dco kernel module source at:
https://gitlab.com/openvpn/ovpn-dco
(alternatively, it is also packaged on various distributions along with
OpenVPN3-for-Linux)

* For Windows, a snapshot of the driver can be found on:
https://github.com/OpenVPN/ovpn-dco-win/actions
(note that "test signing" must be enabled on your Windows box, for the
driver to be accepted. Instructions to enable this mode are here:
https://github.com/OpenVPN/ovpn-dco-win/blob/master/README.md#installation
DO IT AT YOUR OWN RISK)

In the meantime the code is still being rearranged a bit and a newer
version, including all collected feedback, will be sent later on.

Known expected changes are:
* refactoring of the networking API implementation
* tun open logic (i.e. merge it with the current logic used by other
  platforms)
* options handling

When running ./configure, if --enable-dco is specified, then
DCO_INCLUDEDIR must be defined and should point to where the ovpn-dco
header can be found.

For example, it can be configure'd like this:

./configure --enable-dco DCO_INCLUDEDIR=/path/to/include/uapi/

ovpn-dco is enabled opportunistically, which means that it is always on,
unless some conflicting option has been chosen (because ovpn-dco does not
support all known openvpn options) or if disabled explicitly.

Feel free to test/break/comment. Any input is highly appreciated.

Best Regards,




Antonio Quartulli (2):
  networking: silence warnings about unused arguments
  ovpn-dco: force user to set DCO_INCLUDEDIR

Arne Schwabe (5):
  networking: remove duplicate methods from networking_sitnl.c
  sitnl: implement net_iface_new and net_iface_del
  ovpn-dco: introduce linux data-channel offload support
  tun: extract close_tun_handle into its own fucntion and print correct
    type
  ovpn-dco-win: introduce windows data-channel offload support

Lev Stipakov (1):
  ovpn-dco-win: fix mingw i686 build

 Changes.rst                                   |   7 +
 README.dco.md                                 | 132 +++
 config-msvc.h                                 |  12 +-
 configure.ac                                  |  66 ++
 doc/man-sections/advanced-options.rst         |  13 +
 src/compat/Makefile.am                        |   3 +-
 src/compat/compat-dco_get_overlapped_result.c |  44 +
 src/compat/compat.h                           |   6 +
 src/compat/compat.vcxproj                     |   1 +
 src/compat/compat.vcxproj.filters             |   3 +
 src/openvpn/Makefile.am                       |   9 +-
 src/openvpn/crypto.c                          |  10 +
 src/openvpn/crypto.h                          |   6 +
 src/openvpn/dco.c                             | 272 ++++++
 src/openvpn/dco.h                             | 119 +++
 src/openvpn/errlevel.h                        |   2 +
 src/openvpn/event.h                           |   3 +
 src/openvpn/forward.c                         |  66 +-
 src/openvpn/init.c                            | 195 +++-
 src/openvpn/init.h                            |   2 +-
 src/openvpn/mtcp.c                            |  61 +-
 src/openvpn/mudp.c                            |  13 +
 src/openvpn/multi.c                           | 278 +++++-
 src/openvpn/multi.h                           |   6 +-
 src/openvpn/networking.h                      |  11 +-
 src/openvpn/networking_linuxdco.c             | 848 ++++++++++++++++++
 src/openvpn/networking_linuxdco.h             |  85 ++
 src/openvpn/networking_sitnl.c                | 116 ++-
 src/openvpn/networking_sitnl.h                |  28 +
 src/openvpn/networking_windco.c               | 306 +++++++
 src/openvpn/networking_windco.h               |  47 +
 src/openvpn/openvpn.vcxproj                   |   6 +-
 src/openvpn/openvpn.vcxproj.filters           |  12 +
 src/openvpn/options.c                         | 181 +++-
 src/openvpn/options.h                         |  41 +
 src/openvpn/socket.c                          | 125 ++-
 src/openvpn/socket.h                          |  58 +-
 src/openvpn/ssl.c                             |   6 +-
 src/openvpn/ssl_common.h                      |  13 +
 src/openvpn/ssl_ncp.c                         |   2 +-
 src/openvpn/tun.c                             | 130 ++-
 src/openvpn/tun.h                             |  60 +-
 tests/unit_tests/openvpn/test_networking.c    |  27 +-
 43 files changed, 3265 insertions(+), 166 deletions(-)
 create mode 100644 README.dco.md
 create mode 100644 src/compat/compat-dco_get_overlapped_result.c
 create mode 100644 src/openvpn/dco.c
 create mode 100644 src/openvpn/dco.h
 create mode 100644 src/openvpn/networking_linuxdco.c
 create mode 100644 src/openvpn/networking_linuxdco.h
 create mode 100644 src/openvpn/networking_windco.c
 create mode 100644 src/openvpn/networking_windco.h

-- 
2.32.0


