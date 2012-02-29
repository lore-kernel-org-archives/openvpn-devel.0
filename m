From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:22:14 +0200
Message-Id: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [openvpn-gui 0/8] build rewrite
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

1. Some cleanups
2. Build rewrite, similar to openvpn build rewrite.

Alon Bar-Lev (8):
  cleanup: resolve unused parameter warnings
  cleanup: resolve warnings missing malloc include
  debug: fix debug under unicode
  cleanup: add missing stdlib.h
  cleanup: dos2unix res/openvpn-gui-res-fi.rc
  cleanup: dos2unix res/openvpn-gui-res-jp.rc
  cleanup: dos2unix OpenVPN GUI ReadMe.txt
  build: rework build

 .gitignore                |   39 +-
 Makefile.am               |  102 +++
 Makefile.in               |   57 --
 OpenVPN GUI ReadMe.txt    |  231 ------
 README                    |  231 ++++++
 acinclude.m4              |   87 ---
 bootstrap                 |    2 -
 build/ltrc.inc            |   23 +
 config.guess              | 1502 ---------------------------------------
 config.sub                | 1714 ---------------------------------------------
 configure.ac              |  107 ++--
 localization.c            |   12 +-
 main.c                    |   38 +-
 manage.c                  |    6 +
 manage.h                  |    2 +
 openvpn.c                 |   12 +-
 openvpn_config.c          |    5 +-
 options.c                 |    7 +-
 passphrase.c              |    5 +-
 proxy.c                   |    7 +-
 registry.c                |    4 +-
 res/openvpn-gui-res-fi.rc |  714 ++++++++++----------
 res/openvpn-gui-res-jp.rc |  682 +++++++++---------
 res/openvpn-gui-res.rc    |   11 +-
 scripts.c                 |    5 +-
 service.c                 |    5 +-
 tray.c                    |    5 +-
 viewlog.c                 |    5 +-
 28 files changed, 1244 insertions(+), 4376 deletions(-)
 create mode 100644 Makefile.am
 delete mode 100644 Makefile.in
 delete mode 100644 OpenVPN GUI ReadMe.txt
 create mode 100644 README
 delete mode 100644 acinclude.m4
 delete mode 100755 bootstrap
 create mode 100644 build/ltrc.inc
 delete mode 100755 config.guess
 delete mode 100755 config.sub
 create mode 100644 m4/.keep

-- 
1.7.3.4


