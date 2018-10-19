From: David Sommerseth <davids@...515...>
Date: Fri, 19 Oct 2018 17:56:34 +0200
Message-Id: <20181019155638.9498-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 0/4] struct argv overhaul - round 2+x
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

Since the hackathon a couple of weeks ago, I've picked up the work from
Heiko Hund which does a big overhaul on the struct argv patches [0].

This patchset is rebased on the latest master and with my review
comments embedded into Heikos patch.  This was only relevant for the big
're-implement argv_printf_*()' patch.

In addition, I've added a separate documentation patch which adds doxygen
comments to basically all functions in argv.c, trying to explain better
what each of these functions does.  To make the comment flow better, I
renamed a few variables and did minor refactoring changes on the coding
style.


--
kind regards,

David Sommerseth
OpenVPN Inc


David Sommerseth (1):
  Documented all the argv related code with minor refactoring

Heiko Hund (3):
  re-implement argv_printf_*()
  argv: do fewer memory re-allocations
  Add gc_arena to struct argv to save allocations

 src/openvpn/argv.c                   | 525 +++++++++++++++++----------
 src/openvpn/argv.h                   |   7 +-
 src/openvpn/console_systemd.c        |   2 +-
 src/openvpn/init.c                   |  15 +-
 src/openvpn/lladdr.c                 |   2 +-
 src/openvpn/multi.c                  |  10 +-
 src/openvpn/options.c                |   2 +-
 src/openvpn/plugin.c                 |   2 +-
 src/openvpn/route.c                  |  16 +-
 src/openvpn/socket.c                 |   4 +-
 src/openvpn/ssl_verify.c             |   6 +-
 src/openvpn/tun.c                    |  62 ++--
 tests/unit_tests/openvpn/test_argv.c | 118 +++++-
 13 files changed, 496 insertions(+), 275 deletions(-)

-- 
2.17.1


