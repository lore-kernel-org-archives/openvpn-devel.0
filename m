From: Antonio Quartulli <a@...2181...>
Date: Fri, 14 Jan 2022 18:14:39 +0100
Message-Id: <20220114171446.26446-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC v2 0/7] Introduce ovpn-dco(-win) support
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

Hi all,

I am happy to publish the second version of the RFC ovpn-dco support!

This is going to be the *last RFC prototype* before submitting the code
for official review and (possible) merge.

For this reason, please have a look, test and speak up any concern you
may have!

The code has changed quite a lot compared to the previous RFC:
* DCO key handling has been refactored so that we now have two different
  functions for:
  - installing a new key into DCO
  - swapping keys after the new key is promoted to primary
  These two mechanisms were earlier combined in a key-dance function
  that now does not exist anymore.
* the DCO API has been cleaned up:
  - dco.h contains the DCO API that the rest of the OpenVPN code is
    supposed to invoke. These functions are some kind of glue code
    between OpenVPN and the real ovpn-dco(-win).
  - dco_internal.h contains the actual driver API. Its implementation
    is platform dependant and can be found in dco_win.c or dco_linux.c.
* DCO should happily work with both iproute2 and sitnl as it does not
  directly depend on either one. net_iface_new/del are now implemented
  in both backends.
* added Linux DCO build in our GitHub Actions script.

NOTE: the 'none' cipher is still supported but we're discussing whether
to drop support in ovpn-dco before the release.

NOTE2: this patchset requires the patch "tun: remove tun_finalize()" to
be applied on master first.

Linux DCO supports both client and server mode, while
Windows DCO works in client mode only.


Please test, break and have fun!!

Happy weekend!

----------------

As mentioned in the previous version:

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

-----------------

Antonio Quartulli (4):
  networking: silence warnings about unused arguments
  networking: implement net_iface_new and net_iface_del APIs
  ovpn-dco: introduce linux data-channel offload support
  GitHub Actions: add Linux DCO build (on Ubuntu 20.04)

Arne Schwabe (3):
  networking: remove duplicate methods from networking_sitnl.c
  tun: extract close_tun_handle into its own fucntion and print correct
    type
  ovpn-dco-win: introduce windows data-channel offload support

 .github/workflows/build.yaml                  |  19 +-
 Changes.rst                                   |   7 +
 README.dco.md                                 | 131 +++
 config-msvc.h                                 |   2 +
 configure.ac                                  |  34 +
 contrib/vcpkg-ports/ovpn-dco-win/CONTROL      |   3 +
 .../vcpkg-ports/ovpn-dco-win/portfile.cmake   |  14 +
 doc/man-sections/advanced-options.rst         |  13 +
 src/compat/Makefile.am                        |   3 +-
 src/compat/compat-dco_get_overlapped_result.c |  44 +
 src/compat/compat.h                           |   6 +
 src/compat/compat.vcxproj                     |   1 +
 src/compat/compat.vcxproj.filters             |   3 +
 src/openvpn/Makefile.am                       |   3 +
 src/openvpn/crypto.c                          |   1 +
 src/openvpn/dco.c                             | 631 +++++++++++++
 src/openvpn/dco.h                             | 279 ++++++
 src/openvpn/dco_internal.h                    |  85 ++
 src/openvpn/dco_linux.c                       | 869 ++++++++++++++++++
 src/openvpn/dco_linux.h                       |  60 ++
 src/openvpn/dco_win.c                         | 354 +++++++
 src/openvpn/dco_win.h                         |  59 ++
 src/openvpn/errlevel.h                        |   2 +
 src/openvpn/event.h                           |   3 +
 src/openvpn/forward.c                         |  59 +-
 src/openvpn/init.c                            | 163 +++-
 src/openvpn/init.h                            |   2 +-
 src/openvpn/misc.h                            |   3 +-
 src/openvpn/mtcp.c                            |  61 +-
 src/openvpn/mudp.c                            |  13 +
 src/openvpn/multi.c                           | 169 +++-
 src/openvpn/multi.h                           |   6 +-
 src/openvpn/networking.h                      |  36 +-
 src/openvpn/networking_iproute2.c             |  34 +
 src/openvpn/networking_sitnl.c                |  78 +-
 src/openvpn/openvpn.vcxproj                   |   8 +-
 src/openvpn/openvpn.vcxproj.filters           |  17 +-
 src/openvpn/options.c                         |  37 +-
 src/openvpn/options.h                         |  15 +
 src/openvpn/ovpn-dco-win.h                    | 107 +++
 src/openvpn/ovpn_dco_linux.h                  | 240 +++++
 src/openvpn/socket.c                          | 105 ++-
 src/openvpn/socket.h                          |  21 +-
 src/openvpn/ssl.c                             |  81 +-
 src/openvpn/ssl.h                             |   7 +-
 src/openvpn/ssl_common.h                      |  23 +
 src/openvpn/ssl_ncp.c                         |   2 +-
 src/openvpn/tun.c                             | 243 +++--
 src/openvpn/tun.h                             |  62 +-
 tests/unit_tests/openvpn/test_networking.c    |  25 +-
 50 files changed, 4005 insertions(+), 238 deletions(-)
 create mode 100644 README.dco.md
 create mode 100644 contrib/vcpkg-ports/ovpn-dco-win/CONTROL
 create mode 100644 contrib/vcpkg-ports/ovpn-dco-win/portfile.cmake
 create mode 100644 src/compat/compat-dco_get_overlapped_result.c
 create mode 100644 src/openvpn/dco.c
 create mode 100644 src/openvpn/dco.h
 create mode 100644 src/openvpn/dco_internal.h
 create mode 100644 src/openvpn/dco_linux.c
 create mode 100644 src/openvpn/dco_linux.h
 create mode 100644 src/openvpn/dco_win.c
 create mode 100644 src/openvpn/dco_win.h
 create mode 100644 src/openvpn/ovpn-dco-win.h
 create mode 100644 src/openvpn/ovpn_dco_linux.h

-- 
2.34.1


