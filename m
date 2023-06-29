From: Arne Schwabe <arne@...1227...>
Date: Thu, 29 Jun 2023 23:56:06 +0200
Message-Id: <20230629215611.3292788-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/4] Restore ability to compile on
 macOS/FreeBSD with Cmake
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

The patches to the cmake files did a lot of improvements but broke compiling
on macOS and FreeBSD. This patch set restores the ability to compile again
with these two platforms.

Arne Schwabe (4):
  Do not blindly assume python3 is also the interpreter that runs
    rst2html
  [CMake] Only add -Wno-stringop-truncation on supported compilers
  Check if the -wrap argument is actually supported by the platform's ld
  Avoid unused function warning/error on FreeBSD

 CMakeLists.txt      | 33 +++++++++++++++++++++------------
 doc/CMakeLists.txt  |  8 ++++----
 src/openvpn/route.c |  4 +++-
 3 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.39.2 (Apple Git-143)


