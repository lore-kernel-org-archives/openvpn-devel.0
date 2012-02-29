From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:34:51 +0200
Message-Id: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 00/11] standalone package
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>

1. cleanup warnings.
2. new directory layout
3. rename TAP-Win32 -> TAP-Windows
4. build system.
5. installer.

Alon Bar-Lev (11):
  cleanup: rename tap-win32->src
  cleanup: OACR warnings
  cleanup: remove warnings of redefinition of macros
  debug: add DbgPrint support
  build: set default to newer ddk
  cleanup: replace TAP-Win32->TAP-Windows
  cleanup: rename common.h->tap-windows.h
  cleanup: add TAP_WIN prefix to exports
  cleanup: create .gitignore
  docs: add COPYING COPYRIGHT.GPL
  build: initial build

 .gitignore                     |   15 +
 COPYING                        |   40 +
 COPYRIGHT.GPL                  |  339 +++++
 _build.bat                     |   49 +
 build.bat                      |   55 +
 build/MSCV-VSClass3.cer        |   29 +
 build/msvc-generate.js         |  118 ++
 build/unix2dos.js              |   54 +
 build/vars.amd64.m4            |    2 +
 build/vars.i386.m4             |    2 +
 build/zip.js                   |   74 +
 config-env.bat.in              |   12 +
 configure.bat                  |   88 ++
 installer/StrStr.nsi           |   47 +
 installer/build.bat            |   88 ++
 installer/icon.ico             |  Bin 0 -> 22486 bytes
 installer/install-whirl.bmp    |  Bin 0 -> 25820 bytes
 installer/tap-windows.nsi      |  296 ++++
 src/MAKEFILE                   |    6 +
 src/OemWin2k.inf.in            |  187 +++
 src/SOURCES.in                 |   65 +
 src/config.h.in                |    9 +
 src/constants.h                |   52 +
 src/dhcp.c                     |  599 ++++++++
 src/dhcp.h                     |  164 +++
 src/endian.h                   |   35 +
 src/error.c                    |  385 +++++
 src/error.h                    |   88 ++
 src/hexdump.c                  |   69 +
 src/hexdump.h                  |   63 +
 src/instance.c                 |  241 +++
 src/lock.h                     |   75 +
 src/macinfo.c                  |  154 ++
 src/macinfo.h                  |   38 +
 src/mem.c                      |  186 +++
 src/proto.h                    |  224 +++
 src/prototypes.h               |  260 ++++
 src/resource.rc                |   62 +
 src/tap-windows.h              |   68 +
 src/tapdrvr.c                  | 3147 ++++++++++++++++++++++++++++++++++++++++
 src/types.h                    |  178 +++
 tap-win32/MAKEFILE             |    6 -
 tap-win32/SOURCES.in           |   64 -
 tap-win32/common.h             |   82 --
 tap-win32/constants.h          |   52 -
 tap-win32/dhcp.c               |  599 --------
 tap-win32/dhcp.h               |  164 ---
 tap-win32/endian.h             |   35 -
 tap-win32/error.c              |  378 -----
 tap-win32/error.h              |   88 --
 tap-win32/hexdump.c            |   69 -
 tap-win32/hexdump.h            |   63 -
 tap-win32/i386/OemWin2k.inf.in |  195 ---
 tap-win32/instance.c           |  241 ---
 tap-win32/lock.h               |   75 -
 tap-win32/macinfo.c            |  154 --
 tap-win32/macinfo.h            |   38 -
 tap-win32/mem.c                |  186 ---
 tap-win32/proto.h              |  224 ---
 tap-win32/prototypes.h         |  260 ----
 tap-win32/resource.rc          |   58 -
 tap-win32/tapdrvr.c            | 3146 ---------------------------------------
 tap-win32/types.h              |  178 ---
 version.m4                     |   11 +
 64 files changed, 7674 insertions(+), 6355 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 COPYING
 create mode 100644 COPYRIGHT.GPL
 create mode 100644 _build.bat
 create mode 100644 build.bat
 create mode 100644 build/MSCV-VSClass3.cer
 create mode 100644 build/msvc-generate.js
 create mode 100644 build/unix2dos.js
 create mode 100644 build/vars.amd64.m4
 create mode 100644 build/vars.i386.m4
 create mode 100644 build/zip.js
 create mode 100644 config-env.bat.in
 create mode 100644 configure.bat
 create mode 100755 installer/StrStr.nsi
 create mode 100644 installer/build.bat
 create mode 100755 installer/icon.ico
 create mode 100755 installer/install-whirl.bmp
 create mode 100755 installer/tap-windows.nsi
 create mode 100755 src/MAKEFILE
 create mode 100755 src/OemWin2k.inf.in
 create mode 100755 src/SOURCES.in
 create mode 100644 src/config.h.in
 create mode 100755 src/constants.h
 create mode 100755 src/dhcp.c
 create mode 100755 src/dhcp.h
 create mode 100755 src/endian.h
 create mode 100755 src/error.c
 create mode 100755 src/error.h
 create mode 100755 src/hexdump.c
 create mode 100755 src/hexdump.h
 create mode 100755 src/instance.c
 create mode 100755 src/lock.h
 create mode 100755 src/macinfo.c
 create mode 100755 src/macinfo.h
 create mode 100755 src/mem.c
 create mode 100755 src/proto.h
 create mode 100755 src/prototypes.h
 create mode 100755 src/resource.rc
 create mode 100755 src/tap-windows.h
 create mode 100755 src/tapdrvr.c
 create mode 100755 src/types.h
 delete mode 100755 tap-win32/MAKEFILE
 delete mode 100755 tap-win32/SOURCES.in
 delete mode 100755 tap-win32/common.h
 delete mode 100755 tap-win32/constants.h
 delete mode 100755 tap-win32/dhcp.c
 delete mode 100755 tap-win32/dhcp.h
 delete mode 100755 tap-win32/endian.h
 delete mode 100755 tap-win32/error.c
 delete mode 100755 tap-win32/error.h
 delete mode 100755 tap-win32/hexdump.c
 delete mode 100755 tap-win32/hexdump.h
 delete mode 100755 tap-win32/i386/OemWin2k.inf.in
 delete mode 100755 tap-win32/instance.c
 delete mode 100755 tap-win32/lock.h
 delete mode 100755 tap-win32/macinfo.c
 delete mode 100755 tap-win32/macinfo.h
 delete mode 100755 tap-win32/mem.c
 delete mode 100755 tap-win32/proto.h
 delete mode 100755 tap-win32/prototypes.h
 delete mode 100755 tap-win32/resource.rc
 delete mode 100755 tap-win32/tapdrvr.c
 delete mode 100755 tap-win32/types.h
 create mode 100644 version.m4

-- 
1.7.3.4


