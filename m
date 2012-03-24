From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:32 +0200
Message-Id: <1332575918-3384-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
Subject: [Openvpn-devel] [PATCH 0/6] build revolution
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

The last commit was partial, and done even if I NAK some of the patches.
As it seems my opinion of a patch of fellows nor mine is not taken
into consideration properly. I curious how process had been performed if
someone else had found a problem.

This also had been done while Samuli is in progress of creating a
different flow, and all parties involved are aware of this process.

I am sending the leftovers from my branch.

And stopping until bureaucracy is resolved.

Alon.

Alon Bar-Lev (6):
  build: ax_varargs.m4: fixups
  build: autoconf: misc sockets fixups
  tree: ChangeLog: add ident attribute
  build: msvc: upgrade to Visual Studio 2010 + fixups
  build: enable lzo by default
  build: windows: set vendor to openvpn project + cleanups

 .gitattributes                                 |    1 +
 .gitignore                                     |    2 +
 ChangeLog                                      |    2 +
 build/msvc/msvc-generate/Makefile.am           |    2 +-
 build/msvc/msvc-generate/msvc-generate.vcproj  |   74 ---
 build/msvc/msvc-generate/msvc-generate.vcxproj |   69 +++
 configure.ac                                   |   57 +-
 m4/ax_varargs.m4                               |   10 +-
 msvc-build.bat                                 |   27 +-
 msvc-dev.bat                                   |   19 +-
 msvc-env.bat                                   |    7 +-
 openvpn.sln                                    |   90 ++--
 src/compat/Makefile.am                         |    3 +-
 src/compat/compat.vcproj                       |  197 ------
 src/compat/compat.vcxproj                      |   87 +++
 src/compat/compat.vcxproj.filters              |   42 ++
 src/openvpn/Makefile.am                        |    3 +-
 src/openvpn/openvpn.vcproj                     |  777 ------------------------
 src/openvpn/openvpn.vcxproj                    |  261 ++++++++
 src/openvpn/openvpn.vcxproj.filters            |  458 ++++++++++++++
 src/openvpn/openvpn_win32_resources.rc         |    6 +-
 src/openvpnserv/Makefile.am                    |    3 +-
 src/openvpnserv/openvpnserv.vcproj             |  209 -------
 src/openvpnserv/openvpnserv.vcxproj            |  112 ++++
 src/openvpnserv/openvpnserv.vcxproj.filters    |   35 ++
 src/openvpnserv/openvpnserv_resources.rc       |    4 +-
 26 files changed, 1197 insertions(+), 1360 deletions(-)
 create mode 100644 .gitattributes
 delete mode 100644 build/msvc/msvc-generate/msvc-generate.vcproj
 create mode 100644 build/msvc/msvc-generate/msvc-generate.vcxproj
 delete mode 100644 src/compat/compat.vcproj
 create mode 100644 src/compat/compat.vcxproj
 create mode 100644 src/compat/compat.vcxproj.filters
 delete mode 100644 src/openvpn/openvpn.vcproj
 create mode 100644 src/openvpn/openvpn.vcxproj
 create mode 100644 src/openvpn/openvpn.vcxproj.filters
 delete mode 100644 src/openvpnserv/openvpnserv.vcproj
 create mode 100644 src/openvpnserv/openvpnserv.vcxproj
 create mode 100644 src/openvpnserv/openvpnserv.vcxproj.filters

-- 
1.7.3.4


